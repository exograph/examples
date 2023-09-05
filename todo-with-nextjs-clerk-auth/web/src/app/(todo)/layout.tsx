"use client";

import { RedirectToSignIn, SignedIn, SignedOut } from "@clerk/clerk-react";

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <SignedIn>{children}</SignedIn>
      <SignedOut>
        <div className="main-container max-xs:p-4 p-16">
          <div className="mx-auto flex w-full flex-col items-center">
            <div className="text-4xl font-bold pb-10">
              Exograph Clerk Integration
            </div>
            <div className="text-xl font-bold pb-4">
              A sample application to demonstrate how to use Clerk with
              Exograph.
            </div>
            <div className="text-xl">
              See the{" "}
              <a
                href="https://exograph.dev/blog/exograph-clerk"
                className="decoration-1 underline text-blue-500"
              >
                blog post
              </a>{" "}
              for more details.
            </div>
          </div>
        </div>
      </SignedOut>
    </>
  );
}
