import consumer from "./consumer"

// Get all snippet IDs from the page
const snippetElements = document.querySelectorAll('[data-snippet-id]')
const snippetIds = Array.from(snippetElements).map(el => el.dataset.snippetId).filter((id, index, arr) => arr.indexOf(id) === index)

// Create subscriptions for each snippet
const subscriptions = snippetIds.map(snippetId => {
  return consumer.subscriptions.create({ channel: "SnippetChannel", snippet_id: snippetId }, {
    connected() {
      console.log(`Connected to SnippetChannel for snippet ${snippetId}`)
    },

    disconnected() {
      console.log(`Disconnected from SnippetChannel for snippet ${snippetId}`)
    },

    received(data) {
      console.log("Received data:", data)

      switch(data.type) {
        case 'like_update':
          this.updateLikeCount(data)
          break
        case 'comment_like_update':
          this.updateCommentLikeCount(data)
          break
      }
    },

    updateLikeCount(data) {
      // Update like count on both index and show pages
      const likeElements = document.querySelectorAll(`[data-snippet-id="${data.snippet_id}"] .fa-heart`)
      likeElements.forEach(element => {
        const button = element.closest('button, span')
        if (button) {
          const text = button.textContent
          const newText = text.replace(/\(\d+\)/, `(${data.likes_count})`)
          if (text !== newText) {
            button.innerHTML = button.innerHTML.replace(/\(\d+\)/, `(${data.likes_count})`)
          }
        }
      })

      // Update like buttons for the current user
      const likeButtons = document.querySelectorAll(`[data-snippet-id="${data.snippet_id}"][data-user-id]`)
      likeButtons.forEach(button => {
        if (button.querySelector('.fa-heart')) {
          if (data.action === 'liked' && data.user_id === parseInt(button.dataset.userId)) {
            button.innerHTML = '<i class="fas fa-heart"></i> Unlike (' + data.likes_count + ')'
            button.className = 'text-red-500 hover:text-red-700'
          } else if (data.action === 'unliked' && data.user_id === parseInt(button.dataset.userId)) {
            button.innerHTML = '<i class="far fa-heart"></i> Like (' + data.likes_count + ')'
            button.className = 'text-gray-500 hover:text-red-500'
          }
        }
      })
    },

    updateCommentLikeCount(data) {
      // Update comment like count (only affects show page, not index)
      const commentLikeElements = document.querySelectorAll(`[data-comment-id="${data.comment_id}"] .fa-heart`)
      commentLikeElements.forEach(element => {
        const button = element.closest('button, span')
        if (button) {
          const text = button.textContent
          const newText = text.replace(/\(\d+\)/, `(${data.likes_count})`)
          if (text !== newText) {
            button.innerHTML = button.innerHTML.replace(/\(\d+\)/, `(${data.likes_count})`)
          }
        }
      })

      // Update comment like buttons for the current user
      const commentLikeButtons = document.querySelectorAll(`[data-comment-id="${data.comment_id}"][data-user-id]`)
      commentLikeButtons.forEach(button => {
        if (button.querySelector('.fa-heart')) {
          if (data.action === 'liked' && data.user_id === parseInt(button.dataset.userId)) {
            button.innerHTML = '<i class="fas fa-heart"></i> (' + data.likes_count + ')'
            button.className = 'text-red-500 hover:text-red-700'
          } else if (data.action === 'unliked' && data.user_id === parseInt(button.dataset.userId)) {
            button.innerHTML = '<i class="far fa-heart"></i> (' + data.likes_count + ')'
            button.className = 'text-gray-500 hover:text-red-500'
          }
        }
      })
    },


  })
})

export default subscriptions