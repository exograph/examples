import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
} from "react";
import jwt_decode from "jwt-decode";
import { useRouter } from "next/navigation";
import { client } from "@/app/apollo-client";

export interface AuthUser {
  sub: number;
  firstName: string;
  lastName: string;
  email: string;
  role: string;
  profileImageUrl: string;
}

interface DecodedAuthUser extends AuthUser {
  exp: number;
}

type AuthContextInfo = {
  getUser: () => AuthUser | undefined;
  login: (token: string) => void;
  logout: () => void;
};

const AuthContext = createContext<AuthContextInfo | undefined>(undefined);

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<DecodedAuthUser | null>(null);
  const router = useRouter();

  function decodeToken(token: string): DecodedAuthUser | undefined {
    if (token) {
      const decoded: DecodedAuthUser = jwt_decode(token);
      if (Date.now() < decoded.exp * 1000) {
        return decoded;
      }
    }
  }

  function getUser(): AuthUser | undefined {
    if (user && Date.now() < user.exp * 1000) {
      return user;
    }
  }

  const login = useCallback(
    (token: string, redirectUrl?: string) => {
      const decoded = decodeToken(token);
      if (decoded) {
        setUser(decoded);
        localStorage.setItem("token", token);
        redirectUrl && router.replace(redirectUrl);
        return decoded;
      }
    },
    [setUser, router]
  );

  function logout() {
    setUser(null);
    localStorage.removeItem("token");
    client.cache.reset();
    router.replace("/login");
  }

  useEffect(() => {
    const token = localStorage.getItem("token");
    if (token) {
      const user = login(token);
      if (!user) {
        localStorage.removeItem("token");
      }
    }
  }, [login]);

  return (
    <AuthContext.Provider
      value={{
        getUser,
        login: (token: string, redirectUrl?: string) => {
          login(token, redirectUrl || "/");
        },
        logout,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth(): {
  user: AuthUser | undefined;
  login: (token: string, redirectUrl?: string) => void;
  logout: () => void;
} {
  const context = useContext(AuthContext);

  if (context === undefined) {
    throw new Error("useAuth must be used within a AuthProvider");
  }
  return {
    user: context.getUser(),
    login: context.login,
    logout: context.logout,
  };
}
