# Multi-User Todo Web Application

This is a todo application that uses the following technologies:

- [Exograph](https://exograph.dev) for the backend
- [Next.js](https://nextjs.org/) and [Tailwind](https://tailwindcss.com/) for the frontend
- [Google Identity](https://developers.google.com/identity) for authentication

## Prerequisites

### Backend Requirements

Before setting up the backend, make sure you have the following:

- [Exograph](https://exograph.dev/docs/getting-started#install-exograph)
- [PostgreSQL](https://www.postgresql.org/download/) or [Docker](https://www.docker.com/products/docker-desktop)

### Frontend Requirements

For the frontend, ensure you have:

- [Node.js](https://nodejs.org/en/download/)

You'll also need to create a Google API Client ID by following these [instructions](https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid).

Once you have your Google API Client ID, copy the `,env.local.example` file to `.env.local` in the web directory. Then, update the NEXT_PUBLIC_GOOGLE_ID variable with your Google API Client ID.

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

You can now access the application in your browser at http://localhost:3000. You can sign in with your Google account and start creating todos!
