-- Native Aseprite conversion and original low-noise 32px terrain tiles.
local root=assert(app.params.root)..'/'
local pc=app.pixelColor
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57},{61,75,54},{137,147,100},{129,117,101},{183,163,129},{114,126,85},{102,113,74},{126,137,92},{142,116,84},{158,130,93},{126,101,75}}
local palette=Palette(#colors+1);palette:setColor(0,Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do palette:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local function sprite(w,h)
 local s=Sprite(w,h,ColorMode.INDEXED);s:setPalette(palette);s.transparentColor=0;return s
end
local function quantize(p,stone)
 if pc.rgbaA(p)<200 then return 0 end
 local best,dist=1,math.huge
 local r,g,b=pc.rgbaR(p),pc.rgbaG(p),pc.rgbaB(p)
 local candidates
 if stone then candidates={1,3,7,9,10}
 elseif g>=r*0.98 and g>b*1.1 then candidates={1,3,7,8}
 else candidates={1,2,4,5,6} end
 for _,i in ipairs(candidates) do local c=colors[i];local v=(r-c[1])^2+(g-c[2])^2+(b-c[3])^2
  if v<dist then best,dist=i,v end
 end;return best
end
local raw=app.open(root..'source/woodland-concept.png')
local original=Image(raw.width,raw.height,ColorMode.RGB);original:drawSprite(raw,1);raw:close()
local solid,seen={},{}
for y=0,original.height-1 do for x=0,original.width-1 do
 if pc.rgbaA(original:getPixel(x,y))>=200 then solid[y*original.width+x]=true end
end end
local components={}
for start in pairs(solid) do if not seen[start] then
 local q,head={start},1;seen[start]=true
 local x0,y0,x1,y1=original.width,original.height,0,0
 while head<=#q do
  local k=q[head];head=head+1;local x,y=k%original.width,math.floor(k/original.width)
  x0,y0,x1,y1=math.min(x0,x),math.min(y0,y),math.max(x1,x),math.max(y1,y)
  local ns={};if x>0 then ns[#ns+1]=k-1 end;if x<original.width-1 then ns[#ns+1]=k+1 end
  if y>0 then ns[#ns+1]=k-original.width end;if y<original.height-1 then ns[#ns+1]=k+original.width end
  for _,n in ipairs(ns) do if solid[n] and not seen[n] then seen[n]=true;q[#q+1]=n end end
 end
 if #q>150 then components[#components+1]={x=x0,y=y0,w=x1-x0+1,h=y1-y0+1,count=#q} end
end end
table.sort(components,function(a,b)return a.count>b.count end)
assert(#components>=8,'Expected eight separate props')
while #components>8 do table.remove(components) end
table.sort(components,function(a,b)
 local ar=a.y<original.height*0.6 and 0 or 1;local br=b.y<original.height*0.6 and 0 or 1
 if ar~=br then return ar<br end;return a.x<b.x
end)
local names={'oak_a','oak_b','pine_a','pine_b','bush','flower_bush','rocks','fern'}
local heights={116,110,128,120,28,28,24,20}
local review=Image(512,288,ColorMode.INDEXED)
for i,b in ipairs(components) do
 local h=heights[i];local w=math.floor(b.w*h/b.h+0.5)
 local cw,ch,base=128,144,136
 if i>=5 then cw,ch,base=64,48,43 end
 assert(w<cw and h<ch,'Prop must fit its native canvas')
 local im=Image(cw,ch,ColorMode.INDEXED)
 for y=0,h-1 do for x=0,w-1 do
  local sx=b.x+math.floor((x+0.5)*b.w/w);local sy=b.y+math.floor((y+0.5)*b.h/h)
  im:drawPixel(math.floor((cw-w)/2)+x,base-h+1+y,quantize(original:getPixel(sx,sy),i==7))
 end end
 im:saveAs{filename=root..names[i]..'.png',palette=palette}
 local s=sprite(cw,ch);s.layers[1].name=names[i]..' - native pixels';s:newCel(s.layers[1],1,im)
 s:saveAs(root..'source/'..names[i]..'.aseprite');s:close()
 review:drawImage(im,Point(((i-1)%4)*128,math.floor((i-1)/4)*144))
end
review:saveAs{filename=root..'source/props-native.png',palette=palette}
local atlas=Image(256,96,ColorMode.INDEXED)
local function grass(variant)
 local im=Image(32,32,ColorMode.INDEXED);im:clear(11)
 if variant>0 then
  local x,y=6+variant*5,9+variant*3
  im:drawPixel(x,y,12);im:drawPixel(x+1,y-1,12);im:drawPixel(x+2,y,13)
  im:drawPixel(x+11,y+9,12);im:drawPixel(x+12,y+8,12)
 end;return im
end
for v=0,3 do atlas:drawImage(grass(v),Point(v*32,0)) end
for mask=0,15 do
 local im=grass(0)
 local n=mask%2==1;local e=math.floor(mask/2)%2==1;local s=math.floor(mask/4)%2==1;local w=math.floor(mask/8)%2==1
 for y=0,31 do for x=0,31 do
  local wobblex=math.floor(x/5)%2;local wobbley=math.floor(y/5)%2
  local l=w and 0 or 3+wobbley;local r=e and 31 or 28-wobbley
  local t=n and 0 or 3+wobblex;local b=s and 31 or 28-wobblex
  if x>=l and x<=r and y>=t and y<=b then
   local edge=(not w and x==l) or (not e and x==r) or (not n and y==t) or (not s and y==b)
   im:drawPixel(x,y,edge and 16 or 14)
   if not edge and (x*7+y*11+mask*3)%173==0 then im:drawPixel(x,y,15) end
  end
 end end
 local index=mask+4;atlas:drawImage(im,Point((index%8)*32,math.floor(index/8)*32))
end
atlas:saveAs{filename=root..'ground_32.png',palette=palette}
local s=sprite(256,96);s.layers[1].name='32px grass and dirt edge masks';s:newCel(s.layers[1],1,atlas)
s:saveAs(root..'source/ground_32.aseprite');s:close()
local flower=Image(16,16,ColorMode.INDEXED)
for y=8,12 do flower:drawPixel(7,y,7) end
for _,v in ipairs({{6,6},{7,5},{8,6},{7,7}}) do flower:drawPixel(v[1],v[2],4) end
flower:drawPixel(7,6,5);flower:drawPixel(6,10,3);flower:drawPixel(8,9,3)
flower:saveAs{filename=root..'flower.png',palette=palette}
local fs=sprite(16,16);fs.layers[1].name='Tiny cream flower';fs:newCel(fs.layers[1],1,flower)
fs:saveAs(root..'source/flower.aseprite');fs:close()
print('Built eight native-size props and original quiet 32px terrain; 16 colors plus transparency')
