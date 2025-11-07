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
  if (k=="x") then x += offset
  else y += offset
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

function findlaserend(x,y,d,c)
  local dx = directionchangetable[d].dx
  local dy = directionchangetable[d].dy
  local xx = x
  local yy = y
  local colorpixel = pget(x,y)
  if not (colorpixel == backgroundcolor or colorpixel == white or colorpixel == red or colorpixel == green or colorpixel == blue) then
    return 0,0,true
  end
  while colorpixel == backgroundcolor or colorpixel == white or colorpixel == red or colorpixel == green or colorpixel == blue do
    xx = xx + dx
    yy = yy + dy
    colorpixel = pget(xx,yy)
  end
  xx = xx - dx
  yy = yy - dy
  if colorpixel == gray then
    mirrordraw(xx,yy,d,c)
  end
  return xx,yy, false
end

function findlaserbegin(x,y,d,n)
  local dx = 0
  local dy = 0
  if n == n_ulaser or n == n_urlaser or n == n_rlaser then
    dx = laseroffset[d].dx
    dy = laseroffset[d].dy
  elseif n == n_fsmirror or n == n_bsmirror or n == n_hmirror or n == n_vmirror then
    local key = makekey(d,n)
    if mirroroffset[key] == nil then
      return 0,0, true
    end
    dx = mirroroffset[key].dx
    dy = mirroroffset[key].dy
  end
  local x0 = x + dx
  local y0 = y + dy
  local colorpixel = pget(x0,y0)
  if not (colorpixel == backgroundcolor or colorpixel == white or colorpixel == red or colorpixel == green or colorpixel == blue) then
    return 0,0, true
  else return x0, y0, false
  end
end

function laserdraw(n,x,y,d,c)
  local x0,y0,fail0 = findlaserbegin(x,y,d,n)
  local x1,y1,fail1 = findlaserend(x0,y0,d,c)
  if (fail0 or fail1) then
    return
  end
  line(x0,y0,x1,y1,c)
  if n == n_urlaser then
    return
  end
  -- draw two lines if needed
  if (x0 == x1) then
    x1,y1,fail0 = findlaserend(x0+1,y0,d,c)
    if (fail0 or fail1) then
      return
    end
    line(x0+1,y0,x1,y1,c)
  end
  if (y0 == y1) then
    x1,y1,fail0 = findlaserend(x0,y0+1,d,c)
    if (fail0 or fail1) then
      return
    end
    line(x0,y0+1,x1,y1,c)
  end
end

function mirrordraw(x,y,d,c)
  -- need to know which way the laser came and the mirror that was hit to know where its going
  local spritex = flr(x/8)
  local spritey = flr(y/8)
  local mirror = ms[makekey(spritex*8,spritey*8)]
  if mirror == nil then
    return
  end
  local x0,y0,fail0 = findlaserbegin(x,y,d,mirror.n)
  local key = makekey(d,mirror.n)
  if mirroroffset[key] == nil or fail0 then
    return
  end
  local d1 = mirroroffset[key].d
  local x1,y1,fail1 = findlaserend(x0,y0,d1,c)
  if fail1 then
    return
  end
  line(x0,y0,x1,y1,c)

end

function lerp(a,b,t)
  return a+(b-a)*t
end

-- start adding animation curves here

function linear(t)
  return t
end

