"use client";

import React from "react";
import Link from "next/link";
import MenuElements from "./MenuElements";
import { Logo } from "./Logo";

export default function NavBar() {
  return (
    <div className="navbar w-full flex items-center justify-between">
      <Link href="/">
        <Logo />
      </Link>
      <MenuElements />
    </div>
  );
}
