"use client";

import React from "react";
import { AuthUser } from "@/components/auth/AuthProvider";
import { LoginMenu } from "./LoginMenu";

interface MenuElementsProps {
  isDrawer: boolean;
  user: AuthUser | undefined;
  logout: () => void;
}

export default function MenuElements({
  isDrawer,
  user,
  logout,
}: MenuElementsProps) {
  return (
    <>
      {user && (
        <li>
          <LoginMenu user={user} logout={logout} isDrawer={isDrawer} />
        </li>
      )}
    </>
  );
}
