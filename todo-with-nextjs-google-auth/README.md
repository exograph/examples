# Todo Web Application with Authentication

A todo application that uses the following technologies:

- [Exograph](https://exograph.dev) for the backend
- [Next.js](https://nextjs.org/) and [Tailwind](https://tailwindcss.com/) for the frontend
- [Google Identity](https://developers.google.com/identity) for authentication

## Prerequisites

### Backend Requirements

- [Exograph](https://exograph.dev/docs/getting-started#install-exograph)
- [PostgreSQL](https://www.postgresql.org/download/) or [Docker](https://www.docker.com/products/docker-desktop)

### Frontend Requirements

- [Node.js](https://nodejs.org/en/download/)

You'll also need to create a Google API Client ID by following these [instructions](https://developers.google.com/identity/gsi/web/guides/get-google-api-clientid).

## Running the application

Clone this repository to your local machine and navigate to the `todo-with-nextjs-google-auth` directory.

### Backend

Open a new terminal window and run the following commands:

```bash
cd api
exo yolo
```

### Frontend

**Copy the `.env.local.example` file to `.env.local` in the web directory. Then, update the `NEXT_PUBLIC_GOOGLE_ID` variable with the Google API Client ID.**

Open a new terminal window and run the following commands:

```bash
cd web
npm install
npm run dev
```

You can now access the application in your browser at http://localhost:3000. You can sign in with your Google account and start creating todos!

## Next steps

- [Explore the development mode](https://exograph.dev/docs/application-tutorial/local-server). Yolo mode used so far is great for getting started, but if you had to restart the server, you would lose all your data. Development mode allows you to persist your data between restarts.
- [Deploy your application](https://exograph.dev/docs/deployment/). Once you are happy with your application, you can deploy it to any cloud provider supporting Docker containers. You can also deploy it to AWS Lambda.
