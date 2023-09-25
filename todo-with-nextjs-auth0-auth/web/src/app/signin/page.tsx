"use client";

import React from "react";
import { useAuth0 } from "@auth0/auth0-react";

export default function Login() {
  const { loginWithRedirect } = useAuth0();

  return (
    <div className="main-container max-xs:p-4 p-16">
      <div className="mx-auto flex w-full flex-col items-center">
        <button
          className="p-3 bg-secondary text-white flex items-center"
          onClick={() =>
            loginWithRedirect({
              authorizationParams: {
                redirect_uri: window.location.origin,
              },
              openUrl(url) {
                window.location.replace(url);
              },
            })
          }
        >
          Sign in with Auth0
        </button>
      </div>
    </div>
  );
}
