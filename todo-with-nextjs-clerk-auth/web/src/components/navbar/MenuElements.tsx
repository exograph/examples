"use client";

import React from "react";
import { UserResource } from "@clerk/types/dist/user";
import Link from "next/link";
import { UserButton } from "@clerk/clerk-react";
import { usePathname } from "next/navigation";

interface MenuElementsProps {
  user: UserResource | null | undefined;
  logout: () => void;
}

export default function MenuElements({ user }: MenuElementsProps) {
  const pathname = usePathname();
  const signInSelected = pathname.match("signin") ? "selected" : "";
  const signUpSelected = pathname.match("signup") ? "selected" : "";

  return (
    <div className="flex">
      {!user && (
        <Link
          href="/signin"
          className={`nav-link nav-item ${signInSelected}`}
          aria-current="page"
        >
          Sign in
        </Link>
      )}
      {user && (
        <div className="p-0 hover:bg-transparent">
          <UserButton afterSignOutUrl="/signin" />
        </div>
      )}
      {!user && (
        <Link href="/signup" className={`nav-link nav-item ${signUpSelected}`}>
          Sign up
        </Link>
      )}
    </div>
  );
}
