function resetlogic()
  if level==0 then
    menuinit()
  elseif level==1 then
    level1init()
  elseif level==2 then
    level2init()
  end
end

function menulogic()
  if ms[makekey(16*8,1*8)] ~= nil and ms[makekey(16*8,1*8)].n == n_plr then
    level1init()
  end
end

function level1logic()
  --Add wall lock
  if ms[makekey(0*8,1*8)] ~= nil and ms[makekey(0*8,1*8)].n == n_plr and ms[makekey(-8,1*8)] == nil then
    ms[makekey(-8,1*8)] = { n=n_wall,   x=-8,   y=1*8,  moving=false }
  end
  if ms[makekey(1*8,1*8)] ~= nil and ms[makekey(1*8,1*8)].n == n_plr and ms[makekey(0*8,1*8)] == nil then
    ms[makekey(0*8,1*8)] = { n=n_wall,   x=0*8,   y=1*8,  moving=false }
    ms[makekey(-8,1*8)] = nil
  end
  -- first switch
  gatelogic(makekey(12*8,14*8),makekey(9*8,13*8),red)
  gatelogic(makekey(8*8,4*8),makekey(10*8,4*8),blue)
  gatelogic(makekey(8*8,3*8),makekey(10*8,3*8),green)
  gatelogic(makekey(8*8,1*8),makekey(10*8,2*8),red)

  if ms[makekey(16*8,7*8)] ~= nil and ms[makekey(16*8,7*8)].n == n_plr then
    level2init()
  end
end

function level2logic()
  -- add wall upon entry
  if ms[makekey(0*8,7*8)] ~= nil and ms[makekey(0*8,7*8)].n == n_plr and ms[makekey(-8,7*8)] == nil then
    ms[makekey(-8,7*8)] = { n=n_wall,   x=-8,   y=7*8,  moving=false }
  end
  if ms[makekey(1*8,7*8)] ~= nil and ms[makekey(1*8,7*8)].n == n_plr and ms[makekey(0*8,7*8)] == nil then
    ms[makekey(0*8,7*8)] = { n=n_wall,   x=0*8,   y=7*8,  moving=false }
    ms[makekey(-8,7*8)] = nil
  end
end

function gatelogic(switchkey,gatekey,color)
  -- switch key in the table will be the block
  if ms[switchkey] ~= nil and ms[gatekey] ~= nil and ms[gatekey].moving == false and ms[switchkey].n == n_colorblock and ms[switchkey].color == color and ms[gatekey].color == color and fget(ms[gatekey].n,0) == true  then
    gateopen(ms[gatekey], 10, {n_gate+1,n_gate+2,n_gate+3,0})
  end
end
