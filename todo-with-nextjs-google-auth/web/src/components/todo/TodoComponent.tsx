import React, { useState } from "react";
import { PlusIcon, TrashIcon } from "@heroicons/react/24/solid";
import { useAuth } from "@/components/auth/AuthProvider";
import { TodoDetailsFragment } from "@/__generated__/graphql";

interface TodoProps {
  id?: number;
  todo?: TodoDetailsFragment;
  addTodo: (todo: TodoDetailsFragment) => void;
  updateTodo: (id: number, todo: TodoDetailsFragment) => void;
  deleteTodo?: (id: number) => void;
}

const newTodo: TodoDetailsFragment = {
  title: "",
  completed: false,
};

export default function TodoComponent(props: TodoProps) {
  const { user } = useAuth();

  if (!user?.sub) return null;

  const { id, todo, addTodo, updateTodo, deleteTodo } = props;
  const [currentTodo, setCurrentTodo] = useState(todo || newTodo);
  const [isEditable, setEditable] = useState(!id);

  function changeTitle(e: React.ChangeEvent<HTMLInputElement>) {
    const updatedTodo = { ...currentTodo, title: e.currentTarget.value };
    setCurrentTodo(updatedTodo);
  }

  function changeCompleted() {
    const updatedTodo = { ...currentTodo, completed: !currentTodo.completed };
    setCurrentTodo(updatedTodo);
    if (id) updateTodo(id, updatedTodo);
  }

  function addNewTodo() {
    addTodo(currentTodo);
    setCurrentTodo(newTodo);
  }

  function handleEnterKey(e: React.KeyboardEvent) {
    if (e.key === "Enter") {
      if (!id) {
        addNewTodo();
      } else {
        updateTodo(id, currentTodo);
        setEditable(false);
      }
    }
  }

  function handleDoubleClick(e: React.MouseEvent) {
    if (e.detail === 2) {
      e.preventDefault();
      setEditable(true);
    }
  }

  function handleBlur() {
    if (id) updateTodo(id, currentTodo);
    setEditable(!id);
  }

  return (
    <>
      <input
        className={id ? "visible" : "invisible"}
        type="checkbox"
        checked={currentTodo.completed}
        onChange={changeCompleted}
      />
      <input
        className="min-w-[18rem] border-b-2 border-gray-300 bg-transparent pl-1 focus:outline-none max-sm:max-w-[12rem]"
        placeholder="Add new item..."
        onChange={changeTitle}
        onKeyUp={handleEnterKey}
        onMouseDown={handleDoubleClick}
        onBlur={handleBlur}
        value={currentTodo.title}
        autoFocus={true}
        readOnly={!isEditable}
      ></input>
      <div className="flex">
        {!id && (
          <button onClick={() => addNewTodo()}>
            <PlusIcon className="h-5 w-5 text-green-700 hover:text-green-900" />
          </button>
        )}
        {deleteTodo && id && (
          <button onClick={() => deleteTodo(id)}>
            <TrashIcon className="h-5 w-5 text-red-500 hover:text-red-600" />
          </button>
        )}
      </div>
    </>
  );
}
