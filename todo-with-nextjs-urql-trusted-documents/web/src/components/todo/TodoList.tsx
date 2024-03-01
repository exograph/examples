"use client";

import React, { useEffect, useRef } from "react";
import TodoComponent from "./TodoComponent";
import { graphql } from "@/__generated__";
import { TodoDetailsFragment } from "@/__generated__/graphql";
import { CSSTransition, TransitionGroup } from "react-transition-group";
import { TodoStatus } from "./TodoStatus";
import { useMutation } from "urql";

type TodoDetailsWithId = { id: number } & TodoDetailsFragment;

interface TodoListProps {
  status: TodoStatus;
  todos: TodoDetailsWithId[] | undefined;
}

export default function TodoList({ status, todos }: TodoListProps) {
  const allowAnimation = useRef(false);

  const [_createResult, createTodoMutation] = useMutation(createTodo);
  const [_updateResult, updateTodoMutation] = useMutation(updateTodo);
  const [_deleteResult, deleteTodoMutation] = useMutation(deleteTodo);

  useEffect(() => {
    setTimeout(() => (allowAnimation.current = true), 700);
  }, []);

  if (!todos) return null;

  async function addItem(todo: TodoDetailsFragment) {
    await createTodoMutation({
      title: todo.title,
      completed: todo.completed,
    });
  }

  async function updateItem(id: number, todo: TodoDetailsFragment) {
    await updateTodoMutation({
      id,
      title: todo.title,
      completed: todo.completed,
    });
  }

  async function deleteItem(id: number) {
    await deleteTodoMutation({ id });
  }

  return (
    <div className="mx-auto bg-gray-100 dark:bg-slate-800 flex-col h-screen lg:w-1/2 w-full rounded-xl p-2 lg:p-12 border shadow-xl">
      <TransitionGroup
        name={allowAnimation.current ? "item-list" : ""}
        component="ul"
        className="list-none"
      >
        {todos.map(({ id, title, completed }) => {
          const todo = {
            title,
            completed,
            __typename: "Todo" as const,
          };
          return (
            <CSSTransition
              key={id}
              timeout={allowAnimation.current ? 700 : 0}
              classNames={allowAnimation.current ? "item" : ""}
            >
              <li className="flex items-center justify-center gap-2 py-3">
                <TodoComponent
                  id={id}
                  todo={todo}
                  addTodo={addItem}
                  updateTodo={updateItem}
                  deleteTodo={deleteItem}
                />
              </li>
            </CSSTransition>
          );
        })}
      </TransitionGroup>
      {status !== TodoStatus.Complete && (
        <div className="mt-4 flex items-center justify-center gap-2">
          <TodoComponent addTodo={addItem} updateTodo={updateItem} />
        </div>
      )}
    </div>
  );
}

export const TodoDetailsWithId = graphql(`
  fragment TodoDetailsWithId on Todo {
    id
    ...TodoDetails
  }
`);

export const TodoDetails = graphql(`
  fragment TodoDetails on Todo {
    title
    completed
  }
`);

const createTodo = graphql(`
  mutation createTodo($title: String!, $completed: Boolean!) {
    createTodo(data: { title: $title, completed: $completed }) {
      id
    }
  }
`);

const updateTodo = graphql(`
  mutation updateTodo($id: Int!, $title: String!, $completed: Boolean!) {
    updateTodo(id: $id, data: { title: $title, completed: $completed }) {
      id
    }
  }
`);

const deleteTodo = graphql(`
  mutation deleteTodo($id: Int!) {
    deleteTodo(id: $id) {
      id
    }
  }
`);
