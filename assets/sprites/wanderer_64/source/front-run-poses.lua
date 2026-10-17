-- Reference-retargeted front/back cycle, derived from JIK-A-4's CC0 MetroCity
-- official six-pose preview. See reference/metrocity/SOURCE.md and pose-masks.json.
-- Each silhouette is an observed pose, not a joint/sine-wave generator.
local root=assert(app.params.root)..'/'
local masks=dofile(root..'reference/metrocity/pose-masks.lua')
local draw_arms=dofile(root..'source/front-run-arms.lua')
local colors={{37,35,35},{87,66,54},{104,115,75},{230,207,154},{215,155,91},{173,87,57}}
local pal=Palette(7);pal:setColor(0,Color{r=0,g=0,b=0,a=0})
for i,c in ipairs(colors) do pal:setColor(i,Color{r=c[1],g=c[2],b=c[3],a=255}) end
local bob={0,-1,-1,0,-1,-1}
local result={timing={90,90,90,90,90,90}}
for _,direction in ipairs({'down','up'}) do
 local base=app.open(root..'base/idle_'..direction..'.png')
 local original=Image(64,64,ColorMode.INDEXED);original:drawSprite(base,1);base:close()
 local s=Sprite(64,64,ColorMode.INDEXED);s:setPalette(pal);s.transparentColor=0
 s.layers[1].name='Observed trouser and boot silhouettes - CC0 reference'
 local clothing=s:newLayer();clothing.name='Observed sleeve and hand poses - hero palette'
 local identity=s:newLayer();identity.name='Wanderer scarf chest and backpack'
 local foreground=s:newLayer();foreground.name='Full native-size forward fist and bent sleeve'
 local head=s:newLayer();head.name='Approved hair and face - pixel preserved'
 local poses={}
 for f=1,6 do
  if f>1 then s:newEmptyFrame(f) end
  local leg_image=Image(64,64,ColorMode.INDEXED)
  local coat_image=Image(64,64,ColorMode.INDEXED)
  local own=Image(64,64,ColorMode.INDEXED)
  local front_arms=Image(64,64,ColorMode.INDEXED)
  local head_image=Image(64,64,ColorMode.INDEXED)
  local boots=Image(64,64,ColorMode.INDEXED)
  local grid=masks[direction][f]
  -- Retarget the reference's 13-row body to the hero's 17-row body. The reference
  -- clothing/limb boundaries, overlap and contact sequence remain in each pose.
  for y=34,53 do for x=19,44 do
   local sx=math.floor(17.5+(x-31.5)/1.5+0.5)
   local sy=math.floor(19+(y-37)*0.75+0.5)
   if sx>=0 and sx<36 and sy>=0 and sy<36 then
    local code=grid[sy+1]:sub(sx+1,sx+1)
    if code=='P' then leg_image:drawPixel(x,y,2)
    elseif code=='B' then leg_image:drawPixel(x,y,1);boots:drawPixel(x,y,2)
    elseif code=='Q' or code=='K' then leg_image:drawPixel(x,y,1)
    elseif code=='T' then coat_image:drawPixel(x,y,3)
    elseif code=='O' then coat_image:drawPixel(x,y,1)
    end
   end
  end end
  -- Keep the observed torso/legs. Replace tiny reference arm fragments with
  -- deliberately painted hero-size sleeves and complete 3x3 palms.
  for y=34,53 do for x=19,44 do
   if x<26 or x>38 then coat_image:drawPixel(x,y,0) end
   if boots:getPixel(x,y)>0 then
    if boots:getPixel(x,y-1)>0 then leg_image:drawPixel(x,y,2) end
    if leg_image:getPixel(x,y+1)==0 then leg_image:drawPixel(x,y+1,1) end
   end
  end end
  draw_arms(direction,f,coat_image,front_arms)
  -- Apply the approved character identity to the observed moving silhouette.
  local cut=direction=='down' and 36 or 33
  for y=0,45 do for x=0,63 do
   local dy=y+bob[f];local c=original:getPixel(x,y)
   if c>0 and dy>=0 then
    if y<=cut then head_image:drawPixel(x,dy,c)
    elseif x>=26 and x<=37 then
     local occupied=coat_image:getPixel(x,dy)>0
     local neck=y<=cut+4 and x>=27 and x<=35
     if occupied or neck then
      if c~=5 or y<40 then own:drawPixel(x,dy,c) end
     end
    end
   end
  end end
  s:newCel(s.layers[1],f,leg_image)
  s:newCel(clothing,f,coat_image)
  s:newCel(identity,f,own)
  s:newCel(foreground,f,front_arms)
  s:newCel(head,f,head_image)
  s.frames[f].duration=0.090
  local merged=Image(64,64,ColorMode.INDEXED);merged:drawSprite(s,f);poses[f]=merged
 end
 local tag=s:newTag(1,6);tag.name='run_'..direction
 s:saveAs(root..'source/run_'..direction..'.aseprite')
 s:saveCopyAs(root..'source/run_'..direction..'_native.aseprite')
 s:saveCopyAs(root..'source/run_'..direction..'_reference.aseprite');s:close()
 result[direction]=poses
end
return result
