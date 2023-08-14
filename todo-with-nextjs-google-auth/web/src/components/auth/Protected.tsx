import React from "react";
import { useEffect } from "react";
import { AuthUser, useAuth } from "@/components/auth/AuthProvider";
import { usePathname, useRouter } from "next/navigation";

export enum AccessResult {
  AuthNeeded = "auth-needed",
  Allowed = "allowed",
}

interface ProtectedProps {
  checkAccess: (user: AuthUser | undefined) => AccessResult;
  children: React.ReactNode;
}

export default function Protected({ checkAccess, children }: ProtectedProps) {
  const { user } = useAuth();
  const router = useRouter();
  const pathname = usePathname();
  const accessFailureCode = checkAccess(user);
  const haveAccess = accessFailureCode === AccessResult.Allowed;

  useEffect(() => {
    const timeout = setTimeout(() => {
      if (!haveAccess)
        router.push(
          `/login?reason=${accessFailureCode}&redirectUrl=${pathname}`
        );
    }, 1000);
    return () => clearTimeout(timeout);
  }, [router, haveAccess, accessFailureCode, pathname]);

  return <>{haveAccess && <>{children}</>}</>;
}
