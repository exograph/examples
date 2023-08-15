# Simple Todo Web Application

This is a todo application that uses the following technologies:

- [Exograph](https://exograph.dev) for the backend
- [Next.js](https://nextjs.org/) and [Tailwind](https://tailwindcss.com/) for the frontend

## Prerequisites

### Backend Requirements

Before setting up the backend, make sure you have the following:

- [Exograph](https://exograph.dev/docs/getting-started#install-exograph)
- [PostgreSQL](https://www.postgresql.org/download/) or [Docker](https://www.docker.com/products/docker-desktop)

### Frontend Requirements

For the frontend, ensure you have:

- [Node.js](https://nodejs.org/en/download/)

## Running the application

Clone this repository to your local machine and navigate to the root directory.

### Backend

1. Open a terminal window and navigate to the `api` directory:

```bash
cd api
```

#### Yolo mode

Initially, you can run the GraphQL server in yolo mode by running the following command:

```bash
exo yolo
```

#### Development mode

Alternatively, you can run the GraphQL server in development mode by running the following commands:

```bash
createdb todo-db
exo schema create | psql todo-db
exo dev
```

### Frontend

Open a new terminal window and run the following commands:

```bash
cd web
npm install
npm run generate
npm run dev
```

You can now access the application in your browser at http://localhost:3000 and start creating todos!
