"use client";

export default function Home() {
  return (
    <main className="home">
      <header className="header">
        <h1>Welcome to Decentral Craft</h1>
        <p>
          Decentral Craft is a platform for designers and manufacturers to
          collaborate on innovative product designs.
        </p>
        <a href="#">Submit Your Designs</a>
      </header>
      <section className="features">
        <h2>Features</h2>
        <ul>
          <li>Submit your product designs securely</li>
          <li>View Published Designs</li>
          <li>Connect with Manufacturers</li>
          <li>Quality control assurance</li>
          <li>Dispute resolution mechanism</li>
          <li>Earn incentives for contributing</li>
        </ul>
      </section>
      <section className="description">
        <h2>Description</h2>
        <p>
          Decentral Craft is your platform for securely submitting and
          showcasing product designs. We ensure the integrity of designs through
          quality control and offer a transparent dispute resolution mechanism.
          Earn incentives for your contributions and be part of our growing
          community of designers.
        </p>
      </section>
    </main>
  );
}
