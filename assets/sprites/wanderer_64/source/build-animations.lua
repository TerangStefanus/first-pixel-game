-- Run with Aseprite --batch --script-param root=<absolute asset folder> --script <this file>.
-- image_gen draws the poses; Aseprite aligns them and enforces the final pixel format.
local root = assert(app.params.root, 'Missing root')..'/'
local pc = app.pixelColor
local colors = {{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
local palette = Palette(7)
palette:setColor(0, Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do palette:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local source = app.open(root..'source/walk-concept.png')
local original = Image(source.width, source.height, ColorMode.RGB)
original:drawSprite(source,1)
local directions = {'down','left','right','up'}
local rows = {}
local maxHeight = 0
for row=0,3 do
  rows[row+1] = {}
  for column=0,4 do
    local x0 = math.floor(column*source.width/5)
    local x1 = math.floor((column+1)*source.width/5)-1
    local y0 = math.floor(row*source.height/4)
    local y1 = math.floor((row+1)*source.height/4)-1
    -- Keep the character's connected silhouette; discard detached generation specks.
    local cw=x1-x0+1
    local solid,visited={},{}
    for y=y0,y1 do for x=x0,x1 do
      if pc.rgbaA(original:getPixel(x,y))>=160 then solid[(y-y0)*cw+x-x0]=true end
    end end
    local bestCount,bestMask=0,{}
    local minx,miny,maxx,maxy=x1,y1,x0,y0
    for start in pairs(solid) do
      if not visited[start] then
        local queue,head,mask={start},1,{}
        local count=0
        local ax,ay,bx,by=x1,y1,x0,y0
        visited[start]=true
        while head<=#queue do
          local key=queue[head]; head=head+1
          local lx,ly=key%cw,math.floor(key/cw)
          local x,y=x0+lx,y0+ly
          count=count+1; mask[y*source.width+x]=true
          ax,ay,bx,by=math.min(ax,x),math.min(ay,y),math.max(bx,x),math.max(by,y)
          local neighbors={}
          if x>x0 then neighbors[#neighbors+1]=key-1 end
          if x<x1 then neighbors[#neighbors+1]=key+1 end
          if y>y0 then neighbors[#neighbors+1]=key-cw end
          if y<y1 then neighbors[#neighbors+1]=key+cw end
          for _,n in ipairs(neighbors) do
            if solid[n] and not visited[n] then visited[n]=true; queue[#queue+1]=n end
          end
        end
        if count>bestCount then
          bestCount,bestMask=count,mask
          minx,miny,maxx,maxy=ax,ay,bx,by
        end
      end
    end
    assert(maxx>minx and maxy>miny,'Empty source cell')
    local b={x=minx,y=miny,w=maxx-minx+1,h=maxy-miny+1,mask=bestMask}
    rows[row+1][column+1]=b
    maxHeight=math.max(maxHeight,b.h)
  end
end
local scale=42/maxHeight
local function closest(pixel)
  if pc.rgbaA(pixel)<160 then return 0 end
  local r,g,b=pc.rgbaR(pixel),pc.rgbaG(pixel),pc.rgbaB(pixel)
  local index,distance=1,math.huge
  for i,c in ipairs(colors) do
    local d=(r-c[1])^2+(g-c[2])^2+(b-c[3])^2
    if d<distance then index,distance=i,d end
  end
  return index
end
local function newSprite(w,h)
  local s=Sprite(w,h,ColorMode.INDEXED)
  s:setPalette(palette)
  s.transparentColor=0
  s.layers[1].name='Wanderer - 6 colors'
  return s
end
local function setFrame(s,frame,image)
  if frame>1 then s:newEmptyFrame(frame) end
  s:newCel(s.layers[1],frame,image,Point(0,0))
  s.frames[frame].duration=0.125
end
local cells={}
local master=newSprite(64,64)
local sheet=Image(320,256,ColorMode.INDEXED)
local frame=0
for row,direction in ipairs(directions) do
  cells[row]={}
  local walk=newSprite(64,64)
  local strip=Image(256,64,ColorMode.INDEXED)
  for column=1,5 do
    local b=rows[row][column]
    local w,h=math.floor(b.w*scale+0.5),math.floor(b.h*scale+0.5)
    local left,top=math.floor((64-w)/2),54-h
    local image=Image(64,64,ColorMode.INDEXED)
    for y=0,h-1 do for x=0,w-1 do
      local sx=math.min(b.x+b.w-1,b.x+math.floor((x+0.5)*b.w/w))
      local sy=math.min(b.y+b.h-1,b.y+math.floor((y+0.5)*b.h/h))
      image:drawPixel(left+x,top+y,b.mask[sy*source.width+sx] and closest(original:getPixel(sx,sy)) or 0)
    end end
    cells[row][column]=image
    frame=frame+1
    setFrame(master,frame,image)
    sheet:drawImage(image,Point((column-1)*64,(row-1)*64))
    if column==1 then
      local idle=newSprite(64,64)
      setFrame(idle,1,image)
      idle:saveAs(root..'base/idle_'..direction..'.png')
      idle:saveAs(root..'source/base_'..direction..'.aseprite')
      idle:close()
    else
      local pose=column-1
      setFrame(walk,pose,image)
      strip:drawImage(image,Point((pose-1)*64,0))
      image:saveAs{filename=root..'frames/walk_'..direction..'_'..string.format('%02d',pose)..'.png',palette=palette}
    end
  end
  walk:saveAs(root..'source/walk_'..direction..'.aseprite')
  strip:saveAs{filename=root..'animations/walk_'..direction..'.png',palette=palette}
  walk:resize(256,256)
  walk:saveCopyAs(root..'previews/walk_'..direction..'.gif')
  walk:close()
end
-- Create tags after all frames exist: inserting frames otherwise expands prior ranges.
for row,direction in ipairs(directions) do
  local first=(row-1)*5+1
  local idleTag=master:newTag(first,first)
  idleTag.name='idle_'..direction
  local walkTag=master:newTag(first+1,first+4)
  walkTag.name='walk_'..direction
end
master:saveAs(root..'source/wanderer_64.aseprite')
sheet:saveAs{filename=root..'animations/wanderer_64_sheet.png',palette=palette}
local preview=newSprite(256,64)
for f=1,4 do
  local image=Image(256,64,ColorMode.INDEXED)
  for row=1,4 do image:drawImage(cells[row][f+1],Point((row-1)*64,0)) end
  setFrame(preview,f,image)
end
preview:resize(768,192)
preview:saveCopyAs(root..'previews/walk_4directions.gif')
local enlarged=Image(sheet)
enlarged:resize(960,768)
enlarged:saveAs{filename=root..'previews/contact-sheet.png',palette=palette}
print('Built 4 directions, 4 walk frames each, 4 idle bases; 64x64; 6 colors + alpha; 8fps')
print('Master: 20 frames, 8 named tags; sheet: 320x256 (idle + 4 walk columns)')

-- Apply the corrected six-frame lateral cycle after rebuilding the original poses.
if app.fs.isFile(root..'source/repair-side-walk.lua') then dofile(root..'source/repair-side-walk.lua') end
