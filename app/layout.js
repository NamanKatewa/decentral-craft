import Navbar from "./components/Navbar";
import "./globals.scss";

export const metadata = {
  title: "Decentral Craft",
  description: "",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        <Navbar />
        {children}
      </body>
    </html>
  );
}
