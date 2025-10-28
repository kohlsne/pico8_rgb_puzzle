-- called once on program starup
function _init()
  state="menu"
  routines={}
  --plr = { n=1, x=1*8, y=1*8, moving=false }
  --interactive/movable sprites
  ms={}
  ms[makekey(1*8, 1*8)] = { n=1, x=1*8, y=1*8, moving=false }
  ms[makekey(4*8, 1*8)] = { n=13, x=4*8, y=1*8, moving=false }
  ms[makekey(5*8, 2*8)] = { n=13, x=5*8, y=2*8, moving=false }
  ms[makekey(5*8, 3*8)] = { n=13, x=5*8, y=3*8, moving=false }
  ms[makekey(1*8, 5*8)] = { n=13, x=1*8, y=5*8, moving=false }
  ms[makekey(3*8, 5*8)] = { n=13, x=3*8, y=5*8, moving=false }
  ms[makekey(1*8, 7*8)] = { n=13, x=1*8, y=7*8, moving=false }
  ms[makekey(3*8, 7*8)] = { n=13, x=3*8, y=7*8, moving=false }
  ms[makekey(4*8, 11*8)] = { n=13, x=4*8, y=11*8, moving=false }
  ms[makekey(2*8, 12*8)] = { n=13, x=2*8, y=12*8, moving=false }
  ms[makekey(8*8, 14*8)] = { n=7, x=8*8, y=14*8, moving=false }
 -- ms[makekey(4*8, 5*8)] = { n=13, x=4*8, y= 5*8, moving=false }
 -- ms[makekey(5*8, 5*8)] = { n=13, x=5*8, y= 5*8, moving=false }
  -- ms[makekey(7*8, 7*8)] = { n=13, x=5*8, y= 5*8, moving=false }
  plr = ms[makekey(8,8)]
end

function makekey(x, y)
    return tostring(x) .. "_" .. tostring(y)
end

-- called once per update at 30 fps
function _update()
  if (state=="menu") then
    if (btn(5)) then
      state="1"
    end
  elseif (state=="1") then
    if (btnp(0)) then blockmove(plr,"x",-8) --left
    elseif (btnp(1)) then blockmove(plr,"x",8) --right
    elseif (btnp(2)) then blockmove(plr,"y",-8) --up
    elseif (btnp(3)) then blockmove(plr,"y",8) --down
    elseif (btnp(4)) then blockmove(plr,"x",-8) --z
--    elseif (btnp(5)) then updatetable(plr,) --x
    end
  end
local function makeKey(x, y)
    return x .. "_" .. y
end
  for r in all(routines) do
    if (costatus(r)) == "dead" then
      del(routines,r)
    else
      assert(coresume(r))
    end
  end
end

-- called once per visible frame normally called at 30fps, if not possible 15 fps while calling update twice
function _draw()
  cls(3)
  if (state=="menu") then
    print("press x to continue")
  elseif(state=="1") then
    --camera(plr.x - 64, plr.y - 64)
    map()
    --spr(plr.n,plr.x,plr.y)
    -- Loop through the table
  --    print("player")
  --    print(plr.n)
  --    print(plr.x)
  --    print(plr.y)
    for key, value in pairs(ms) do
      spr(value.n,value.x,value.y)
  --    print(key)
  --    print(value.n)
  --    print(value.x)
  --    print(value.y)
    end
    print(here)
  end
end


function async(func)
  add(routines,cocreate(func))
end


