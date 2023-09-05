import React from "react";

type HeaderProps = {
  title: string;
  showSeparator?: boolean;
};

export default function PageHeader(props: HeaderProps) {
  return (
    <>
      <h2 className="text-center mb-6 text-4xl font-bold text-primary">
        {props.title}
      </h2>
      {props.showSeparator && <hr className="mb-4" />}
    </>
  );
}
