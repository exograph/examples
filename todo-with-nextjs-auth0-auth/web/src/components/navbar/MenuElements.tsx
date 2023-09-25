"use client";

import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useAuth0 } from "@auth0/auth0-react";
import { LoginMenu } from "./loginMenu";

export default function MenuElements() {
  const { user, isAuthenticated } = useAuth0();
  const pathname = usePathname();
  const signInSelected = pathname.match("signin") ? "selected" : "";
  const signUpSelected = pathname.match("signup") ? "selected" : "";

  return (
    <div className="flex">
      {!user && (
        <Link href="/signin" className={`nav-link nav-item ${signInSelected}`} aria-current="page">
          Sign in
        </Link>
      )}
      {user && isAuthenticated && <LoginMenu />}
      {!user && (
        <Link href="/signup" className={`nav-link nav-item ${signUpSelected}`}>
          Sign up
        </Link>
      )}
    </div>
  );
}
