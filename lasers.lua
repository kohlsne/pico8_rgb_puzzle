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
  local spritex = flr(xx/8)
  local spritey = flr(yy/8)
  local crystal = ms[makekey(spritex*8,spritey*8)]
  if crystal ~= nil and crystal.n == n_crystal and crystal.color == c then
    crystal.active = true
  end
  if colorpixel == gray then
    mirrordraw(xx,yy,d,c)
  end
  return xx,yy, false
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
  add(lasertbl,{x0=x0,y0=y0,x1=x1,y1=y1,c=c})
end

function updatelasers(n,x,y,d,c)
  local x0,y0,fail0 = findlaserbegin(x,y,d,n)
  local x1,y1,fail1 = findlaserend(x0,y0,d,c)
  if (fail0 or fail1) then
    return
  end
  add(lasertbl,{x0=x0,y0=y0,x1=x1,y1=y1,c=c})
  if n == n_urlaser then
    return
  end
  -- draw two lines if needed
  if (x0 == x1) then
    x1,y1,fail0 = findlaserend(x0+1,y0,d,c)
    if (fail0 or fail1) then
      return
    end
    add(lasertbl,{x0=x0+1,y0=y0,x1=x1,y1=y1,c=c})
  end
  if (y0 == y1) then
    x1,y1,fail0 = findlaserend(x0,y0+1,d,c)
    if (fail0 or fail1) then
      return
    end
    add(lasertbl,{x0=x0,y0=y0+1,x1=x1,y1=y1,c=c})
  end
end

function deactivatecrystals()
  for v in all(lasertbl) do
    local x = flr(v.x1/8) * 8
    local y = flr(v.y1/8) * 8
    local block = ms[makekey(x,y)]
    if block ~= nil and block.n == n_crystal then block.active = false end
  end
end
