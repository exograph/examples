"use client";

import React from "react";
import { SignIn } from "@clerk/clerk-react";

export default function Login() {
  return (
    <div className="main-container max-xs:p-4 p-16">
      <div className="mx-auto flex w-full flex-col items-center">
        <SignIn signUpUrl="/signup" />
      </div>
    </div>
  );
}
