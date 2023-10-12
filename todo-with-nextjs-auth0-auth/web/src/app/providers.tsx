"use client";

import { ApolloProvider } from "@apollo/react-hooks";
import { ApolloClient, createHttpLink, InMemoryCache } from "@apollo/client";
import { setContext } from "@apollo/client/link/context";
import { useMemo } from "react";
import { Auth0Provider, useAuth0 } from "@auth0/auth0-react";

if (!process.env.NEXT_PUBLIC_AUTH0_DOMAIN) {
  throw new Error("Missing Auth0 domain");
}
if (!process.env.NEXT_PUBLIC_AUTH0_CLIENT_ID) {
  throw new Error("Missing Auth0 client ID");
}

const auth0Domain = process.env.NEXT_PUBLIC_AUTH0_DOMAIN;
const auth0ClientId = process.env.NEXT_PUBLIC_AUTH0_CLIENT_ID;

export default function Providers({ children }: { children: React.ReactNode }) {
  return (
    <Auth0Provider
      domain={auth0Domain}
      clientId={auth0ClientId}
      useRefreshTokens={true}
      cacheLocation="localstorage"
      authorizationParams={{
        audience: `https://${auth0Domain}/api/v2/`,
        scope: "profile",
      }}
    >
      <Auth0ApolloProvider>{children}</Auth0ApolloProvider>
    </Auth0Provider>
  );
}

const httpLink = createHttpLink({
  uri: process.env.NEXT_PUBLIC_GRAPHQL_URL,
});

function Auth0ApolloProvider({ children }: { children: React.ReactNode }) {
  const { getAccessTokenSilently } = useAuth0();

  const client = useMemo(() => {
    const authLink = setContext(async (_, { headers }) => {
      const token = await getAccessTokenSilently();

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
  }, [getAccessTokenSilently]);

  return <ApolloProvider client={client}>{children}</ApolloProvider>;
}
