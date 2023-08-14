import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";

/**
 * @param href the target url
 * @param name the name to be displayed
 * @param isLeaf is this item a leaf item (and not a group)
 */
type NavItemProps = {
  href: string;
  name: string;
  isLeaf?: boolean;
};

export function NavItem({ href, name, isLeaf }: NavItemProps) {
  const pathname = usePathname();
  const isActive = isLeaf ? pathname === href : pathname?.startsWith(href);
  const selectedClass = isActive ? "selected" : "";

  return (
    <Link
      href={href}
      className={`nav-link nav-item ${selectedClass}`}
      aria-current="page"
    >
      {name}
    </Link>
  );
}
