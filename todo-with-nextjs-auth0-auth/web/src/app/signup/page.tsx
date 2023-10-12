"use client";

import { useAuth0 } from "@auth0/auth0-react";

import React from "react";

export default function Signup() {
  const { loginWithRedirect } = useAuth0();

  return (
    <div className="main-container max-xs:p-4 p-16">
      <div className="mx-auto flex w-full flex-col items-center">
        <button
          className="p-3 bg-secondary text-white flex items-center"
          onClick={() => loginWithRedirect()}
        >
          Sign up with Auth0
        </button>
      </div>
    </div>
  );
}
