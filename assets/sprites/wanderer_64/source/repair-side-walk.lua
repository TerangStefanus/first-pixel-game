-- Eight-pose lateral walk: native pixel edits of the approved idle base.
-- Keep the approved head fixed, align every pose by its head rather than limb bounds,
-- preserve down/up images, and mirror one lateral cycle for consistent left/right.
local root=assert(app.params.root,'Missing root')..'/'
local pc=app.pixelColor
local palette=Palette(7)
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
palette:setColor(0,Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do palette:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local function spr(w,h)
  local s=Sprite(w,h,ColorMode.INDEXED);s:setPalette(palette);s.transparentColor=0
  s.layers[1].name='Wanderer - 6 colors';return s
end
local function readIndexed(path)
  local s=app.open(path);local im=Image(s.width,s.height,ColorMode.INDEXED)
  im:drawSprite(s,1);s:close();return im
end
local function put(s,n,image,duration)
  if n>1 then s:newEmptyFrame(n) end
  s:newCel(s.layers[1],n,image,Point(0,0));s.frames[n].duration=duration
end
-- Preserve the approved upper body. Both legs share the same articulated geometry
-- and boot template; color identity and depth stay fixed for the whole cycle.
local approved=readIndexed(root..'base/idle_right.png')
local right,left,nearLeg,farLeg={},{},{},{}
local duration=0.100
local count=8
local body=Image(approved)
for y=46,63 do for x=0,63 do body:drawPixel(x,y,0) end end
-- One complete leg cycle: planted foot travels front to back, then swings forward.
-- The other leg uses the identical cycle four frames later.
local steps={{4,0},{2,0},{0,0},{-2,0},{-4,0},{-2.5,1},{0,2},{2.5,1}}
local joints={}
local function distance(x,y,ax,ay,bx,by)
  local dx,dy=bx-ax,by-ay
  local u=math.max(0,math.min(1,((x-ax)*dx+(y-ay)*dy)/(dx*dx+dy*dy)))
  return math.sqrt((x-ax-u*dx)^2+(y-ay-u*dy)^2)
end
local function leg(step,near)
  local hx,hy=32,45
  local ax,ay=32+step[1],50-step[2]
  local dx,dy=ax-hx,ay-hy
  local d=math.sqrt(dx*dx+dy*dy)
  local length=3.25
  assert(d<=2*length,'Leg reach exceeds fixed bone lengths')
  local bend=math.sqrt(length*length-d*d/4)
  -- Knee bends towards the facing direction; thigh and shin are always 3.25px.
  local kx,ky=(hx+ax)/2+dy/d*bend,(hy+ay)/2-dx/d*bend
  assert(math.abs(math.sqrt((kx-hx)^2+(ky-hy)^2)-length)<0.00001)
  assert(math.abs(math.sqrt((ax-kx)^2+(ay-ky)^2)-length)<0.00001)
  local im=Image(64,64,ColorMode.INDEXED)
  for y=46,52 do for x=25,40 do
    local dist=math.min(distance(x,y,hx,hy,kx,ky),distance(x,y,kx,ky,ax,ay))
    -- Chunky trousers: roughly five pixels across with a three-pixel fill.
    -- Keep the accepted joint/foot trajectory; only garment volume changes.
    if dist<=2.65 then im:drawPixel(x,y,near and dist<=1.55 and 2 or 1) end
  end end
  -- Identical rigid seven-by-four boot for both feet in every single frame.
  local bx,by=math.floor(ax+0.5)-2,50-step[2]
  local boot={'1122211','1222221','1222221','1111111'}
  for row,pattern in ipairs(boot) do for col=1,#pattern do
    local c=tonumber(pattern:sub(col,col))
    if c>0 then im:drawPixel(bx+col-1,by+row-1,near and c or 1) end
  end end
  return im,{hip={hx,hy},knee={kx,ky},ankle={ax,ay},boot={bx,by,7,4},bone_length=length}
end
for f=1,count do
  nearLeg[f],joints[f]=leg(steps[f],true)
  farLeg[f],joints[f].far=leg(steps[(f+3)%count+1],false)
  local im=Image(farLeg[f]);im:drawImage(nearLeg[f]);im:drawImage(body)
  right[f]=im;left[f]=Image(im);left[f]:flip()
end
local mirroredIdle=Image(approved);mirroredIdle:flip()
mirroredIdle:saveAs{filename=root..'base/idle_left.png',palette=palette}
local idleLeft=spr(64,64);put(idleLeft,1,mirroredIdle,duration)
idleLeft:saveAs(root..'source/base_left.aseprite')
local walks={right=right,left=left}
local dirs={'down','left','right','up'}
local poses={};local idle={}
for _,d in ipairs(dirs) do
  idle[d]=readIndexed(root..'base/idle_'..d..'.png')
  if walks[d] then
    poses[d]=walks[d]
    local s=spr(64,64);local strip=Image(count*64,64,ColorMode.INDEXED)
    for f,im in ipairs(poses[d]) do
      put(s,f,im,duration);strip:drawImage(im,Point((f-1)*64,0))
      im:saveAs{filename=root..'frames/walk_'..d..'_'..string.format('%02d',f)..'.png',palette=palette}
    end
    s:close()
    s=spr(64,64)
    local farLayer=s.layers[1];farLayer.name='Dark leg - fixed identity'
    local nearLayer=s:newLayer();nearLayer.name='Brown leg - fixed identity'
    local bodyLayer=s:newLayer();bodyLayer.name='Approved upper body'
    for f=1,count do
      if f>1 then s:newEmptyFrame(f) end
      local a,b,c=farLeg[f],nearLeg[f],body
      if d=='left' then a=Image(a);a:flip();b=Image(b);b:flip();c=Image(c);c:flip() end
      s:newCel(farLayer,f,a,Point(0,0));s:newCel(nearLayer,f,b,Point(0,0));s:newCel(bodyLayer,f,c,Point(0,0))
      s.frames[f].duration=duration
    end
    s:saveAs(root..'source/walk_'..d..'.aseprite')
    s:saveCopyAs(root..'source/walk_'..d..'_gait.aseprite')
    s:saveCopyAs(root..'source/walk_'..d..'_chunky.aseprite')
    if d=='right' then s:saveCopyAs(root..'source/walk_right_compact.aseprite') end
    strip:saveAs{filename=root..'animations/walk_'..d..'.png',palette=palette}
    s:resize(256,256);s:saveCopyAs(root..'previews/walk_'..d..'.gif')
  else
    poses[d]={}
    for f=1,4 do poses[d][f]=readIndexed(root..'frames/walk_'..d..'_'..string.format('%02d',f)..'.png') end
  end
end
local master=spr(64,64);local sheet=Image((count+1)*64,256,ColorMode.INDEXED)
local n=0;local ranges={}
for row,d in ipairs(dirs) do
  local frameDuration=walks[d] and duration or 0.125
  n=n+1;put(master,n,idle[d],frameDuration);ranges[#ranges+1]={'idle_'..d,n,n}
  sheet:drawImage(idle[d],Point(0,(row-1)*64))
  local first=n+1
  for f,im in ipairs(poses[d]) do
    n=n+1;put(master,n,im,frameDuration);sheet:drawImage(im,Point(f*64,(row-1)*64))
  end
  ranges[#ranges+1]={'walk_'..d,first,n}
end
for _,r in ipairs(ranges) do local tag=master:newTag(r[2],r[3]);tag.name=r[1] end
master:saveAs(root..'source/wanderer_64.aseprite')
sheet:saveAs{filename=root..'animations/wanderer_64_sheet.png',palette=palette}
local contact=Image(sheet);contact:resize(1728,768)
contact:saveAs{filename=root..'previews/contact-sheet.png',palette=palette}
local sides=spr(128,64)
for f=1,count do
  local im=Image(128,64,ColorMode.INDEXED)
  im:drawImage(left[f],Point(0,0));im:drawImage(right[f],Point(64,0));put(sides,f,im,duration)
end
sides:resize(512,256);sides:saveCopyAs(root..'previews/walk_sides_v2.gif')
sides:saveCopyAs(root..'previews/walk_sides_compact.gif')
sides:saveCopyAs(root..'previews/walk_sides_gait.gif')
sides:saveCopyAs(root..'previews/walk_sides_chunky.gif')
local all=spr(256,64)
for f=1,8 do
  local im=Image(256,64,ColorMode.INDEXED)
  for col,d in ipairs(dirs) do im:drawImage(poses[d][((f-1)%#poses[d])+1],Point((col-1)*64,0)) end
  put(all,f,im,duration)
end
all:resize(768,192);all:saveCopyAs(root..'previews/walk_4directions.gif')
print('Side gait:8 frames at100ms; equal rigid bones/boots; stable color identities; symmetric contacts; approved upper body')
print('Master:28 frames,8 tags. Sheet:576x256. Lateral strips:512x64.')

-- Neutral preview: approved idle at left, the same base articulated at right.
local compare=Sprite(128,64,ColorMode.RGB)
local function rgbCopy(im)
  local out=Image(64,64,ColorMode.RGB)
  for y=0,63 do for x=0,63 do
    local i=im:getPixel(x,y)
    if i>0 then local c=colors[i];out:drawPixel(x,y,pc.rgba(c[1],c[2],c[3],255)) end
  end end
  return out
end
for f=1,count do
  if f>1 then compare:newEmptyFrame(f) end
  local im=Image(128,64,ColorMode.RGB);im:clear(pc.rgba(210,204,187,255))
  im:drawImage(rgbCopy(approved),Point(0,0));im:drawImage(rgbCopy(right[f]),Point(64,0))
  compare:newCel(compare.layers[1],f,im,Point(0,0));compare.frames[f].duration=duration
end
compare:resize(768,384);compare:saveCopyAs(root..'previews/base_vs_walk.gif')
local still=Image(768,384,ColorMode.RGB);still:drawSprite(compare,1)
still:saveAs(root..'previews/base_vs_walk.png')

local diagnostic=Sprite(192,64,ColorMode.RGB)
local poses=Sprite(512,64,ColorMode.RGB)
local contact=Image(512,64,ColorMode.RGB);contact:clear(pc.rgba(210,204,187,255))
for f=1,count do
  if f>1 then diagnostic:newEmptyFrame(f) end
  local im=Image(192,64,ColorMode.RGB);im:clear(pc.rgba(210,204,187,255))
  im:drawImage(rgbCopy(right[f]),Point(0,0));im:drawImage(rgbCopy(farLeg[f]),Point(64,0));im:drawImage(rgbCopy(nearLeg[f]),Point(128,0))
  diagnostic:newCel(diagnostic.layers[1],f,im,Point(0,0));diagnostic.frames[f].duration=0.200
  contact:drawImage(rgbCopy(right[f]),Point((f-1)*64,0))
end
diagnostic:resize(768,256);diagnostic:saveCopyAs(root..'previews/leg_identity_slow.gif')
contact:resize(1536,192);contact:saveAs(root..'previews/gait_8_poses.png')

local masks=Image(512,128,ColorMode.INDEXED)
local report=assert(io.open(root..'source/gait-joints.tsv','w'))
report:write('frame\tleg\thip_x\thip_y\tknee_x\tknee_y\tankle_x\tankle_y\tboot_x\tboot_y\tboot_w\tboot_h\tbone_length\n')
for f=1,count do
  masks:drawImage(farLeg[f],Point((f-1)*64,0));masks:drawImage(nearLeg[f],Point((f-1)*64,64))
  for _,name in ipairs({'brown','dark'}) do
    local j=name=='brown' and joints[f] or joints[f].far
    report:write(string.format('%d\t%s\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%d\t%d\t%d\t%d\t%.6f\n',f,name,j.hip[1],j.hip[2],j.knee[1],j.knee[2],j.ankle[1],j.ankle[2],j.boot[1],j.boot[2],j.boot[3],j.boot[4],j.bone_length))
  end
end
report:close();masks:saveAs{filename=root..'previews/leg_masks.png',palette=palette}
