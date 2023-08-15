"use client";

import { ApolloProvider } from "@apollo/react-hooks";
import { client } from "./apollo-client";

export default function Providers({ children }: { children: React.ReactNode }) {
  return <ApolloProvider client={client}>{children}</ApolloProvider>;
}
