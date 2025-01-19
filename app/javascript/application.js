import "@hotwired/turbo-rails"
import "controllers"
import "./bubbles";

function setupThemeToggle() {
  const themeToggleButton = document.getElementById('theme-toggle');
  if (!themeToggleButton) return;

  const savedTheme = localStorage.getItem('theme');
  const sunIcon = document.querySelector('[data-toggle-icon="sun"]');
  const moonIcon = document.querySelector('[data-toggle-icon="moon"]');
  
  if (savedTheme === 'dark') {
    document.documentElement.classList.add('dark');
    sunIcon.classList.add('hidden');
    moonIcon.classList.remove('hidden');
  } else {
    document.documentElement.classList.remove('dark');
    sunIcon.classList.remove('hidden');
    moonIcon.classList.add('hidden');
  }

  themeToggleButton.addEventListener('click', function() {
    const currentTheme = localStorage.getItem('theme');
    if (currentTheme === 'dark') {
      document.documentElement.classList.remove('dark');
      localStorage.setItem('theme', 'light');
      sunIcon.classList.remove('hidden');
      moonIcon.classList.add('hidden');
    } else {
      document.documentElement.classList.add('dark');
      localStorage.setItem('theme', 'dark');
      sunIcon.classList.add('hidden');
      moonIcon.classList.remove('hidden');
    }
  });
}

document.addEventListener('turbo:load', function() {
  setupThemeToggle();
});
