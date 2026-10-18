(function (root) {
  'use strict';
  const COST = Object.freeze({ daily: 4, hunt: 1, study: 2, inspect_destination: 1,
    relocate: 2, bait: 1, read: 1, clear: 1, plant: 1, water: 1, apply: 1,
    harvest: 1, gather: 1, process: 1, learn: 1, recipe: 3, reagent: 2,
    restore: 1, collect: 1, reward: 6, harvest_coins: 3, grow: 4, delay: 2, recovery: 4 });
  function initial(goal = 'expedition') {
    return { version: 1, goal, day: 1, effort: COST.daily, coins: 2, leaves: 2,
      reagent: 0, compost: 0, knowledge: false, inspected: false, canal: false,
      destination: false, firstChoice: '', hunt: false, huntDay: 0, study: false,
      studyDue: 0, read: false, relocated: false, relocationDue: 0, collected: false,
      population: 'stabil', migrationHint: false, litter: 0, rewardPaid: false,
      plot: { stage: 'kosong', growth: 0, watered: false, boosted: false, applied: false }, log: [] };
  }
  function perform(input, action) {
    const s = JSON.parse(JSON.stringify(input));
    function need(test, message) { if (!test) throw new Error(message); }
    function pay(effort, coins = 0) {
      need(s.effort >= effort, 'Tenaga belum cukup. Majukan hari atau pilih kegiatan lain.');
      need(s.coins >= coins, 'Koin belum cukup.'); s.effort -= effort; s.coins -= coins;
    }
    let summary = '';
    try {
      switch (action) {
        case 'inspect':
          need(!s.inspected, 'Pengamatan sudah tercatat.'); s.inspected = true;
          summary = 'Slime memakan daun lapuk. Tanaman menguning juga di luar lintasannya. Air tertahan di saluran.'; break;
        case 'inspect_destination':
          need(!s.destination, 'Tempat tujuan sudah diperiksa.'); pay(COST.inspect_destination);
          s.destination = true; summary = 'Tepian hutan lembap punya daun lapuk dan ruang untuk satu kelompok slime.'; break;
        case 'hunt':
          need(!s.hunt && s.population === 'stabil', 'Kelompok lokal tidak tersedia untuk perburuan ini.');
          pay(COST.hunt); s.hunt = true; s.huntDay = s.day; s.population = 'menipis'; s.reagent += 2;
          if (!s.firstChoice) s.firstChoice = 'Hunt';
          summary = 'Perburuan selesai: +2 reagen, pengurai lokal menipis. Penyebab tanaman belum dipastikan.'; break;
        case 'study':
          need(!s.study && !s.knowledge, 'Percobaan sudah dimulai atau resep sudah dipelajari.');
          pay(COST.study, s.population === 'menipis' ? 1 : 0); s.study = true; s.studyDue = s.day + COST.delay;
          if (!s.firstChoice) s.firstChoice = 'Study';
          summary = 'Sampel pembanding ditaruh dengan air setara. Rak terpakai sampai hasil dibaca pada hari ' + s.studyDue + '.';
          if (s.population === 'menipis') summary += ' Satu koin dipakai untuk sampel residu dari luar wilayah.';
          break;
        case 'read':
          need(s.study && !s.read && s.day >= s.studyDue, 'Hasil belum siap atau sudah dibaca.'); pay(COST.read);
          s.read = true; s.knowledge = true; s.compost += 1;
          summary = 'Pot dengan residu lebih cepat tumbuh pada air setara. Dara menggeser daun lapuk ke luar jalur kerja. Ini bukti lokal, bukan jaminan semua slime baik. +1 kompos contoh dan resep.'; break;
        case 'relocate':
          need(s.destination, 'Periksa tempat tujuan terlebih dahulu.');
          need(!s.relocated && s.population === 'stabil', 'Kelompok lokal tidak tersedia untuk dipindahkan.');
          pay(COST.relocate, COST.bait); s.relocated = true; s.relocationDue = s.day + COST.delay; s.population = 'dipindahkan';
          if (!s.firstChoice) s.firstChoice = 'Relocate';
          summary = 'Kelompok dipindahkan memakai umpan. Jalur kebun aman; residu tujuan dapat diperiksa hari ' + s.relocationDue + '.'; break;
        case 'collect':
          need(s.relocated && !s.collected && s.day >= s.relocationDue, 'Residu tujuan belum tersedia atau sudah diambil.');
          pay(COST.collect); s.collected = true; s.compost += 1;
          summary = 'Daun di tempat tujuan telah berkurang. +1 kompos dari residu yang dikumpulkan.'; break;
        case 'clear':
          need(!s.canal, 'Saluran sudah terbuka.'); pay(COST.clear); s.canal = true;
          summary = 'Sumbatan dibuka. Air mencapai petak; perubahan tanaman masih perlu diamati.'; break;
        case 'plant':
          need(s.plot.stage === 'kosong', 'Percobaan ini menyediakan satu siklus tanaman.'); pay(COST.plant); s.plot.stage = 'tumbuh';
          summary = 'Satu benih ditanam. Perlu air untuk tumbuh pada pergantian hari.'; break;
        case 'water':
          need(s.plot.stage === 'tumbuh' && !s.plot.watered, 'Petak belum perlu disiram.'); pay(COST.water); s.plot.watered = true;
          summary = s.canal ? 'Petak disiram untuk hari ini.' : 'Petak disiram, tetapi drainase tersumbat masih menahan pertumbuhan.'; break;
        case 'apply':
          need(s.plot.stage === 'tumbuh' && !s.plot.applied, 'Kompos hanya sekali per tanaman.');
          need(s.compost > 0, 'Belum ada kompos.'); pay(COST.apply); s.compost--; s.plot.applied = true; s.plot.boosted = true;
          summary = 'Kompos dipasang. Satu bonus pertumbuhan menunggu air dan saluran yang terbuka.'; break;
        case 'harvest':
          need(s.plot.stage === 'siap', 'Tanaman belum siap panen.'); pay(COST.harvest); s.plot.stage = 'dipanen'; s.coins += COST.harvest_coins;
          summary = 'Tanaman dipanen. +3 koin; satu siklus selesai.'; break;
        case 'gather':
          pay(COST.gather); s.leaves++; summary = 'Satu daun lapuk dikumpulkan untuk percobaan kompos.'; break;
        case 'process':
          need(!s.study || s.read, 'Rak masih dipakai percobaan tanah.');
          if (s.knowledge) { need(s.leaves > 0, 'Perlu satu daun.'); pay(COST.process); s.leaves--; }
          else { need(s.reagent > 0, 'Cara kasar memerlukan satu reagen.'); pay(COST.process); s.reagent--; }
          s.compost++; summary = s.knowledge ? 'Satu daun diolah menjadi satu kompos memakai resep.' : 'Satu reagen diolah menjadi satu kompos dan habis terpakai.'; break;
        case 'learn':
          need(s.rewardPaid && !s.knowledge && !s.study, 'Penjelasan resep tersedia sesudah kontrak, bila belum mengikuti percobaan.');
          pay(COST.learn, COST.recipe); s.knowledge = true;
          summary = 'Mira menjelaskan resep dari catatan pembanding. -3 koin; resep tersedia tanpa memilih Study.'; break;
        case 'buy':
          pay(0, COST.reagent); s.reagent++; summary = 'Satu reagen dibeli dengan dua koin.'; break;
        case 'restore':
          need(s.population === 'menipis' && s.compost > 0, 'Pemulihan perlu populasi menipis dan satu kompos.');
          pay(COST.restore); s.compost--; s.population = 'stabil'; s.litter = 0;
          summary = 'Habitat kecil disiapkan. Pengurai dari tepian hutan kembali; satu kompos dipakai.'; break;
        case 'next': {
          const p = s.plot;
          if (p.stage === 'tumbuh' && p.watered && s.canal) {
            const amount = p.boosted ? 2 : 1;
            p.growth = Math.min(COST.grow, p.growth + amount); p.boosted = false;
            if (p.growth === COST.grow) p.stage = 'siap';
            summary = 'Tanaman bertambah ' + amount + ' langkah. ';
          } else if (p.stage === 'tumbuh') summary = 'Pertumbuhan tertunda; tanaman tetap hidup. ';
          p.watered = false; s.day++; s.effort = COST.daily;
          if (s.population === 'menipis') {
            s.litter = Math.min(3, s.litter + 1);
            if (!s.migrationHint && s.day >= s.huntDay + 2) {
              s.migrationHint = true; summary += 'Jejak pengurai baru terlihat di tepian hutan, belum memenuhi kebun. ';
            }
            if (s.day >= s.huntDay + COST.recovery) { s.population = 'stabil'; summary += 'Pengurai kembali dari tepian hutan. '; }
          }
          summary += 'Hari baru. Tenaga kembali empat.';
          break;
        }
        default: throw new Error('Aksi tidak dikenal.');
      }
      const finished = s.hunt || s.read || s.relocated;
      if (s.canal && finished && !s.rewardPaid) {
        s.rewardPaid = true; s.coins += COST.reward;
        summary += ' Dara membayar enam koin untuk jalur aman dan saluran terbuka. Pembayaran kontrak hanya sekali.';
      }
      s.log.push({ day: s.day, action, summary, effort: s.effort, coins: s.coins,
        growth: s.plot.growth, population: s.population });
      return { ok: true, state: s, summary };
    } catch (err) { return { ok: false, state: input, summary: err.message }; }
  }
  const api = { COST, initial, perform };
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.WildrootModel = api;
})(typeof globalThis !== 'undefined' ? globalThis : this);
