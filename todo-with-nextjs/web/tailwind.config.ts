import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        'primary': '#6640af',
        'primary-dark': '#663a8a',
        'secondary': '#770051',
        'secondary-dark': '#00002d',
      },
    },
  },
  plugins: [
  ],
}
export default config
