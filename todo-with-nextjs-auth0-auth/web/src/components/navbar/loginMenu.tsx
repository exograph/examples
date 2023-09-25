import React, { RefObject } from "react";
import { UserIcon } from "@heroicons/react/20/solid";
import { User, useAuth0 } from "@auth0/auth0-react";
import { useDropdown } from "./useDropdown";

export function LoginMenu() {
  const [containerRef, actionRef, isOpen, close] = useDropdown();
  const { user, logout } = useAuth0();

  const onLogout = (e: React.MouseEvent) => {
    close();
    logout({
      openUrl: false,
    });
  };

  return (
    <div
      className="nav-sub-wrapper py-0"
      ref={containerRef as RefObject<HTMLDivElement>}
    >
      <button
        type="button"
        className="flex rounded-full p-0 text-sm focus:outline-none z-10"
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
          <a
            onClick={onLogout}
            className="nav-link nav-item nav-sub-link"
            role="menuitem"
            tabIndex={-1}
            id="user-menu-item-0"
          >
            Sign out
          </a>
        </div>
      )}
    </div>
  );
}

type UserPictureProps = {
  user: User | undefined;
};

function UserPicture({ user }: UserPictureProps) {
  if (user?.picture) {
    return (
      <img
        className="w-10 rounded-full text-center"
        src={user.picture}
        alt={user.name}
      />
    );
  } else {
    return <UserIcon className="h-8 w-8 rounded-full text-primary" />;
  }
}
