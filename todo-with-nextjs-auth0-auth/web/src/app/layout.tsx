import "@/styles/globals.css";
import Providers from "./providers";
import NavBar from "@/components/navbar/Navbar";

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html>
      <head>
        <title>Exograph Todo App with Auth0 Authentication</title>
      </head>
      <body>
        <Providers>
          <NavBar />
          <main className="bg-white dark:bg-slate-900 dark:text-gray-300">{children}</main>
        </Providers>
      </body>
    </html>
  );
}
