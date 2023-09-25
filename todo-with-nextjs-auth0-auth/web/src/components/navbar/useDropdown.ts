import { RefObject, useCallback, useEffect, useRef, useState } from "react";

function onEscapeKeyPress(fn: Function) {
  const ESC_KEY = 27;
  return (keyCode: number) => (keyCode === ESC_KEY ? fn() : null);
}

export function useDropdown<T extends HTMLElement>(): [
  RefObject<T>,
  RefObject<T>,
  boolean,
  () => void
] {
  const [isOpen, setIsOpen] = useState(false);
  const ref = useRef<T>(null);
  const actionRef = useRef<T>(null);

  const close = useCallback(() => setIsOpen(false), []);

  useEffect(() => {
    const actionRefElement = actionRef.current;
    const handleGlobalMouseDown = (e: MouseEvent) => {
      if (!ref.current || ref.current.contains(e.target as Node)) {
        return;
      }
      close();
    };
    const handleToggle = () => {
      setIsOpen(!isOpen);
    };

    const handleGlobalKeydown = () => {
      onEscapeKeyPress(close);
    };

    if (actionRefElement) actionRefElement.addEventListener("mousedown", handleToggle);
    document.addEventListener("mousedown", handleGlobalMouseDown);
    document.addEventListener("keydown", handleGlobalKeydown);

    return () => {
      if (actionRefElement) actionRefElement.removeEventListener("mousedown", handleToggle);
      document.removeEventListener("mousedown", handleGlobalMouseDown);
      document.removeEventListener("keydown", handleGlobalKeydown);
    };
  }, [isOpen, setIsOpen, close]);

  return [ref, actionRef, isOpen, close];
}
