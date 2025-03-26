import "@hotwired/turbo-rails"
import "controllers"
import "./bubbles";

function setupThemeToggle() {
  const themeToggleButtons = document.querySelectorAll('#theme-toggle, #mobile-theme-toggle');
  if (themeToggleButtons.length === 0) return;

  const savedTheme = localStorage.getItem('theme');
  const sunIcons = document.querySelectorAll('[data-toggle-icon="sun"]');
  const moonIcons = document.querySelectorAll('[data-toggle-icon="moon"]');
  
  if (savedTheme === 'dark') {
    document.documentElement.classList.add('dark');
    sunIcons.forEach(icon => icon.classList.add('hidden'));
    moonIcons.forEach(icon => icon.classList.remove('hidden'));
  } else {
    document.documentElement.classList.remove('dark');
    sunIcons.forEach(icon => icon.classList.remove('hidden'));
    moonIcons.forEach(icon => icon.classList.add('hidden'));
  }

  themeToggleButtons.forEach(button => {
    button.addEventListener('click', function() {
      const currentTheme = localStorage.getItem('theme');
      if (currentTheme === 'dark') {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('theme', 'light');
        sunIcons.forEach(icon => icon.classList.remove('hidden'));
        moonIcons.forEach(icon => icon.classList.add('hidden'));
      } else {
        document.documentElement.classList.add('dark');
        localStorage.setItem('theme', 'dark');
        sunIcons.forEach(icon => icon.classList.add('hidden'));
        moonIcons.forEach(icon => icon.classList.remove('hidden'));
      }
    });
  });
}

document.addEventListener('turbo:load', function() {
  setupThemeToggle();
});
