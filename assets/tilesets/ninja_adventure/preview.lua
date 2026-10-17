local root=assert(app.params.root)..'/'
local source=app.open(root..'flowers_animated.png')
local raw=Image(source.width,source.height,ColorMode.RGB);raw:drawSprite(source,1)
local s=Sprite(24,24,ColorMode.RGB)
for f=1,4 do
  if f>1 then s:newEmptyFrame(f) end
  local tile=Image(16,16,ColorMode.RGB);tile:drawImage(raw,Point(-(f-1)*16,0))
  local im=Image(24,24,ColorMode.RGB);im:clear(app.pixelColor.rgba(79,99,64,255))
  im:drawImage(tile,Point(4,4));s:newCel(s.layers[1],f,im,Point(0,0));s.frames[f].duration=0.200
end
s:saveAs(root..'flowers.aseprite')
s:resize(192,192);s:saveCopyAs(root..'flowers_preview.gif')
print('Ninja Adventure flower preview:4 frames,16x16 source,5fps')
