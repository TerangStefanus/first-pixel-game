// DOM fixture checks the delivered inline bundle and event wiring without a browser.
// This is not a visual check or a human playtest.
const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict');
class Element {
 constructor(tag){this.tagName=tag;this.children=[];this.dataset={};this.textContent='';this.value='';this.disabled=false;}
 append(...children){this.children.push(...children);}
 replaceChildren(...children){this.children=[...children];}
 click(){if(!this.disabled&&this.onclick)this.onclick();}
}
const html=fs.readFileSync(__dirname+'/index.html','utf8');
const ids=new Map([...html.matchAll(/\bid="([^"]+)"/g)].map(m=>[m[1],new Element('div')]));
ids.get('goal').value='expedition';let download=null;
const document={getElementById:id=>{assert.ok(ids.has(id),id);return ids.get(id);},createTextNode:text=>({textContent:text}),createElement:tag=>{const e=new Element(tag);if(tag==='a')e.click=()=>{download={href:e.href,name:e.download};};return e;}};
const context=vm.createContext({document,Blob,URL,setTimeout:()=>0,console});
for(const m of html.matchAll(/<script>([\s\S]*?)<\/script>/g))vm.runInContext(m[1],context);
function click(action){let b;for(const id of ['observation','choices','followup','farm','work'])for(const e of ids.get(id).children)if(e.dataset.action===action)b=e;assert.ok(b,action);assert.equal(b.disabled,false,action);b.click();}
assert.equal(ids.get('day').textContent,'Hari 1');assert.equal(ids.get('coins').textContent,2);
click('inspect');assert.match(ids.get('notice').textContent,/daun lapuk/);
click('hunt');click('clear');assert.equal(ids.get('coins').textContent,8);assert.match(ids.get('contract').textContent,/sudah dibayar sekali/);
click('plant');click('water');ids.get('next').click();assert.equal(ids.get('growth').textContent,'1 / 4 langkah');
for(let i=0;i<3;i++){click('water');ids.get('next').click();}click('harvest');assert.match(ids.get('result').textContent,/Siklus panen selesai/);
ids.get('export').click();assert.ok(download.href.startsWith('blob:'));assert.match(download.name,/wildroot-percobaan-hari/);
ids.get('goal').onchange({target:{value:'habitat'}});ids.get('reset').click();assert.equal(ids.get('day').textContent,'Hari 1');assert.equal(ids.get('coins').textContent,2);assert.equal(ids.get('log').children.length,0);
click('inspect_destination');click('relocate');assert.match(ids.get('population').textContent,/dipindahkan/);
console.log('PASS delivered HTML bundle starts, buttons update counters and evidence, full harvest works, export creates a local Blob, reset clears state, and relocation is wired.');
console.log(JSON.stringify({interfaceFixture:'passed',visualBrowserCheck:false,humanPlaytest:false}));
