import React from "react";
import { UserIcon } from "@heroicons/react/20/solid";
import { AuthUser } from "../auth/AuthProvider";

export type UserPictureProps = {
  user?: AuthUser;
};

export function UserPicture({ user }: UserPictureProps) {
  if (user?.profileImageUrl) {
    const name = `${user.firstName} ${user.lastName}`;
    return (
      <img
        className="h-8 w-8 rounded-full"
        src={user.profileImageUrl}
        alt={name}
      />
    );
  } else {
    return <UserIcon className="h-8 w-8 rounded-full" color="white" />;
  }
}
