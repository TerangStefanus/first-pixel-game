-- Original front/back running pixels, articulated from the approved idle bases.
-- No generated torso warping, frame flips or changing backpack/face geometry.
local root=assert(app.params.root)..'/'
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
local pal=Palette(7);pal:setColor(0,Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do pal:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local timing={80,55,125,80,55,125};local bob={0,1,-1,0,1,-1}
local function rect(im,x,y,w,h,c)
 for yy=y,y+h-1 do for xx=x,x+w-1 do if xx>=0 and xx<64 and yy>=0 and yy<64 then im:drawPixel(xx,yy,c) end end end
end
local function line(im,ax,ay,bx,by,width,c)
 local dx,dy=bx-ax,by-ay;local length=dx*dx+dy*dy
 for y=math.floor(math.min(ay,by)-width),math.ceil(math.max(ay,by)+width) do
  for x=math.floor(math.min(ax,bx)-width),math.ceil(math.max(ax,bx)+width) do
   local t=length==0 and 0 or math.max(0,math.min(1,((x-ax)*dx+(y-ay)*dy)/length))
   if (x-ax-t*dx)^2+(y-ay-t*dy)^2<=(width/2)^2 and x>=0 and x<64 and y>=0 and y<64 then im:drawPixel(x,y,c) end
  end
 end
end
local function leg(im,x,hip,sole,bent)
 local knee=hip+3
 line(im,x,hip,x+bent,knee,5,1);line(im,x,hip,x+bent,knee,3,2)
 line(im,x+bent,knee,x,sole-2,5,1);line(im,x+bent,knee,x,sole-2,3,2)
 rect(im,x-3,sole-3,7,4,1);rect(im,x-2,sole-2,5,2,2)
end
local function arm(im,left,swing,direction,dy)
 local shoulder=left and 25 or 37
 local side=left and -1 or 1
 local top=direction=='down' and 38 or 35
 local hand_y=top+2+math.floor(swing*4+0.5)
 local hand_x=shoulder+side*(swing<0.5 and 2 or 1)
 local elbow_x=shoulder+side*3
 line(im,shoulder,top+dy,elbow_x,top+3+dy,5,1)
 line(im,shoulder,top+dy,elbow_x,top+3+dy,3,3)
 line(im,elbow_x,top+3+dy,hand_x,hand_y+dy,4,1)
 rect(im,hand_x-1,hand_y-1+dy,3,3,5)
 rect(im,hand_x-1,hand_y-3+dy,3,2,4)
end
local result={}
for _,direction in ipairs({'down','up'}) do
 local base=app.open(root..'base/idle_'..direction..'.png')
 local original=Image(64,64,ColorMode.INDEXED);original:drawSprite(base,1);base:close()
 local s=Sprite(64,64,ColorMode.INDEXED);s:setPalette(pal);s.transparentColor=0
 s.layers[1].name='Left trouser and rigid boot'
 local right=s:newLayer();right.name='Right trouser and rigid boot'
 local arms=s:newLayer();arms.name='Opposing sleeve and hand swing'
 local body=s:newLayer();body.name='Approved face hair chest and backpack'
 local poses={}
 for f=1,6 do
  if f>1 then s:newEmptyFrame(f) end
  local phase=(f-1)%3;local leading_left=f<=3
  if direction=='up' then leading_left=not leading_left end
  local dy=bob[f];local hip=46+dy
  local left_image=Image(64,64,ColorMode.INDEXED);local right_image=Image(64,64,ColorMode.INDEXED)
  local left_sole=leading_left and 53 or 50;local right_sole=leading_left and 50 or 53
  if phase==1 then if leading_left then right_sole=49 else left_sole=49 end end
  if phase==2 then left_sole=leading_left and 50 or 48;right_sole=leading_left and 48 or 50 end
  leg(left_image,28,hip,left_sole,leading_left and -1 or 1)
  leg(right_image,35,hip,right_sole,leading_left and -1 or 1)
  local arm_image=Image(64,64,ColorMode.INDEXED)
  local swing=({0,0.25,0.75,1,0.75,0.25})[f]
  if direction=='up' then swing=1-swing end
  arm(arm_image,true,swing,direction,dy)
  arm(arm_image,false,1-swing,direction,dy)
  local torso=Image(64,64,ColorMode.INDEXED)
  local head_end=direction=='down' and 36 or 33
  for y=0,45 do for x=0,63 do
   if y<=head_end or (x>=26 and x<=37) then
    local c=original:getPixel(x,y)
    if c>0 and y+dy>=0 then torso:drawPixel(x,y+dy,c) end
   end
  end end
  s:newCel(s.layers[1],f,left_image);s:newCel(right,f,right_image)
  s:newCel(arms,f,arm_image);s:newCel(body,f,torso);s.frames[f].duration=timing[f]/1000
  local merged=Image(64,64,ColorMode.INDEXED);merged:drawSprite(s,f);poses[f]=merged
 end
 local tag=s:newTag(1,6);tag.name='run_'..direction
 s:saveAs(root..'source/run_'..direction..'.aseprite')
 s:saveCopyAs(root..'source/run_'..direction..'_native.aseprite');s:close()
 result[direction]=poses
end
return result
