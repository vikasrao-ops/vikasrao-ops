/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  output: "export", // Enables static HTML export for GitHub Pages or static host
  distDir: "out",
  images: {
    unoptimized: true,
  },
};

module.exports = nextConfig;

