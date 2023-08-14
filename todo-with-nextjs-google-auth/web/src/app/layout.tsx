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
        <title>Exograph Multi-User Todo</title>
      </head>
      <body>
        <Providers>
          <Drawer>
            <main>{children}</main>
          </Drawer>
        </Providers>
      </body>
    </html>
  );
}
