import React from "react";
import Image from "next/image";

export function Logo() {
  return (
    <Image
      src="/logo.svg"
      width={30}
      height={30}
      alt="Exograph Todo"
      priority
    />
  );
}
