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
dofile(root..'source/prepare-run-redraw.lua')
local timing={80,55,125,80,55,125}
local bob={0,1,-1,0,1,-1};local sole={53,53,50,53,53,50}
local function restoreHead(im,base,head,f)
 for y=0,head+bob[f] do for x=0,63 do im:drawPixel(x,y,0) end end
 for y=0,head do for x=0,63 do local c=base:getPixel(x,y)
  if c>0 then im:drawPixel(x,y+bob[f],c) end
 end end
end
local function convert(d)
 local raw=read(root..'source/run-'..d..'-redraw-concept.png',ColorMode.RGB)
 local base=read(root..'base/idle_'..d..'.png',ColorMode.INDEXED)
 local head=d=='down' and 36 or 35
 local poses={}
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
  for y=head+1+bob[f],sole[f] do for x=0,63 do
    local isLeg=y>=46+bob[f]
    local y0,y1,a,z
    if isLeg then y0,y1,a,z=46+bob[f],sole[f],0.72,1.0 else y0,y1,a,z=head+1+bob[f],45+bob[f],0.50,0.72 end
    local sy=math.floor(b.y+b.h*(a+(y-y0+0.5)/(y1-y0+1)*(z-a)))
    local sx=math.floor(cx+(x-31.5)/(scale*(isLeg and 0.85 or 1))+0.5)
    if sx>=x0 and sx<=x1 and sy>=0 and sy<raw.height and mask[sy*raw.width+sx] then
      local c=nearest(raw:getPixel(sx,sy))
      if isLeg and c==5 then c=2 end -- keep full trousers rather than generated bare ankles
      im:drawPixel(x,y,c)
    end
  end end
  -- Reuse the approved hair/face pixels, with only whole-pixel bounce.
  for y=0,head do for x=0,63 do
    local c=base:getPixel(x,y);if c>0 and y+bob[f]>=0 then im:drawPixel(x,y+bob[f],c) end
  end end
  poses[f]=im
end

 local originals={}
 for f=1,6 do originals[f]=Image(poses[f]) end
 -- Opposite contacts use the opposite physical sides, keeping the approved head.
 for f=4,6 do poses[f]=Image(originals[f-3]);poses[f]:flip();restoreHead(poses[f],base,head,f) end
 -- The generated flight poses retained the same leading arm. Reverse only the
 -- first flight half so the cycle crosses cleanly into the opposite contact.
 poses[3]=Image(originals[3]);poses[3]:flip();restoreHead(poses[3],base,head,3)
 poses[6]=Image(originals[3]);restoreHead(poses[6],base,head,6)
 return poses
end
local poses={right={},left={},down=convert('down'),up=convert('up')}
for f=1,6 do
 poses.right[f]=read(root..'frames/run_right_redraw_'..string.format('%02d',f)..'.png',ColorMode.INDEXED)
 poses.left[f]=Image(poses.right[f]);poses.left[f]:flip()
end
local right=app.open(root..'source/run_right_redraw.aseprite')
right:saveCopyAs(root..'source/run_right.aseprite');right:close()
local dirs={'down','left','right','up'}
local sheet=Image(384,256,ColorMode.INDEXED)
local master=spr(64,64);local n=0;local tags={}
for row,d in ipairs(dirs) do
 local s=spr(64,64);s.layers[1].name='Redrawn '..d..' run'
 local strip=Image(384,64,ColorMode.INDEXED)
 for f,im in ipairs(poses[d]) do
  if f>1 then s:newEmptyFrame(f) end
  s:newCel(s.layers[1],f,im,Point(0,0));s.frames[f].duration=timing[f]/1000
  im:saveAs{filename=root..'frames/run_'..d..'_'..string.format('%02d',f)..'.png',palette=palette}
  strip:drawImage(im,Point((f-1)*64,0));sheet:drawImage(im,Point((f-1)*64,(row-1)*64))
  n=n+1;if n>1 then master:newEmptyFrame(n) end
  master:newCel(master.layers[1],n,im,Point(0,0));master.frames[n].duration=timing[f]/1000
 end
 if d~='right' then s:saveAs(root..'source/run_'..d..'.aseprite') end
 strip:saveAs{filename=root..'animations/run_'..d..'.png',palette=palette}
 s:resize(256,256);s:saveCopyAs(root..'previews/run_'..d..'.gif')
 tags[#tags+1]={'run_'..d,n-5,n}
end
for _,t in ipairs(tags) do local tag=master:newTag(t[2],t[3]);tag.name=t[1] end
master:saveAs(root..'source/wanderer_64_run.aseprite')
master:saveCopyAs(root..'source/wanderer_64_run_redraw.aseprite')
sheet:saveAs{filename=root..'animations/wanderer_64_run_sheet.png',palette=palette}
local function rgb(im)
 local out=Image(64,64,ColorMode.RGB)
 for y=0,63 do for x=0,63 do local i=im:getPixel(x,y)
  if i>0 then local c=colors[i];out:drawPixel(x,y,pc.rgba(c[1],c[2],c[3],255)) end
 end end;return out
end
local bg=pc.rgba(210,204,187,255)
local preview=Sprite(256,64,ColorMode.RGB)
local contact=Image(384,256,ColorMode.RGB);contact:clear(bg)
for f=1,6 do
 if f>1 then preview:newEmptyFrame(f) end
 local im=Image(256,64,ColorMode.RGB);im:clear(bg)
 for row,d in ipairs(dirs) do
  im:drawImage(rgb(poses[d][f]),Point((row-1)*64,0));contact:drawImage(rgb(poses[d][f]),Point((f-1)*64,(row-1)*64))
 end
 preview:newCel(preview.layers[1],f,im,Point(0,0));preview.frames[f].duration=timing[f]/1000
end
preview:resize(1024,256);preview:saveCopyAs(root..'previews/run_4directions.gif')
preview:saveCopyAs(root..'previews/run_4directions_redraw.gif')
contact:resize(1536,1024);contact:saveAs(root..'previews/run_contact_sheet.png')
print('Published redrawn runs:6 frames per direction; timing80/55/125ms repeated; approved heads; short proportions; full arm cycle')
