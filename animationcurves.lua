-- https://www.lexaloffle.com/bbs/?tid=40577
-- types of blocks
-- walls, map wall that cant move
-- switches, map switches that can go over
-- movable blocks, in table of sprites 
--
--flag 0 is a wall not movable, cant pass through
--flag 1 is object not movable but can pass through
-- object key value aniamtion curve frames
function animate(obj,k,v,e,f)
  local init = obj[k]
  f=f or 30
  e=e or linear
  obj.moving = true
  async(function()
    old_key = makekey(obj.x,obj.y)
    for i=0,f do
      obj[k]=lerp(init,v,e(i/f))
      yield()
    end
    obj.moving = false
    updatetable(old_key,obj)
  end)
end

function updatetable(old_key,new_obj)
  local new_key = makekey(new_obj.x,new_obj.y)
  ms[new_key] = new_obj
  if (new_obj.n == 1) then
    plr = ms[new_key]
  end
  ms[old_key] = nil
  ms.old_key = nil
end

function blockmove(obj,k,offset)
  if (obj.moving == true) then
    return
  end
  local x = obj.x
  local y = obj.y
  local keyold=makekey(x,y)
  if (k=="x") then x += offset
  else y += offset
  end
  local key=makekey(x,y)

  here="1"
  -- divide by 8 to get pixel to map coordinates
  local mapsprite = mget(x/8+ mapxoffset,y/8+mapyoffset)
  if (fget(mapsprite,1) and ms[key]==nil) then
    here="2"
    animate(obj,k, obj[k] + offset,linear,3)
    return true
  elseif (fget(mapsprite,0) or (ms[key] ~= nil and fget(ms[key].n,0))) then
    here="3"
    return false
  elseif (ms[key]~=nil) then
    here="4"
    flag = blockmove(ms[key], k, offset)
    if (flag == false) then
      return false
    end
    animate(obj,k,obj[k]+offset,linear,3)
    return true
  end
end

function gateopen(obj,f,spritetable)
  local key = makekey(obj.x,obj.y)
  obj.moving = true
  async(function()
    for index, spritenum in ipairs(spritetable) do
      for j=0,f do
        yield()
      end
      obj.n = spritenum
    end
    ms[key] = nil
    ms.key = nil
  end)
end

function findlaserend(x,y,d)
  local dx = 0
  local dy = 0
  if d == "u" then
    dy = -1
    x=x+3
    y=y-1
  elseif d == "ur" then
    dx = 1
    dy = -1
  elseif d == "r" then
    dx = 1
    x=x+8
    y=y+3
  elseif d == "dr" then
    dx = 1
    dy = 1
  elseif d == "d" then
    dy = 1
    x=x+3
    y=y+8
  elseif d == "dl" then
    dx = -1
    dy = 1
  elseif d == "l" then
    dx = -1
    x=x-1
    y=y+3
  elseif d == "ul" then
    dx = -1
    dy = -1
  end

  local xx = x
  local yy = y
  local colorpixel = pget(x,y)
  if not (colorpixel == backgroundcolor or colorpixel == white or colorpixel == red or colorpixel == green or colorpixel == blue) then
    return 0,0,0,0
  end
  while colorpixel == backgroundcolor or colorpixel == white or colorpixel == red or colorpixel == green or colorpixel == blue do
    xx = xx + dx
    yy = yy + dy
    colorpixel = pget(xx,yy)
  end
  xx = xx - dx
  yy = yy - dy

  return x,y,xx,yy
end

function laserdraw(obj)
  local x,y,xx,yy = findlaserend(obj.x,obj.y,obj.d)
  if (x == 0 and y == 0 and xx == 0 and yy == 0) then
    return
  end
  line(x,y,xx,yy,obj.color)
  -- draw two lines if needed
  if (x == xx) then
    x,y,xx,yy = findlaserend(obj.x+1,obj.y,obj.d)
    line(x,y,xx,yy,obj.color)
  end
  if (y == yy) then
    x,y,xx,yy = findlaserend(obj.x,obj.y+1,obj.d)
    line(x,y,xx,yy,obj.color)
  end
end

function lerp(a,b,t)
  return a+(b-a)*t
end

-- start adding animation curves here

function linear(t)
  return t
end

