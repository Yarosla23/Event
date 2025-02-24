// bubbles.js
document.addEventListener("DOMContentLoaded", function () {
    const bubblesContainer = document.getElementById("bubbles-container");
    const gradientElement = document.querySelector('.animate-gradient-background');
  
    function createBubble() {
      const bubble = document.createElement("div");
      const size = Math.random() * (150 - 40) + 40;
      const startX = Math.random() * window.innerWidth;
      const startY = window.innerHeight + size;
      const duration = Math.random() * (20 - 10) + 10;
      const delay = Math.random() * 5;
  
      bubble.classList.add("bubble");
      bubble.style.setProperty('--x', Math.random() * 100 - 50);
      bubble.style.width = `${size}px`;
      bubble.style.height = `${size}px`;
      bubble.style.left = `${startX}px`;
      bubble.style.top = `${startY}px`;
      bubble.style.animation = `bubbleAnimation ${duration}s ${delay}s infinite`;
  
      bubblesContainer.appendChild(bubble);
    }
  
    function resetAnimations() {
      const bubbles = bubblesContainer.querySelectorAll(".bubble");
      bubbles.forEach(bubble => {
        bubble.style.animation = 'none';
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            const duration = Math.random() * (20 - 10) + 10;
            const delay = Math.random() * 5;
            bubble.style.animation = `bubbleAnimation ${duration}s ${delay}s infinite`;
          });
        });
      });
  
      gradientElement.style.animation = 'none';
      requestAnimationFrame(() => {
        gradientElement.style.animation = 'gradientAnimation 15s ease infinite';
      });
    }
  
    for (let i = 0; i < 50; i++) {
      createBubble();
    }
  
    resetAnimations();
  });
  