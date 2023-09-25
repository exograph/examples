# Todo Web Application with Auth0 Authentication

[Read the accompanying blog post](https://exograph.dev/blog/exograph-auth0)

A todo application that uses the following technologies:

- [Exograph](https://exograph.dev) for the backend
- [Next.js](https://nextjs.org/) and [Tailwind](https://tailwindcss.com/) for the frontend
- [Auth0](https://auth0.com) for authentication

## Prerequisites

### Backend Requirements

- [Exograph](https://exograph.dev/docs/getting-started#install-exograph)
- [PostgreSQL](https://www.postgresql.org/download/) or [Docker](https://www.docker.com/products/docker-desktop)

### Frontend Requirements

- [Node.js](https://nodejs.org/en/download/)

You'll also need to create an Auth0 project by following these [instructions](https://auth0.com/docs/quickstart/spa/react/interactive).

## Running the application

Clone this repository to your local machine and navigate to the `todo-with-nextjs-auth0-auth` directory.

### Backend

Open a new terminal window and run the following commands:

```bash
cd api
EXO_JWKS_ENDPOINT=https://<...>.auth0.com/.well-known/jwks.json exo yolo
```

### Frontend

**Copy the `.env.local.example` file to `.env.local` in the web directory. Then, update the `NEXT_PUBLIC_AUTH0_DOMAIN` and `NEXT_PUBLIC_AUTH0_CLIENT_ID` variable with your Auth0 projects's values.**

Open a new terminal window and run the following commands:

```bash
cd web
npm install
npm run dev
```

You can now access the application in your browser at http://localhost:3000. You can sign in with your Google account and start creating todos!

## Next steps

- Explore the playground. Visit http://localhost:9876 to access the GraphQL playground. There, you can authenticate using the built-in UI. See the [blog post](https://exograph.dev/blog/exograph-auth0) for more details.
- [Explore the development mode](https://exograph.dev/docs/application-tutorial/local-server). Yolo mode used so far is great for getting started, but if you had to restart the server, you would lose all your data. Development mode allows you to persist your data between restarts.
- [Deploy your application](https://exograph.dev/docs/deployment/). Once you are happy with your application, you can deploy it to any cloud provider supporting Docker containers. You can also deploy it to AWS Lambda.
