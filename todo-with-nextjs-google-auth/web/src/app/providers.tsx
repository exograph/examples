"use client";

import { AuthProvider } from "@/components/auth/AuthProvider";
import { ApolloProvider } from "@apollo/react-hooks";
import { client } from "./apollo-client";

export default function Providers({ children }: { children: React.ReactNode }) {
  return (
    <AuthProvider>
      <ApolloProvider client={client}>{children}</ApolloProvider>
    </AuthProvider>
  );
}
