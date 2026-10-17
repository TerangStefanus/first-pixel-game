-- Convert the newly drawn poses, preserving the approved head and short proportions.
local root=assert(app.params.root)..'/'
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
local pc=app.pixelColor;local palette=Palette(7)
palette:setColor(0,Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do palette:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local function spr(w,h)
  local s=Sprite(w,h,ColorMode.INDEXED);s:setPalette(palette);s.transparentColor=0;return s
end
local function read(path,mode)
  local s=app.open(path);local im=Image(s.width,s.height,mode);im:drawSprite(s,1);s:close();return im
end
local function nearest(p)
  if pc.rgbaA(p)<180 then return 0 end
  local r,g,b=pc.rgbaR(p),pc.rgbaG(p),pc.rgbaB(p);local best,dist=1,math.huge
  for i,c in ipairs(colors) do local d=(r-c[1])^2+(g-c[2])^2+(b-c[3])^2
    if d<dist then best,dist=i,d end
  end;return best
end
local raw=read(root..'source/run-right-redraw-concept.png',ColorMode.RGB)
local base=read(root..'base/idle_right.png',ColorMode.INDEXED)
local poses={};local bob={0,1,-1,0,1,-1};local sole={53,53,50,53,53,50}
local timing={80,55,125,80,55,125}
for f=1,6 do
  local x0,x1=math.floor((f-1)*raw.width/6),math.floor(f*raw.width/6)-1
  local solid,visited={},{}
  for y=0,raw.height-1 do for x=x0,x1 do
    if pc.rgbaA(raw:getPixel(x,y))>=180 then solid[y*raw.width+x]=true end
  end end
  local best,mask,bounds=0,{},nil
  for start in pairs(solid) do if not visited[start] then
    local queue,head,group={start},1,{};visited[start]=true
    local ax,ay,bx,by=x1,raw.height,x0,0
    while head<=#queue do
      local k=queue[head];head=head+1;group[k]=true
      local x,y=k%raw.width,math.floor(k/raw.width)
      ax,ay,bx,by=math.min(ax,x),math.min(ay,y),math.max(bx,x),math.max(by,y)
      local ns={}
      if x>x0 then ns[#ns+1]=k-1 end;if x<x1 then ns[#ns+1]=k+1 end
      if y>0 then ns[#ns+1]=k-raw.width end;if y<raw.height-1 then ns[#ns+1]=k+raw.width end
      for _,n in ipairs(ns) do if solid[n] and not visited[n] then visited[n]=true;queue[#queue+1]=n end end
    end
    if #queue>best then best,mask,bounds=#queue,group,{x=ax,y=ay,w=bx-ax+1,h=by-ay+1} end
  end end
  local b=assert(bounds);local hx0,hx1=x1,x0
  for y=b.y,b.y+math.floor(b.h*0.42) do for x=b.x,b.x+b.w-1 do
    if mask[y*raw.width+x] then hx0,hx1=math.min(hx0,x),math.max(hx1,x) end
  end end
  local cx=(hx0+hx1)/2;local scale=26/(hx1-hx0+1)
  local im=Image(64,64,ColorMode.INDEXED)
  for y=34+bob[f],sole[f] do for x=0,63 do
    local isLeg=y>=46+bob[f]
    local y0,y1,a,z
    if isLeg then y0,y1,a,z=46+bob[f],sole[f],0.72,1.0 else y0,y1,a,z=34+bob[f],45+bob[f],0.50,0.72 end
    local sy=math.floor(b.y+b.h*(a+(y-y0+0.5)/(y1-y0+1)*(z-a)))
    local sx=math.floor(cx+(x-31.5)/(scale*(isLeg and 0.85 or 1))+0.5)
    if sx>=x0 and sx<=x1 and sy>=0 and sy<raw.height and mask[sy*raw.width+sx] then
      local c=nearest(raw:getPixel(sx,sy))
      if isLeg and c==5 then c=2 end -- keep full trousers rather than generated bare ankles
      im:drawPixel(x,y,c)
    end
  end end
  -- Reuse the approved hair/face pixels, with only whole-pixel bounce.
  for y=0,33 do for x=0,63 do
    local c=base:getPixel(x,y);if c>0 and y+bob[f]>=0 then im:drawPixel(x,y+bob[f],c) end
  end end
  poses[f]=im
end
-- The generated far fist still disappears behind the pack in the opposite contact.
-- Reuse the SAME fist pixels along a full path instead of exchanging hand colors.
local darkFist=Image(5,5,ColorMode.INDEXED)
local fistRows={'01110','12221','12221','12221','01110'}
for y,p in ipairs(fistRows) do for x=1,#p do darkFist:drawPixel(x-1,y-1,tonumber(p:sub(x,x))) end end
local farArms,nearHands,bodyFrames={},{},{}
local handPath={{38,37},{33,39},{22,38},{18,39},{28,40},{36,37}}
local handRects={{19,39,22,42},{31,41,34,45},{38,36,41,40},{38,36,41,39},{30,42,33,45},{20,39,23,43}}
for f=1,6 do
  local arm=Image(64,64,ColorMode.INDEXED)
  local dx,dy=handPath[f][1],handPath[f][2]+bob[f]
  local hx,hy=dx+2,dy+2
  local ex,ey=(32+hx)/2,40+bob[f]
  local function stroke(ax,ay,bx,by)
    local n=math.max(math.abs(bx-ax),math.abs(by-ay))*2
    for i=0,n do
      local x,y=math.floor(ax+(bx-ax)*i/n+0.5),math.floor(ay+(by-ay)*i/n+0.5)
      for oy=-1,1 do for ox=-1,1 do arm:drawPixel(x+ox,y+oy,1) end end
      arm:drawPixel(x,y,3)
    end
  end
  stroke(32,36+bob[f],ex,ey);stroke(ex,ey,hx,hy)
  arm:drawImage(darkFist,Point(dx,dy))
  if f==1 or f==2 or f==5 or f==6 then
    for y=35+bob[f],43+bob[f] do for x=36,44 do poses[f]:drawPixel(x,y,0) end end
  end
  local body=Image(poses[f]);local hand=Image(64,64,ColorMode.INDEXED)
  local rect=handRects[f]
  for y=rect[2],rect[4] do for x=rect[1],rect[3] do
    if body:getPixel(x,y)==5 then hand:drawPixel(x,y,5);body:drawPixel(x,y,0) end
  end end
  local composite=Image(arm);composite:drawImage(body);composite:drawImage(hand)
  poses[f]=composite;bodyFrames[f]=body;nearHands[f]=hand
  farArms[f]=arm
end
local strip=Image(384,64,ColorMode.INDEXED)
local s=spr(64,64)
s.layers[1].name='Dark far arm - full swing'
local bodyLayer=s:newLayer();bodyLayer.name='Character drawing'
local handLayer=s:newLayer();handLayer.name='Light near hand - same identity'
for f,im in ipairs(poses) do
  if f>1 then s:newEmptyFrame(f) end
  s:newCel(s.layers[1],f,farArms[f],Point(0,0))
  s:newCel(bodyLayer,f,bodyFrames[f],Point(0,0));s:newCel(handLayer,f,nearHands[f],Point(0,0))
  s.frames[f].duration=timing[f]/1000
  strip:drawImage(im,Point((f-1)*64,0))
  im:saveAs{filename=root..'frames/run_right_redraw_'..string.format('%02d',f)..'.png',palette=palette}
end
s:saveAs(root..'source/run_right_redraw.aseprite')
strip:saveAs{filename=root..'animations/run_right_redraw.png',palette=palette}
local contact=Image(strip);contact:resize(1536,256);contact:saveAs{filename=root..'previews/run_right_redraw_poses.png',palette=palette}
s:resize(256,256);s:saveCopyAs(root..'previews/run_right_redraw.gif')
print('Redrawn lateral prototype:6 poses, approved head, original short body proportions,6 colors')
local function rgb(im)
  local out=Image(64,64,ColorMode.RGB)
  for y=0,63 do for x=0,63 do local n=im:getPixel(x,y)
    if n>0 then local c=colors[n];out:drawPixel(x,y,pc.rgba(c[1],c[2],c[3],255)) end
  end end;return out
end
local preview=Sprite(128,64,ColorMode.RGB)
local bg=pc.rgba(210,204,187,255)
for f=1,6 do
  if f>1 then preview:newEmptyFrame(f) end
  local im=Image(128,64,ColorMode.RGB);im:clear(bg)
  im:drawImage(rgb(base),Point(0,0));im:drawImage(rgb(poses[f]),Point(64,0))
  preview:newCel(preview.layers[1],f,im,Point(0,0));preview.frames[f].duration=timing[f]/1000
end
preview:resize(768,384);preview:saveCopyAs(root..'previews/run_right_redraw_compare.gif')
local still=Image(768,384,ColorMode.RGB);still:drawSprite(preview,4);still:saveAs(root..'previews/run_right_redraw_contact4.png')
-- Six frozen poses on a neutral background expose the alternating hand positions.
local check=Image(384,64,ColorMode.RGB);check:clear(bg)
for f=1,6 do check:drawImage(rgb(poses[f]),Point((f-1)*64,0)) end
check:resize(1536,256);check:saveAs(root..'previews/run_right_redraw_neutral.png')
local hands=Sprite(192,64,ColorMode.RGB)
for f=1,6 do
  if f>1 then hands:newEmptyFrame(f) end
  local im=Image(192,64,ColorMode.RGB);im:clear(bg)
  im:drawImage(rgb(poses[f]),Point(0,0));im:drawImage(rgb(nearHands[f]),Point(64,0));im:drawImage(rgb(farArms[f]),Point(128,0))
  hands:newCel(hands.layers[1],f,im,Point(0,0));hands.frames[f].duration=0.220
end
hands:resize(768,256);hands:saveCopyAs(root..'previews/run_arm_swing_check.gif')
