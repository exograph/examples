import "@/styles/globals.css";
import Providers from "./providers";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html>
      <head>
        <title>Exograph Simple Todo</title>
      </head>
      <body>
        <Providers>
          <main className="bg-white dark:bg-slate-900">{children}</main>
        </Providers>
      </body>
    </html>
  );
}
