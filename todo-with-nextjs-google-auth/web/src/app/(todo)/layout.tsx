"use client";

import { AuthUser } from "@/components/auth/AuthProvider";
import Protected, { AccessResult } from "@/components/auth/Protected";

function checkAuthUser(user: AuthUser | undefined): AccessResult {
  return user === undefined ? AccessResult.AuthNeeded : AccessResult.Allowed;
}

export default function TodoLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return <Protected checkAccess={checkAuthUser}>{children}</Protected>;
}
