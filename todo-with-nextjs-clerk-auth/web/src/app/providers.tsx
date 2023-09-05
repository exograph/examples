"use client";

import { ApolloProvider } from "@apollo/react-hooks";
import { ApolloClient, createHttpLink, InMemoryCache } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";
import { ClerkProvider, ClerkLoaded, useAuth } from "@clerk/clerk-react";
import { useMemo } from "react";

if (!process.env.NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY) {
  throw new Error("Missing Publishable Key");
}
const clerkPubKey = process.env.NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY;

export default function Providers({ children }: { children: React.ReactNode }) {
  return (
    <ClerkProvider publishableKey={clerkPubKey}>
      <ClerkLoaded>
        <ClerkApolloProvider>{children}</ClerkApolloProvider>
      </ClerkLoaded>
    </ClerkProvider>
  );
}

const httpLink = createHttpLink({
  uri: process.env.NEXT_PUBLIC_GRAPHQL_URL,
});

function ClerkApolloProvider({ children }: { children: React.ReactNode }) {
  const { getToken } = useAuth();

  const client = useMemo(() => {
    const authLink = setContext(async (_, { headers }) => {
      const token = await getToken();

      return {
        headers: {
          ...headers,
          authorization: token ? `Bearer ${token}` : "",
        },
      };
    });

    return new ApolloClient({
      link: authLink.concat(httpLink),
      cache: new InMemoryCache(),
      connectToDevTools: !!process.env.NEXT_PUBLIC_APOLLO_CONNECT_TO_DEV_TOOLS,
    });
  }, [getToken]);

  return <ApolloProvider client={client}>{children}</ApolloProvider>;
}
