'use strict';
const { initial, perform, COST } = WildrootModel;
let state = initial();
let notice = 'Dara ingin jalur kerjanya aman dan tanaman berhenti menguning. Apa yang ingin kamu prioritaskan?';
const labels = {
  inspect: ['Amati kebun', 'Gratis • catat slime, tanaman, dan saluran'],
  clear: ['Buka saluran', '1 tenaga • pulihkan aliran dan drainase'],
  inspect_destination: ['Periksa tujuan', '1 tenaga • tepian hutan lembap'],
  hunt: ['Hunt', '1 tenaga • +2 reagen langsung • pengurai lokal menipis'],
  study: ['Study', '2 tenaga • rak terpakai 2 hari • baca hasil 1 tenaga'],
  relocate: ['Relocate', '2 tenaga +1 koin • perlu tujuan diperiksa • residu setelah 2 hari'],
  read: ['Baca hasil', '1 tenaga • +1 kompos contoh dan resep'],
  collect: ['Ambil residu tujuan', '1 tenaga • +1 kompos sekali'],
  plant: ['Tanam benih', '1 tenaga • satu petak percobaan'],
  water: ['Siram petak', '1 tenaga • pertumbuhan pada pergantian hari'],
  apply: ['Beri kompos', '1 tenaga +1 kompos • bonus 1 langkah sekali'],
  harvest: ['Panen', '1 tenaga • +3 koin'],
  gather: ['Ambil daun', '1 tenaga • +1 daun'],
  process: ['Olah kompos', '1 tenaga • pakai 1 reagen atau 1 daun jika tahu resep'],
  learn: ['Pelajari resep dari Mira', '1 tenaga +3 koin • sesudah kontrak • alternatif Study'],
  buy: ['Beli reagen', '2 koin • +1 reagen'],
  restore: ['Pulihkan pengurai', '1 tenaga +1 kompos • percepat kedatangan dari tepian'],
};
function el(tag, text, cls) { const n = document.createElement(tag); if (text) n.textContent = text; if (cls) n.className = cls; return n; }
function actionButton(id) {
  const b = el('button', '', 'action'); b.dataset.action = id;
  const result = perform(state, id);
  b.append(el('strong', labels[id][0]), el('span', labels[id][1]));
  if (id === 'study' && state.population === 'menipis') b.append(el('span', '+1 koin untuk sampel residu luar wilayah'));
  b.disabled = !result.ok; b.title = result.ok ? labels[id][1] : result.summary;
  if (!result.ok) b.append(el('small', result.summary));
  b.onclick = () => act(id); return b;
}
function act(id) {
  const r = perform(state, id); notice = r.summary;
  if (r.ok) state = r.state;
  render();
}
function render() {
  document.getElementById('day').textContent = 'Hari ' + state.day;
  document.getElementById('effort').textContent = state.effort + ' / ' + COST.daily;
  document.getElementById('coins').textContent = state.coins;
  document.getElementById('notice').textContent = notice;
  document.getElementById('resources').textContent = `${state.reagent} reagen   ·   ${state.compost} kompos   ·   ${state.leaves} daun`;
  document.getElementById('contract').textContent = state.rewardPaid ? 'Selesai • 6 koin sudah dibayar sekali' : '6 koin • buka saluran dan selesaikan satu pendekatan';
  document.getElementById('canal').textContent = state.canal ? 'Saluran terbuka' : 'Saluran tersumbat';
  document.getElementById('population').textContent = 'Pengurai lokal: ' + state.population;
  document.getElementById('litter').textContent = 'Daun tertinggal: ' + state.litter + ' / 3';
  if (state.population === 'menipis' && state.migrationHint) document.getElementById('population').textContent += ' • ada jejak kedatangan';
  const stage = state.plot.stage;
  document.getElementById('plot').className = 'plot ' + stage + (state.plot.watered ? ' wet' : '');
  document.getElementById('plant-label').textContent = 'Petak ' + stage;
  document.getElementById('growth').textContent = state.plot.growth + ' / 4 langkah';
  document.getElementById('growth-meter').value = state.plot.growth;
  document.getElementById('moisture').textContent = state.plot.watered ? 'Sudah disiram hari ini' : 'Belum disiram hari ini';
  document.getElementById('bench').textContent = state.study && !state.read ? `Rak uji terpakai • hasil siap hari ${state.studyDue}` : (state.knowledge ? 'Rak bebas • resep tersedia' : 'Rak bebas • pengolahan kasar tersedia');
  for (const [id, actions] of Object.entries({ observation: ['inspect','clear','inspect_destination'], choices: ['hunt','study','relocate'], followup: ['read','collect','restore'], farm: ['plant','water','apply','harvest'], work: ['gather','process','learn','buy'] })) {
    const group = document.getElementById(id); group.replaceChildren(...actions.map(actionButton));
  }
  const evidence = document.getElementById('evidence'); evidence.replaceChildren();
  if (state.inspected) evidence.append(el('li', 'Slime memakan daun lapuk; tanaman rusak juga di luar lintasannya. Air tertahan sebelum petak.'));
  if (state.canal && state.plot.growth > 0) evidence.append(el('li', 'Setelah saluran dibuka dan petak disiram, tanaman tumbuh. Itu belum membuktikan slime selalu aman.'));
  if (state.read) evidence.append(el('li', 'Pot dengan residu tumbuh lebih cepat pada air setara. Resep dapat diuji di petak.'));
  if (state.collected) evidence.append(el('li', 'Tempat tujuan menunjukkan penguraian daun. Satu sampel residu sudah dikumpulkan.'));
  if (!evidence.children.length) evidence.append(el('li', 'Belum ada pengamatan. Periksa kebun sebelum menyimpulkan penyebab.'));
  const log = document.getElementById('log'); log.replaceChildren();
  [...state.log].reverse().forEach(row => { const item=el('li'); item.append(el('b','Hari '+row.day+' · '),document.createTextNode(row.summary)); log.append(item); });
  document.getElementById('result').textContent = state.plot.stage === 'dipanen' ? `Siklus panen selesai pada hari ${state.day}. Pendekatan pertama: ${state.firstChoice || 'belum dipilih'}. Bandingkan log dan coba kebutuhan lain.` : 'Tujuan uji: selesaikan kebutuhan Dara dan panen satu tanaman. Kamu boleh menggabungkan tindakan.';
}
document.getElementById('next').onclick = () => act('next');
document.getElementById('reset').onclick = () => { state=initial(document.getElementById('goal').value); notice='Percobaan baru dimulai. Catat alasan pilihanmu sebelum hasil muncul.'; render(); };
document.getElementById('goal').onchange = event => {
  state.goal=event.target.value;
  notice='Kebutuhan uji diubah; keadaan kebun tetap. Gunakan Ulangi untuk mulai dari awal.'; render();
};
document.getElementById('export').onclick = () => {
  const blob=new Blob([JSON.stringify({ kind:'wildroot-decision-test', rules:COST, state, humanObservations:'Belum dicatat; isi formulir pengamatan dalam dokumen.' },null,2)],{type:'application/json'});
  const link=document.createElement('a'); const url=URL.createObjectURL(blob);
  link.href=url; link.download='wildroot-percobaan-hari-'+state.day+'.json'; link.click(); setTimeout(()=>URL.revokeObjectURL(url),1000);
};
render();
