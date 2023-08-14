"use client";

import React, { useRef } from "react";
import { useAuth } from "@/components/auth/AuthProvider";
import MenuElements from "./MenuElements";
import NavBar from "./Navbar";
import { Logo } from "./Logo";

export default function Drawer({ children }: { children: React.ReactNode }) {
  const { user, logout } = useAuth();
  const drawerInput = useRef<HTMLInputElement | null>(null);

  const hideDrawer = () => {
    if (drawerInput.current) drawerInput.current.checked = false;
  };

  return (
    <div className="drawer">
      <input
        id="sidebar"
        type="checkbox"
        className="drawer-toggle"
        ref={drawerInput}
      />
      <div className="drawer-content flex flex-col">
        <>
          <NavBar />
          {children}
        </>
      </div>
      <div className="drawer-side">
        <label htmlFor="sidebar" className="drawer-overlay"></label>
        <ul className="w-1/3 navbar-drawer" onClick={hideDrawer}>
          <div className="flex h-12 w-12 mt-2 cursor-pointer items-center justify-center">
            <Logo />
          </div>
          <MenuElements isDrawer={true} user={user} logout={logout} />
        </ul>
      </div>
    </div>
  );
}
