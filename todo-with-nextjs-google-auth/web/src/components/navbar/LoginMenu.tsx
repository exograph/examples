import React, { FC, RefObject } from "react";
import { AuthUser } from "@/components/auth/AuthProvider";
import { useDropdown } from "./useDropdown";
import { UserPicture } from "./UserPicture";

type LoginMenuProps = {
  user?: AuthUser;
  logout: Function;
  isDrawer?: boolean;
};

export function LoginMenu({ user, logout, isDrawer }: LoginMenuProps) {
  const [containerRef, actionRef, isOpen, close] = useDropdown();

  const hideLogin = (e: React.MouseEvent) => {
    close();
    logout();
  };

  const subNav = (
    <a
      onClick={hideLogin}
      className={`nav-link nav-item ${!isDrawer ? "nav-sub-link" : ""}`}
      role="menuitem"
      tabIndex={-1}
      id="user-menu-item-0"
    >
      Sign out
    </a>
  );

  return (
    <>
      {isDrawer && subNav}
      {!isDrawer && (
        <div
          className="nav-sub-wrapper py-0  hover:bg-transparent"
          ref={containerRef as RefObject<HTMLDivElement>}
        >
          <button
            type="button"
            className="flex p-0 text-sm focus:outline-none"
            id="user-menu-button"
            aria-expanded="false"
            aria-haspopup="true"
            ref={actionRef as RefObject<HTMLButtonElement>}
          >
            <UserPicture user={user} />
          </button>
          {isOpen && (
            <div
              className="navbar-sub login min-h-0"
              role="menu"
              aria-orientation="vertical"
              aria-labelledby="user-menu-button"
              tabIndex={-1}
            >
              {subNav}
            </div>
          )}
        </div>
      )}
    </>
  );
}
