// ==========================================================================
// Akash Gupta - Executive Engineering Portfolio Scripts
// Interactive Project Filters & Form Dispatcher (Pure Dark Cinematic Mode)
// ==========================================================================

document.addEventListener('DOMContentLoaded', () => {
  // Clear any legacy theme preference so users always get the cinematic dark aesthetic
  try {
    localStorage.removeItem('akash-theme');
  } catch (e) {}

  initProjectFilters();
});

// 1. Interactive Project Filtering
function initProjectFilters() {
  const filterBtns = document.querySelectorAll('.filter-btn');
  const caseCards = document.querySelectorAll('.case-card');

  filterBtns.forEach((btn) => {
    btn.addEventListener('click', () => {
      filterBtns.forEach((b) => b.classList.remove('active'));
      btn.classList.add('active');

      const filterValue = btn.getAttribute('data-filter');

      caseCards.forEach((card) => {
        const categories = card.getAttribute('data-category') || '';
        if (filterValue === 'all' || categories.includes(filterValue)) {
          card.classList.remove('hide');
        } else {
          card.classList.add('hide');
        }
      });
    });
  });
}

// 2. Contact Form Submission
function handleFormSubmit(event) {
  event.preventDefault();

  const name = document.getElementById('name').value.trim();
  const email = document.getElementById('email').value.trim();
  const subject = document.getElementById('subject').value.trim();
  const message = document.getElementById('message').value.trim();

  if (!name || !email || !message) {
    showToast('Please complete all required fields.');
    return;
  }

  const encodedSubject = encodeURIComponent(`[Project Inquiry] ${subject} - from ${name}`);
  const encodedBody = encodeURIComponent(
    `Sender Name: ${name}\nEmail: ${email}\n\nProject Scope & Message:\n${message}\n\n---\nTransmitted via Akash Gupta Portfolio`
  );

  const mailtoUrl = `mailto:akashg092@gmail.com?subject=${encodedSubject}&body=${encodedBody}`;
  window.location.href = mailtoUrl;

  showToast('Launching email client with pre-filled message...');
  document.getElementById('contactForm').reset();
}

// 3. Toast Notification
function showToast(message) {
  const toast = document.getElementById('toast');
  if (!toast) return;

  toast.textContent = message;
  toast.style.display = 'block';

  setTimeout(() => {
    toast.style.display = 'none';
  }, 4000);
}
