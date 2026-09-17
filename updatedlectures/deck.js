(function () {
  const slides = Array.from(document.querySelectorAll('.slide'));
  const bar = document.getElementById('bar');
  const counter = document.getElementById('counter');
  const dots = document.getElementById('stepdots');
  let index = 0;

  const buildsOf = s => Array.from(s.querySelectorAll('[data-build]'));
  const shownOf  = s => buildsOf(s).filter(b => b.classList.contains('on'));

  function updateUI() {
    counter.textContent = (index + 1) + ' / ' + slides.length;
    bar.style.width = (((index + 1) / slides.length) * 100).toFixed(1) + '%';
    // step dots for current slide
    const b = buildsOf(slides[index]);
    dots.innerHTML = '';
    if (b.length > 1) {
      b.forEach(el => {
        const d = document.createElement('span');
        d.className = 'dot' + (el.classList.contains('on') ? ' on' : '');
        dots.appendChild(d);
      });
    }
    history.replaceState(null, '', '#' + (index + 1));
  }

  function show(i, revealAll) {
    const target = Math.max(0, Math.min(slides.length - 1, i));
    if (target !== index || !slides[target].classList.contains('active')) {
      index = target;
      slides.forEach((s, idx) => s.classList.toggle('active', idx === index));
      buildsOf(slides[index]).forEach(b => b.classList.toggle('on', !!revealAll));
    }
    updateUI();
  }

  function next() {
    const b = buildsOf(slides[index]);
    const s = shownOf(slides[index]);
    if (s.length < b.length) { b[s.length].classList.add('on'); updateUI(); return; }
    if (index < slides.length - 1) show(index + 1, false);
  }

  function prev() {
    const s = shownOf(slides[index]);
    if (s.length > 0) { s[s.length - 1].classList.remove('on'); updateUI(); return; }
    if (index > 0) show(index - 1, true); // going back shows the previous slide fully revealed
  }

  document.getElementById('next').addEventListener('click', next);
  document.getElementById('prev').addEventListener('click', prev);
  document.getElementById('fs').addEventListener('click', () => {
    if (document.fullscreenElement) document.exitFullscreen();
    else document.documentElement.requestFullscreen();
  });

  document.addEventListener('keydown', e => {
    if (e.key === 'ArrowRight' || e.key === ' ' || e.key === 'PageDown') { e.preventDefault(); next(); }
    if (e.key === 'ArrowLeft' || e.key === 'PageUp') { e.preventDefault(); prev(); }
    if (e.key === 'Home') show(0, false);
    if (e.key === 'End') show(slides.length - 1, true);
    if (e.key === 'f' || e.key === 'F') document.getElementById('fs').click();
  });

  // Deep link via hash (#slideNumber)
  const start = parseInt(location.hash.replace('#', ''), 10);
  if (!isNaN(start) && start >= 1 && start <= slides.length) show(start - 1, false);
  else show(0, false);
})();

/* ---------- BMC mini-canvas renderer (Week 2) ---------- */
(function () {
  const BLOCKS = [
    { k: 'kp',   n: 'Key Partners',        ic: '🤝' },
    { k: 'ka',   n: 'Key Activities',      ic: '⚙️' },
    { k: 'kr',   n: 'Key Resources',       ic: '🧰' },
    { k: 'vp',   n: 'Value Propositions',  ic: '💎' },
    { k: 'cr',   n: 'Relationships',       ic: '❤️' },
    { k: 'ch',   n: 'Channels',            ic: '📣' },
    { k: 'cs',   n: 'Customer Segments',   ic: '👥' },
    { k: 'cost', n: 'Cost Structure',      ic: '📉' },
    { k: 'rev',  n: 'Revenue Streams',     ic: '💰' }
  ];
  document.querySelectorAll('.bmc-mini').forEach(el => {
    const done = (el.dataset.done || '').split(',').map(s => s.trim()).filter(Boolean);
    const now = (el.dataset.now || '').trim();
    el.classList.add('bmc');
    BLOCKS.forEach(b => {
      const d = document.createElement('div');
      d.className = 'b ' + b.k + (done.includes(b.k) ? ' done' : '') + (b.k === now ? ' now' : '');
      d.innerHTML = '<span class="ic">' + (done.includes(b.k) ? '✅' : b.ic) + '</span>' + b.n;
      el.appendChild(d);
    });
  });
})();
