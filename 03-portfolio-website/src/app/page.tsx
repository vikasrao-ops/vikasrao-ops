import Navbar from "../components/Navbar";
import Hero from "../components/Hero";
import Experience from "../components/Experience";
import FlagshipProjects from "../components/FlagshipProjects";
import PocLaboratory from "../components/PocLaboratory";
import ArchitectureShowcase from "../components/ArchitectureShowcase";
import Skills from "../components/Skills";
import Contact from "../components/Contact";
import Footer from "../components/Footer";

export default function Home() {
  return (
    <main className="min-h-screen bg-[#0B1120] text-[#F8FAFC]">
      <Navbar />
      <Hero />
      <Experience />
      <FlagshipProjects />
      <PocLaboratory />
      <ArchitectureShowcase />
      <Skills />
      <Contact />
      <Footer />
    </main>
  );
}

