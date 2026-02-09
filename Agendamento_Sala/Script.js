// Script central: booking (guarded) + UI tabs
document.addEventListener('DOMContentLoaded', function () {
  // --- Booking module (runs only when booking elements exist) ---
  const $room = document.getElementById('room');
  const $start = document.getElementById('start');
  const $end = document.getElementById('end');
  const $bookBtn = document.getElementById('bookBtn');
  const $status = document.getElementById('status');
  const $bookingsList = document.getElementById('bookingsList');
  const $noBookings = document.getElementById('noBookings');

  if ($room && $start && $end && $bookBtn) {
    const ROOMS = [
      { id: 'sala-a', name: 'Sala A (10 pessoas)' },
      { id: 'sala-b', name: 'Sala B (6 pessoas)' },
      { id: 'sala-c', name: 'Sala C (20 pessoas)' }
    ];

    function id() { return Date.now().toString(36) + Math.random().toString(36).slice(2, 8); }

    function loadRooms() {
      for (const r of ROOMS) {
        const opt = document.createElement('option'); opt.value = r.id; opt.textContent = r.name; $room.appendChild(opt);
      }
    }

    function getBookings() { try { return JSON.parse(localStorage.getItem('bookings') || '[]'); } catch (e) { return []; } }
    function saveBookings(b) { localStorage.setItem('bookings', JSON.stringify(b)); }

    function formatLocal(dt) { const d = new Date(dt); if (isNaN(d)) return ''; return d.toLocaleString(); }

    function overlaps(aStart, aEnd, bStart, bEnd) { return (aStart < bEnd) && (aEnd > bStart); }

    function renderBookings() {
      const bookings = getBookings().sort((a, b) => new Date(a.start) - new Date(b.start));
      $bookingsList.innerHTML = '';
      if (bookings.length === 0) { $noBookings.style.display = 'block'; return; }
      $noBookings.style.display = 'none';
      for (const bk of bookings) {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${ROOMS.find(r => r.id === bk.room)?.name || bk.room}</td>
          <td>${formatLocal(bk.start)}</td>
          <td>${formatLocal(bk.end)}</td>
          <td>${bk.user || 'Anônimo'}</td>
          <td><button data-id="${bk.id}">Cancelar</button></td>
        `;
        const btn = tr.querySelector('button'); btn.addEventListener('click', () => { cancelBooking(bk.id); });
        $bookingsList.appendChild(tr);
      }
    }

    function cancelBooking(bid) { let b = getBookings(); b = b.filter(x => x.id !== bid); saveBookings(b); renderBookings(); showStatus('Reserva cancelada', ''); }
    function showStatus(msg, cls) { if (!$status) return; $status.textContent = msg; $status.className = cls ? cls : 'muted'; setTimeout(() => { $status.textContent = ''; }, 3500); }

    function addBooking() {
      const room = $room.value; const s = $start.value; const e = $end.value;
      if (!room || !s || !e) { showStatus('Preencha sala, início e término', 'danger'); return; }
      const start = new Date(s); const end = new Date(e);
      if (start >= end) { showStatus('Término deve ser depois do início', 'danger'); return; }
      const existing = getBookings().filter(b => b.room === room);
      for (const ex of existing) { if (overlaps(start, end, new Date(ex.start), new Date(ex.end))) { showStatus('Conflito: já existe uma reserva nesse horário', 'danger'); return; } }
      const bk = { id: id(), room, start: start.toISOString(), end: end.toISOString(), user: 'Usuário Demo' };
      const all = getBookings(); all.push(bk); saveBookings(all); renderBookings(); showStatus('Reserva criada ✅', 'success');
    }

    $bookBtn.addEventListener('click', addBooking);
    loadRooms(); renderBookings();

    (function setDefaultTimes(){
      const n = new Date(); n.setMinutes(0,0,0); n.setHours(n.getHours()+1);
      const later = new Date(n.getTime() + 60*60*1000);
      $start.value = n.toISOString().slice(0,16);
      $end.value = later.toISOString().slice(0,16);
    })();
  }

  // --- Tabs module (safe to run on any page) ---
  const tabs = document.querySelectorAll('.tab');
  if (tabs.length) {
    const contents = document.querySelectorAll('.content');
    function activate(target) {
      tabs.forEach(t => {
        const isActive = t.dataset.target === target;
        t.classList.toggle('active', isActive);
        t.setAttribute('aria-expanded', isActive ? 'true' : 'false');
      });
      contents.forEach(c => { c.classList.toggle('active', c.dataset.content === target); });
    }
    tabs.forEach(tab => {
      tab.setAttribute('role', 'tab');
      tab.tabIndex = 0;
      tab.addEventListener('click', () => activate(tab.dataset.target));
      tab.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); activate(tab.dataset.target); }
      });
    });
  }
});