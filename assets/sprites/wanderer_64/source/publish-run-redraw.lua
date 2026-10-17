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
local front=dofile(root..'source/front-run-poses.lua')
local poses={right={},left={},down=front.down,up=front.up}
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
 local direction_timing=(d=='down' or d=='up') and front.timing or timing
 local s=spr(64,64);s.layers[1].name='Redrawn '..d..' run'
 local strip=Image(384,64,ColorMode.INDEXED)
 for f,im in ipairs(poses[d]) do
  if f>1 then s:newEmptyFrame(f) end
  s:newCel(s.layers[1],f,im,Point(0,0));s.frames[f].duration=direction_timing[f]/1000
  im:saveAs{filename=root..'frames/run_'..d..'_'..string.format('%02d',f)..'.png',palette=palette}
  strip:drawImage(im,Point((f-1)*64,0));sheet:drawImage(im,Point((f-1)*64,(row-1)*64))
  n=n+1;if n>1 then master:newEmptyFrame(n) end
  master:newCel(master.layers[1],n,im,Point(0,0));master.frames[n].duration=direction_timing[f]/1000
 end
 if d=='left' then s:saveAs(root..'source/run_'..d..'.aseprite') end
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
local bg=pc.rgba(210,204,190,255)
local preview=Sprite(256,64,ColorMode.RGB)
local contact=Image(384,256,ColorMode.RGB);contact:clear(bg)
for f=1,6 do
 if f>1 then preview:newEmptyFrame(f) end
 local im=Image(256,64,ColorMode.RGB);im:clear(bg)
 for row,d in ipairs(dirs) do
  im:drawImage(rgb(poses[d][f]),Point((row-1)*64,0));contact:drawImage(rgb(poses[d][f]),Point((f-1)*64,(row-1)*64))
 end
 preview:newCel(preview.layers[1],f,im,Point(0,0));preview.frames[f].duration=0.090
end
preview:resize(1024,256);preview:saveCopyAs(root..'previews/run_4directions.gif')
preview:saveCopyAs(root..'previews/run_4directions_redraw.gif')
contact:resize(1536,1024);contact:saveAs(root..'previews/run_contact_sheet.png')
print('Published runs: CC0-reference vertical poses at 90ms; accepted lateral timing retained; 6-color hero')

dofile(root..'source/preview-front-run.lua')
