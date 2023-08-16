"use client";

import { useQuery } from "@apollo/client";
import { getFragmentData, graphql } from "@/__generated__";
import { TodoDetailsFragment } from "@/__generated__/graphql";
import TodoList, {
  TodoDetails,
  TodoDetailsWithId,
} from "@/components/todo/TodoList";
import { useEffect, useState } from "react";
import { TodoStatus } from "@/components/todo/TodoStatus";

type TodoDetailsWithId = { id: number } & TodoDetailsFragment;

export default function Page() {
  const [status, setStatus] = useState<TodoStatus>(TodoStatus.InComplete);

  let todoQuery;
  if (status === TodoStatus.InComplete) {
    todoQuery = {
      query: getTodosByCompletion,
      variables: { completed: false },
    };
  } else if (status === TodoStatus.Complete) {
    todoQuery = {
      query: getTodosByCompletion,
      variables: { completed: true },
    };
  } else {
    todoQuery = { query: getTodos };
  }

  const refetchQuery = {
    refetchQueries: [
      { query: todoQuery.query, variables: todoQuery.variables },
    ],
  };

  const { data, loading, refetch } = useQuery(todoQuery.query, {
    variables: todoQuery.variables,
  });

  useEffect(() => {
    refetch();
  }, [status, refetch]);

  if (!data || loading) return null;
  const todos = data?.todos.map((todoItem) => {
    const todo = getFragmentData(TodoDetails, todoItem);
    return { id: todoItem.id, ...todo } as TodoDetailsWithId;
  });

  function handleStateChange(e: React.MouseEvent, status: TodoStatus) {
    setStatus(status);
  }

  const commonClasses =
    "mr-6 ml-6 flex h-10 w-24 items-center justify-center rounded-md text-xl dark:text-white";

  return (
    <div className="flex flex-col h-screen items-center justify-between p-2 pt-24 pb-6">
      <div className="mb-5 flex justify-center">
        <button
          className={
            commonClasses +
            " bg-indigo-400 hover:bg-indigo-500 shadow-indigo-400/50" +
            (status === TodoStatus.InComplete ? " shadow-xl" : "")
          }
          onClick={(e) => handleStateChange(e, TodoStatus.InComplete)}
        >
          Todo
        </button>
        <button
          className={
            commonClasses +
            " bg-blue-400 hover:bg-blue-500 shadow-blue-400/50" +
            (status === TodoStatus.Complete ? " shadow-xl" : "")
          }
          onClick={(e) => handleStateChange(e, TodoStatus.Complete)}
        >
          Done
        </button>
        <button
          className={
            commonClasses +
            " bg-green-400 hover:bg-green-500 shadow-green-400/50" +
            (status === TodoStatus.All ? " shadow-xl" : "")
          }
          onClick={(e) => handleStateChange(e, TodoStatus.All)}
        >
          All
        </button>
      </div>

      <TodoList
        key={status}
        status={status}
        todos={todos}
        refetchQuery={refetchQuery}
      />
    </div>
  );
}

const getTodosByCompletion = graphql(`
  query getTodosByCompletion($completed: Boolean!) {
    todos(where: { completed: { eq: $completed } }, orderBy: { id: ASC }) {
      id
      ...TodoDetails
    }
  }
`);

const getTodos = graphql(`
  query getTodos {
    todos(orderBy: { id: ASC }) {
      id
      ...TodoDetails
    }
  }
`);
