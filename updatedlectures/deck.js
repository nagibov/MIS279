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

  // Slide menu: jump directly to any slide (M to toggle, Esc to close)
  const menuBtn = document.createElement('button');
  menuBtn.type = 'button';
  menuBtn.className = 'nav-btn ghost';
  menuBtn.id = 'menu';
  menuBtn.title = 'Jump to slide (M)';
  menuBtn.textContent = 'Slides';
  counter.parentNode.insertBefore(menuBtn, counter);

  const panel = document.createElement('div');
  panel.className = 'slide-menu';
  panel.hidden = true;
  slides.forEach((s, i) => {
    const t = s.querySelector('.title');
    const item = document.createElement('button');
    item.type = 'button';
    item.className = 'slide-menu-item' + (s.classList.contains('divider') ? ' section' : '');
    item.innerHTML = '<span class="num">' + (i + 1) + '</span><span>' + (t ? t.textContent.trim() : 'Slide ' + (i + 1)) + '</span>';
    item.addEventListener('click', () => { show(i, false); closeMenu(); });
    panel.appendChild(item);
  });
  document.body.appendChild(panel);

  function openMenu() {
    panel.hidden = false;
    panel.querySelectorAll('.slide-menu-item').forEach((el, i) => el.classList.toggle('current', i === index));
    const cur = panel.querySelector('.current');
    if (cur) cur.scrollIntoView({ block: 'nearest' });
  }
  function closeMenu() { panel.hidden = true; }
  menuBtn.addEventListener('click', e => { e.stopPropagation(); panel.hidden ? openMenu() : closeMenu(); });
  document.addEventListener('click', e => { if (!panel.hidden && !panel.contains(e.target)) closeMenu(); });

  document.addEventListener('keydown', e => {
    if (e.key === 'Escape') { closeMenu(); return; }
    if (e.key === 'm' || e.key === 'M') { panel.hidden ? openMenu() : closeMenu(); return; }
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
    { k: 'kp',   n: 'Key Partners' },
    { k: 'ka',   n: 'Key Activities' },
    { k: 'kr',   n: 'Key Resources' },
    { k: 'vp',   n: 'Value Propositions' },
    { k: 'cr',   n: 'Relationships' },
    { k: 'ch',   n: 'Channels' },
    { k: 'cs',   n: 'Customer Segments' },
    { k: 'cost', n: 'Cost Structure' },
    { k: 'rev',  n: 'Revenue Streams' }
  ];
  document.querySelectorAll('.bmc-mini').forEach(el => {
    const done = (el.dataset.done || '').split(',').map(s => s.trim()).filter(Boolean);
    const now = (el.dataset.now || '').trim();
    el.classList.add('bmc');
    BLOCKS.forEach(b => {
      const d = document.createElement('div');
      d.className = 'b ' + b.k + (done.includes(b.k) ? ' done' : '') + (b.k === now ? ' now' : '');
      d.innerHTML = (done.includes(b.k) ? '<span class="ic">✓</span>' : '') + b.n;
      el.appendChild(d);
    });
  });
})();
