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
    local old_key = makekey(obj.x,obj.y)
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
  if (k=="x") then x = x + offset
  else y = y + offset
  end
  local key=makekey(x,y)

  -- divide by 8 to get pixel to map coordinates
  local mapsprite = mget(x/8+ mapxoffset,y/8+mapyoffset)
  if (fget(mapsprite,1) and ms[key]==nil) then
    animate(obj,k, obj[k] + offset,linear,3)
    return true
  elseif (fget(mapsprite,0) or (ms[key] ~= nil and fget(ms[key].n,0))) then
    return false
  elseif (ms[key]~=nil) then
    local flag = blockmove(ms[key], k, offset)
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

function laserhitanimation(x,y,c)
  for i=1,1 do
    local x0 = flr(rnd(5)) + x - 3
    local y0 = flr(rnd(5)) + y - 3
    pset(x0,y0,c)
  end
end

function lerp(a,b,t)
  return a+(b-a)*t
end

-- start adding animation curves here

function linear(t)
  return t
end

