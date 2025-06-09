import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.previewContainer = document.getElementById('preview')
  }

  preview(event) {
    const files = event.target.files
    
    for (let file of files) {
      if (file.type.startsWith('image/') || file.type.startsWith('video/')) {
        const reader = new FileReader()
        
        reader.onload = (e) => {
          const previewDiv = document.createElement('div')
          previewDiv.className = 'relative group'
          
          if (file.type.startsWith('image/')) {
            previewDiv.innerHTML = `
              <img src="${e.target.result}" class="w-full h-32 object-cover rounded-lg" />
              <div class="absolute inset-0 bg-black bg-opacity-50 opacity-0 group-hover:opacity-100 transition-opacity rounded-lg flex items-center justify-center">
                <button type="button" class="text-white hover:text-red-500" data-action="click->media-upload#remove">Удалить</button>
              </div>
            `
          } else {
            previewDiv.innerHTML = `
              <video src="${e.target.result}" class="w-full h-32 object-cover rounded-lg"></video>
              <div class="absolute inset-0 bg-black bg-opacity-50 opacity-0 group-hover:opacity-100 transition-opacity rounded-lg flex items-center justify-center">
                <button type="button" class="text-white hover:text-red-500" data-action="click->media-upload#remove">Удалить</button>
              </div>
            `
          }
          
          this.previewContainer.appendChild(previewDiv)
        }
        
        reader.readAsDataURL(file)
      }
    }
  }

  remove(event) {
    event.preventDefault()
    event.stopPropagation()
    
    const button = event.currentTarget
    const mediaId = button.dataset.mediaId
    const element = button.closest('.group')
    
    if (mediaId) {
      // Если это существующий файл, отправляем запрос на удаление
      fetch(`/media_files/${mediaId}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'application/json'
        }
      }).then(response => {
        if (response.ok) {
          element.remove()
        }
      })
    } else {
      // Если это предпросмотр нового файла, просто удаляем элемент
      element.remove()
    }
  }
} 