-- types of blocks
-- walls, map wall that cant move
-- switches, map switches that can go over
-- movable blocks, in table of sprites 
--
--flag 0 is a wall not movable, cant pass through
--flag 1 is object not movable but can pass through
-- object key value aniamtion curve frames
function animate(obj,k,v,e,f,tablekey)
  local init = obj[k]
  f=f or 30
  e=e or linear
  obj.moving = true
  async(function()
    for i=0,f do
      obj[k]=lerp(init,v,e(i/f))
      yield()
    end
    obj.moving = false
    updatetable(obj,tablekey)
  end)
end

function updatetable(obj,key)
  old = ms[key]
  newkey = makekey(obj.x,obj.y)
  ms[newkey] = obj
  if (obj.n == 1) then
    plr = ms[newkey]
  end
  ms[key] = nil
  ms.key = nil
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
  local mapsprite = mget(x/8,y/8)
  if (fget(mapsprite,1) and ms[key]==nil) then
    here="2"
  --  ms[keyold] = nil
  --  ms[key] = { n=obj.n, x=x, y=y, moving=true}
    --animate(ms[key],k, ms[key][k] + offset,linear,3)
    -- obj.moving = true
   -- ms[key] = { n=obj.n, x=obj.x, y=obj.y, moving=true}
   -- ms[keyold] = nil
   -- obj=mil
    animate(obj,k, obj[k] + offset,linear,3,keyold)
    return true
  elseif (fget(mapsprite,0)) then
    here="3"
    return false
  elseif (ms[key]~=nil) then
    here="4"
--    return false
    flag = blockmove(ms[key], k, offset)
    if (flag == false) then
      return false
    end
    animate(obj,k,obj[k]+offset,linear,3,keyold)
   --   obj.moving=false
  end
end

function lerp(a,b,t)
  return a+(b-a)*t
end

-- start adding animation curves here

function linear(t)
  return t
end

function easeinelastic(t)
	if(t==0) return 0
	return 2^(10*t-10)*cos(2*t-2)
end

function easeinquad(t)
	return t*t
end
