// ==========================================================================
// Akash Gupta - Executive Engineering Portfolio Scripts
// Live IST Clock, Interactive Project Filters & Form Dispatcher
// ==========================================================================

// Ensure strict dark mode (clear any legacy stored theme from older versions)
try {
  localStorage.removeItem('akash-theme');
  localStorage.removeItem('theme');
  if (document.documentElement) document.documentElement.removeAttribute('data-theme');
  if (document.body) document.body.classList.remove('theme-light');
} catch (e) {}

document.addEventListener('DOMContentLoaded', () => {
  initLiveClock();
  initProjectFilters();
});

// 1. Real-Time IST Digital Clock (UTC +5:30)
function initLiveClock() {
  const clockEl = document.getElementById('liveClock');
  if (!clockEl) return;

  function updateTime() {
    const now = new Date();
    const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
    const ist = new Date(utc + (3600000 * 5.5));

    let hours = ist.getHours();
    const minutes = String(ist.getMinutes()).padStart(2, '0');
    const seconds = String(ist.getSeconds()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12 || 12;
    const strHours = String(hours).padStart(2, '0');

    clockEl.textContent = `${strHours}:${minutes}:${seconds} ${ampm} IST`;
  }

  updateTime();
  setInterval(updateTime, 1000);
}

// 2. Interactive Project Filtering
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

// 3. Contact Form Submission
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

// 4. Toast Notification
function showToast(message) {
  const toast = document.getElementById('toast');
  if (!toast) return;

  toast.textContent = message;
  toast.style.display = 'block';

  setTimeout(() => {
    toast.style.display = 'none';
  }, 4000);
}
