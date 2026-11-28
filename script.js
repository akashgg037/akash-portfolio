// ==========================================================================
// Akash Gupta - Senior Engineering Portfolio Scripts
// Interactive Theme Switcher, Category Filters & Form Dispatcher
// ==========================================================================

document.addEventListener('DOMContentLoaded', () => {
  initThemeToggle();
  initProjectFilters();
});

// 1. Theme Mode Switcher (Light / Dark)
function initThemeToggle() {
  const themeBtn = document.getElementById('themeBtn');
  const themeIcon = document.getElementById('themeIcon');
  const body = document.body;

  // Retrieve saved preference or default to dark (matching modern mobile portfolio)
  const savedTheme = localStorage.getItem('akash-theme') || 'theme-dark';
  applyTheme(savedTheme);

  if (themeBtn) {
    themeBtn.addEventListener('click', () => {
      const isCurrentlyDark = body.classList.contains('theme-dark');
      const nextTheme = isCurrentlyDark ? 'theme-light' : 'theme-dark';
      applyTheme(nextTheme);
      localStorage.setItem('akash-theme', nextTheme);
    });
  }

  function applyTheme(theme) {
    body.classList.remove('theme-light', 'theme-dark');
    body.classList.add(theme);

    if (themeIcon) {
      if (theme === 'theme-dark') {
        themeIcon.classList.remove('fa-moon');
        themeIcon.classList.add('fa-sun');
      } else {
        themeIcon.classList.remove('fa-sun');
        themeIcon.classList.add('fa-moon');
      }
    }
  }
}

// 2. Interactive Case Study Filtering
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
