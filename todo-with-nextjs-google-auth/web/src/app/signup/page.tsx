"use client";

import React, { useCallback, useState } from "react";
import { useMutation } from "@apollo/client";
import {
  GoogleButton,
  GoogleCredentialResponse,
} from "@/components/auth/GoogleButton";
import { useAuth } from "@/components/auth/AuthProvider";
import PageHeader from "@/components/common/PageHeader";
import { graphql } from "@/__generated__";
import Link from "next/link";

export default function Signup() {
  const { login } = useAuth();
  const [error, setError] = useState<string | undefined>();

  const [signup] = useMutation(signupMutation);

  const googleSignupCallback = useCallback(
    async (info: GoogleCredentialResponse) => {
      try {
        const { data } = await signup({
          variables: { code: info.credential },
        });
        if (data) {
          login(data.signup, "/");
        }
      } catch (e) {
        setError((e as Error).message);
      }
    },
    [signup, login]
  );

  return (
    <div className="main-container max-xs:p-4 p-16">
      <div className="mx-auto flex w-full flex-col items-center">
        <h2 className="mb-4">Login</h2>
        <div className="w-44 pb-10">
          <GoogleButton
            onCredentialResponse={googleSignupCallback}
            isSignUp={true}
          />
        </div>
        {error && <div className="pt-2 text-red-500">{error}</div>}
      </div>
      <div className="flex justify-center">
        Already have an account?&nbsp;
        <Link href="/login" className="text-blue-500">
          Sign Up
        </Link>
      </div>
    </div>
  );
}

const signupMutation = graphql(`
  mutation signup($code: String!) {
    signup(code: $code)
  }
`);
