"use client";

import React, { useRef } from "react";
import Link from "next/link";
import MenuElements from "./MenuElements";
import { Logo } from "./Logo";
import { useAuth, useUser } from "@clerk/clerk-react";

export default function NavBar() {
  const { signOut } = useAuth();
  const { user } = useUser();

  return (
    <div className="navbar w-full flex items-center justify-between">
      <Link href="/">
        <Logo />
      </Link>
      <MenuElements user={user} logout={signOut} />
    </div>
  );
}
