/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: { 
      colors: { 
        customBackground: '#1E1E1E', 
        headerColor: '#1C1C24',
      },
      screens: {
        'sm': '640px',
        'md': '768px',
        'lg': '1024px', // это стандартное значение
        'xl': '1280px',
        '2xl': '1536px',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
}
