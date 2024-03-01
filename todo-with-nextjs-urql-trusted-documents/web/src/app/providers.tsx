"use client";

import { client } from "./urql-client";
import { Provider as UrqlProvider } from "urql";

export default function Providers({ children }: { children: React.ReactNode }) {
  return <UrqlProvider value={client}>{children}</UrqlProvider>;
}
