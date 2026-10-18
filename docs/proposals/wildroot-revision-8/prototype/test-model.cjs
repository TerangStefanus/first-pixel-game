const assert = require('node:assert/strict');
const { initial, perform } = require('./engine.cjs');
let count=0;
function test(name, fn) { fn(); count++; console.log('PASS '+name); }
function act(s,a) { const r=perform(s,a); assert.equal(r.ok,true,a+': '+r.summary); return r.state; }
function day(s) { return act(s,'next'); }
function ready(s,cost=1) { while(s.effort<cost) s=day(s); return s; }
function doAction(s,a,cost=1) { return act(ready(s,cost),a); }
function grow(s) { for(let i=0;i<8 && s.plot.stage==='tumbuh';i++){s=doAction(s,'water');s=day(s);} return doAction(s,'harvest'); }
test('invalid action is atomic even when an earlier check succeeds',()=>{
 let s=act(initial(),'hunt');s.coins=0;const before=JSON.stringify(s);const r=perform(s,'study');assert.equal(r.ok,false);assert.equal(JSON.stringify(s),before);assert.strictEqual(r.state,s);
});
test('all three first approaches can complete contract and base harvest without recipe',()=>{
 for(const route of ['hunt','study','relocate']) {
  let s=initial();s=act(s,'inspect');
  if(route==='relocate')s=act(s,'inspect_destination');
  s=act(s,route);s=doAction(s,'clear');
  if(route==='study'){while(s.day<s.studyDue)s=day(s);s=doAction(s,'read');}
  assert.equal(s.rewardPaid,true);s=doAction(s,'plant');s=grow(s);assert.equal(s.plot.stage,'dipanen');
 }
});
test('no-study path can learn compost recipe and knowledge is not route locked',()=>{
 let s=act(act(initial(),'hunt'),'clear');s=act(s,'learn');assert.equal(s.knowledge,true);s=act(s,'process');assert.equal(s.compost,1);assert.equal(s.leaves,1);assert.equal(s.reagent,2);
});
test('contract reward is paid once across sequential methods and later days',()=>{
 let s=act(act(initial(),'hunt'),'clear');assert.equal(s.coins,8);
 s=act(s,'study');assert.equal(s.coins,7);s=day(day(s));s=act(s,'read');assert.equal(s.coins,7);
 for(let i=0;i<30;i++)s=day(s);assert.equal(s.coins,7);assert.equal(s.log.filter(x=>x.summary.includes('Dara membayar')).length,1);
});
test('research occupies bench and cannot be read or paid prematurely',()=>{
 let s=act(initial(),'study');s=act(s,'buy');assert.equal(perform(s,'read').ok,false);assert.equal(perform(s,'process').ok,false);
 s=day(day(s));s=act(s,'read');assert.equal(perform(s,'read').ok,false);s=act(s,'process');assert.equal(s.compost,2);
});
test('relocation needs verified destination and one coin then residue collection is once',()=>{
 let s=initial();assert.equal(perform(s,'relocate').ok,false);s=act(s,'inspect_destination');s=act(s,'relocate');assert.equal(s.coins,1);assert.equal(s.population,'dipindahkan');
 assert.equal(perform(s,'collect').ok,false);s=day(day(s));s=act(s,'collect');assert.equal(s.compost,1);assert.equal(perform(s,'collect').ok,false);
});
test('blocked canal or missed water delays growth without killing crop',()=>{
 let s=act(act(initial(),'plant'),'water');s=day(s);assert.equal(s.plot.growth,0);s=act(s,'clear');s=day(s);assert.equal(s.plot.growth,0);
 s=act(s,'water');s=day(s);assert.equal(s.plot.growth,1);assert.equal(s.plot.stage,'tumbuh');
});
test('compost is one bonus per crop and waits for correct growth conditions',()=>{
 let s=initial();s.compost=2;s=act(act(s,'plant'),'apply');assert.equal(perform(s,'apply').ok,false);
 s=act(s,'water');s=day(s);assert.equal(s.plot.growth,0);assert.equal(s.plot.boosted,true);
 s=act(act(s,'clear'),'water');s=day(s);assert.equal(s.plot.growth,2);s=act(s,'water');s=day(s);assert.equal(s.plot.growth,3);assert.equal(s.compost,1);
});
test('population recovers with time and thirty idle days never reset existing progress',()=>{
 let s=act(initial(),'hunt');s=act(s,'clear');s=act(s,'plant');s=act(s,'water');s=day(s);assert.equal(s.plot.growth,1);assert.equal(s.population,'menipis');
 for(let i=0;i<29;i++)s=day(s);assert.equal(s.day,31);assert.equal(s.population,'stabil');assert.equal(s.plot.growth,1);assert.equal(s.rewardPaid,true);assert.equal(s.canal,true);assert.equal(s.plot.stage,'tumbuh');
});
test('migration warning appears before recovery without resetting the population daily',()=>{
 let s=act(initial(),'hunt');s=day(s);assert.equal(s.migrationHint,false);assert.equal(s.population,'menipis');
 s=day(s);assert.equal(s.migrationHint,true);assert.equal(s.population,'menipis');s=day(day(s));assert.equal(s.population,'stabil');
});
test('effort and material bounds hold under deterministic random action sequences',()=>{
 const actions=['inspect','clear','inspect_destination','hunt','study','read','relocate','collect','plant','water','apply','harvest','gather','process','learn','buy','restore','next'];
 let seed=5481; for(let run=0;run<30;run++){let s=initial();for(let i=0;i<150;i++){seed=(Math.imul(seed,1664525)+1013904223)>>>0;const a=actions[seed%actions.length];const before=JSON.stringify(s);const r=perform(s,a);if(!r.ok)assert.equal(JSON.stringify(s),before);else s=r.state;assert.ok(s.effort>=0&&s.effort<=4);for(const k of ['coins','leaves','compost','reagent'])assert.ok(s[k]>=0);assert.ok(s.plot.growth>=0&&s.plot.growth<=4);assert.ok(s.litter<=3);assert.ok(s.log.filter(x=>x.summary.includes('Dara membayar')).length<=1);}}
});
console.log(JSON.stringify({tests:count,passed:count,humanPlaytest:false}));
