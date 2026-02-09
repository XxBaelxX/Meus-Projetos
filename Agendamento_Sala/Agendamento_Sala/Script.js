    // Simple client-side booking demo (localStorage)
    const ROOMS = [
      {id:'sala-a', name:'Sala A (10 pessoas)'},
      {id:'sala-b', name:'Sala B (6 pessoas)'},
      {id:'sala-c', name:'Sala C (20 pessoas)'}
    ];

    const $room = document.getElementById('room');
    const $start = document.getElementById('start');
    const $end = document.getElementById('end');
    const $bookBtn = document.getElementById('bookBtn');
    const $status = document.getElementById('status');
    const $bookingsList = document.getElementById('bookingsList');
    const $noBookings = document.getElementById('noBookings');

    function id() { return Date.now().toString(36) + Math.random().toString(36).slice(2,8); }

    function loadRooms(){
      for(const r of ROOMS){
        const opt = document.createElement('option'); opt.value = r.id; opt.textContent = r.name; $room.appendChild(opt);
      }
    }

    function getBookings(){
      try{ return JSON.parse(localStorage.getItem('bookings')||'[]'); }catch(e){return []}
    }
    function saveBookings(b){ localStorage.setItem('bookings', JSON.stringify(b)); }

    function formatLocal(dt){
      const d = new Date(dt); if(isNaN(d)) return '';
      return d.toLocaleString();
    }

    function overlaps(aStart,aEnd,bStart,bEnd){
      return (aStart < bEnd) && (aEnd > bStart);
    }

    function renderBookings(){
      const bookings = getBookings().sort((a,b)=>new Date(a.start)-new Date(b.start));
      $bookingsList.innerHTML='';
      if(bookings.length===0){ $noBookings.style.display='block'; return; }
      $noBookings.style.display='none';

      for(const bk of bookings){
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${ROOMS.find(r=>r.id===bk.room)?.name||bk.room}</td>
          <td>${formatLocal(bk.start)}</td>
          <td>${formatLocal(bk.end)}</td>
          <td>${bk.user||'Anônimo'}</td>
          <td><button data-id="${bk.id}">Cancelar</button></td>
        `;
        const btn = tr.querySelector('button'); btn.addEventListener('click', ()=>{ cancelBooking(bk.id); });
        $bookingsList.appendChild(tr);
      }
    }

    function cancelBooking(bid){
      let b = getBookings();
      b = b.filter(x=>x.id!==bid);
      saveBookings(b); renderBookings(); showStatus('Reserva cancelada', '');
    }

    function showStatus(msg, cls){ $status.textContent = msg; $status.className = cls?cls:'muted'; setTimeout(()=>{ $status.textContent=''; }, 3500); }

    function addBooking(){
      const room = $room.value;
      const s = $start.value; const e = $end.value;
      if(!room || !s || !e){ showStatus('Preencha sala, início e término', 'danger'); return; }
      const start = new Date(s); const end = new Date(e);
      if(start >= end){ showStatus('Término deve ser depois do início', 'danger'); return; }
      // verifica conflito
      const existing = getBookings().filter(b=>b.room===room);
      for(const ex of existing){
        if(overlaps(start, end, new Date(ex.start), new Date(ex.end))){
          showStatus('Conflito: já existe uma reserva nesse horário', 'danger');
          return;
        }
      }
      const bk = {id: id(), room, start: start.toISOString(), end: end.toISOString(), user: 'Usuário Demo'};
      const all = getBookings(); all.push(bk); saveBookings(all); renderBookings(); showStatus('Reserva criada ✅', 'success');
    }

    $bookBtn.addEventListener('click', addBooking);

    // configuração inicial
    loadRooms(); renderBookings();

    // convenience: pre-fill start/end to next full hour
    (function setDefaultTimes(){
      const n = new Date(); n.setMinutes(0,0,0); n.setHours(n.getHours()+1);
      const later = new Date(n.getTime() + 60*60*1000);
      $start.value = n.toISOString().slice(0,16);
      $end.value = later.toISOString().slice(0,16);
    })();

    // helpful note: replace localStorage calls with fetch(...) to integrate with an API