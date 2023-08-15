"use client";

import React, { useCallback, useState } from "react";
import { useLazyQuery } from "@apollo/client";
import {
  GoogleButton,
  GoogleCredentialResponse,
} from "@/components/auth/GoogleButton";
import { useAuth } from "@/components/auth/AuthProvider";
import { AccessResult } from "@/components/auth/Protected";
import { graphql } from "@/__generated__";
import Link from "next/link";

type LoginProps = {
  searchParams: { reason?: AccessResult; redirectUrl?: string };
};

export default function Login({
  searchParams: { reason, redirectUrl },
}: LoginProps) {
  const { login } = useAuth();
  const [error, setError] = useState<string | undefined>();

  const [loginGoogle] = useLazyQuery(loginQuery);

  const googleSignInCallback = useCallback(
    async (info: GoogleCredentialResponse) => {
      const { data, error } = await loginGoogle({
        variables: { code: info.credential },
      });
      if (data) {
        login(data.login, redirectUrl);
      } else {
        setError(error?.message);
      }
    },
    [loginGoogle, login, redirectUrl]
  );

  const authMessage = "Please login to access the page you requested.";
  const loginReason =
    reason === AccessResult.AuthNeeded ? authMessage : undefined;

  return (
    <div className="main-container max-xs:p-4 p-16">
      {loginReason && (
        <div className="mb-8 border-b-2 pb-6 text-center text-red-400">
          {loginReason}
        </div>
      )}
      <div className="mx-auto flex w-full flex-col items-center">
        <h2 className="mb-4">Login</h2>
        <div className="w-44 pb-10">
          <GoogleButton
            onCredentialResponse={googleSignInCallback}
            isSignUp={false}
          />
        </div>
        {error && <div className="pt-2 text-red-500">{error}</div>}
      </div>
      <div className="flex justify-center">
        Don&apos;t have an account?&nbsp;
        <Link href="/signup" className="text-blue-500">
          Sign Up
        </Link>
      </div>
    </div>
  );
}

const loginQuery = graphql(`
  query login($code: String!) {
    login(code: $code)
  }
`);
