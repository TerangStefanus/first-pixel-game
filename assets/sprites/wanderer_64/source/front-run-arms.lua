-- Hand-pixelled native-size sleeves, fists and elbows. MetroCity supplies the
-- pose order; its tiny hand masks are deliberately NOT scaled into this hero.
local pass={'.OOOO.','OGGGGO','OGGGGO','.OGGGO','.OGGGO','.OCCCO','.OSSSO','.OSSSO','.OSSSO','..OOO.'}
local back={'.OOOO.','OGGGGO','OGGGGO','OGGGGO','.OGGGO','.OCCCO','.OSSSO','.OSSSO','.OSSSO','..OOO.'}
local front={'...OOO..','..OGGGO.','.OGGGGO.','.OGGGGO.','..OGGGO.','.OCCCO..','OSSSO...','OSSSO...','OSSSO...','.OOO....'}
local color={O=1,G=3,C=4,S=5}
local function stamp(im,pattern,x,y,mirror)
 for iy,row in ipairs(pattern) do for ix=1,#row do
  local c=color[row:sub(ix,ix)]
  if c then im:drawPixel(x+(mirror and #row-ix or ix-1),y+iy-1,c) end
 end end
end
return function(direction,frame,behind,ahead)
 local dy=direction=='up' and -2 or 0
 local phase=(frame-1)%3
 local left_leads=frame>=5
 if frame==1 or frame==4 then
  stamp(behind,pass,21,37+dy,false);stamp(behind,pass,39,37+dy,true)
 else
  -- Keep the observed screen-side sequence in both reference directions.
  local forward_left=left_leads
  local rise=phase==2 and -1 or 0
  if forward_left then
   stamp(behind,back,39,37+dy+rise,true)
   stamp(ahead,front,23,34+dy+rise,true)
  else
   stamp(behind,back,21,37+dy+rise,false)
   stamp(ahead,front,35,34+dy+rise,false)
  end
 end
end
