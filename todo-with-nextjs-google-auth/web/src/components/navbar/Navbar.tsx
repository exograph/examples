"use client";

import React, { useRef } from "react";
import Link from "next/link";
import { useAuth } from "@/components/auth/AuthProvider";
import MenuElements from "./MenuElements";
import { Logo } from "./Logo";
import { UserPicture } from "./UserPicture";

export default function NavBar() {
  const { user, logout } = useAuth();
  const container = useRef(null);

  return (
    <div className="navbar w-full" ref={container}>
      <div className="flex w-full justify-between lg:hidden">
        <label
          htmlFor="sidebar"
          className="flex h-12 w-12 cursor-pointer items-center justify-center"
        >
          <Logo />
        </label>
        <button type="button" className="flex p-0 text-sm focus:outline-none">
          <UserPicture user={user} />
        </button>
      </div>
      <div className="lg:mx-2 lg:flex-1 px-2">
        <Link href="/">
          <div className="flex flex-shrink-0 items-center">
            <div className="hidden w-auto lg:block">
              <Logo />
            </div>
          </div>
        </Link>
      </div>
      <div className="hidden flex-none lg:flex">
        <ul className="menu menu-horizontal">
          <MenuElements isDrawer={false} user={user} logout={logout} />
        </ul>
      </div>
    </div>
  );
}
