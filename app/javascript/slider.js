
const prevBtn = document.getElementById('prevBtn');
const nextBtn = document.getElementById('nextBtn');
const fullscreenBtn = document.getElementById('fullscreenBtn');
const thumbnails = document.querySelectorAll('.thumbnail');
const slider = document.getElementById('slider');
const slides = document.querySelectorAll('#slider > div');
let currentIndex = 0;

// Функция для обновления слайдера
function updateSlider() {
const offset = -currentIndex * 100;
slider.style.transform = `translateX(${offset}%)`;

// Обновляем состояние кнопок
prevBtn.disabled = currentIndex === 0;
nextBtn.disabled = currentIndex === slides.length - 1;

// Обновляем стиль миниатюр
thumbnails.forEach((thumbnail, index) => {
    thumbnail.style.borderColor = index === currentIndex ? 'gray' : 'transparent';
});
}

// Навигация по слайдам
prevBtn.addEventListener('click', () => {
if (currentIndex > 0) {
    currentIndex--;
    updateSlider();
}
});

nextBtn.addEventListener('click', () => {
if (currentIndex < slides.length - 1) {
    currentIndex++;
    updateSlider();
}
});

thumbnails.forEach(thumbnail => {
thumbnail.addEventListener('click', () => {
    currentIndex = parseInt(thumbnail.dataset.index);
    updateSlider();
});
});

fullscreenBtn.addEventListener('click', () => {
const fullscreenElement = slider.parentElement;
if (fullscreenElement.requestFullscreen) {
    fullscreenElement.requestFullscreen();
} else if (fullscreenElement.mozRequestFullScreen) {
    fullscreenElement.mozRequestFullScreen();
} else if (fullscreenElement.webkitRequestFullscreen) {
    fullscreenElement.webkitRequestFullscreen();
} else if (fullscreenElement.msRequestFullscreen) {
    fullscreenElement.msRequestFullscreen();
}
});

// Листание в полноэкранном режиме
document.addEventListener('keydown', (event) => {
if (document.fullscreenElement) {
    if (event.key === 'ArrowLeft' && currentIndex > 0) {
    currentIndex--;
    updateSlider();
    } else if (event.key === 'ArrowRight' && currentIndex < slides.length - 1) {
    currentIndex++;
    updateSlider();
    }
}
});

// Инициализация
updateSlider();