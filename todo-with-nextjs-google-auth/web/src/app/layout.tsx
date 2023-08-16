import "@/styles/globals.css";
import Drawer from "@/components/navbar/Drawer";
import Providers from "./providers";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html>
      <head>
        <title>Exograph Todo App with Authentication</title>
      </head>
      <body>
        <Providers>
          <Drawer>
            <main className="bg-white dark:bg-slate-900 dark:text-gray-300">
              {children}
            </main>
          </Drawer>
        </Providers>
      </body>
    </html>
  );
}
