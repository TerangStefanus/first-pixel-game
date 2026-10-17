local root=assert(app.params.root)..'/'
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
local pc=app.pixelColor
local s=Sprite(128,64,ColorMode.RGB)
local timing={90,90,90,90,90,90}
for f=1,6 do
 if f>1 then s:newEmptyFrame(f) end
 local im=Image(128,64,ColorMode.RGB);im:clear(pc.rgba(114,126,85,255))
 for i,d in ipairs({'down','up'}) do
  local pose=app.open(root..'frames/run_'..d..'_'..string.format('%02d',f)..'.png')
  local frame=Image(64,64,ColorMode.INDEXED);frame:drawSprite(pose,1);pose:close()
  for y=0,63 do for x=0,63 do local index=frame:getPixel(x,y)
   if index>0 then local c=colors[index];im:drawPixel((i-1)*64+x,y,pc.rgba(c[1],c[2],c[3],255)) end
  end end
 end
 s:newCel(s.layers[1],f,im);s.frames[f].duration=timing[f]/1000
end
s:resize(512,256);s:saveCopyAs(root..'previews/run_front_back_native.gif')
