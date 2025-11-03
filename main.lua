-- called once on program starup
function _init()
  level="menu"
  mapyoffset = 0
  mapxoffset = 0
  white=7
  gray=6
  red=8
  green=11
  blue=12
  backgroundcolor=3
  n_plr=1
  n_colorblock=7
  n_neturalblock=13
  n_wall=6
  n_gate=14
  n_crystal=18
  n_laser=19

  routines={}
  ms={} --interactive/movable sprites
end

function makekey(x, y)
    return tostring(x) .. "_" .. tostring(y)
end

-- called once per update at 30 fps
function _update()
    if (btnp(0)) then blockmove(plr,"x",-8) --left
    elseif (btnp(1)) then blockmove(plr,"x",8) --right
    elseif (btnp(2)) then blockmove(plr,"y",-8) --up
    elseif (btnp(3)) then blockmove(plr,"y",8) --down
    elseif (btnp(4)) then blockmove(plr,"x",-8) --z
    --elseif (btnp(5)) then gateopen(ms[makekey(9*8, 13*8)], 20, {15,16,17}) --x
    end

  if (level=="menu") then
    menulogic()
  elseif (level=="1") then
    level1logic()
  elseif (level=="2") then
    level2logic()
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
  cls(backgroundcolor)
  if (level=="menu") then
    print("press z to reset level")
    print("press x to rotate block")
    print("press x to continue")
  elseif(level=="1") then
    map(0,0,0,0,16,16)
  elseif level=="2" then
    --Set a screen offset of -x, -y for all drawing operations
    -- camera(16,0)
    map(16,0,0,0,16,16)
 --    MAP(TILE_X, TILE_Y, [SX, SY], [TILE_W, TILE_H], [LAYERS])
--Draw section of map (starting from TILE_X, TILE_Y) at screen position SX, SY (pixels)
  end

  local lasers = {}
  for key, value in pairs(ms) do
    if value.color == nil then
      spr(value.n,value.x,value.y)
    else
      pal(white,value.color)
      if value.d == nil then
        spr(value.n,value.x,value.y)
      else
        if value.d == "u" then
          spr(value.n,value.x,value.y,1,1,false,false)
        elseif value.d == "up" then
        elseif value.d == "ur" then
        elseif value.d == "r" then
          spr(value.n+1,value.x,value.y,1,1,false,false)
        elseif value.d == "dr" then
        elseif value.d == "d" then
          spr(value.n,value.x,value.y,1,1,false,true)
        elseif value.d == "dl" then
        elseif value.d == "l" then
          spr(value.n+1,value.x,value.y,1,1,true,false)
        elseif value.d == "ul" then
        end
      end
      pal()
    end
    if value.n == n_laser and value.active == true then
      add(lasers,value)
    end
  end
  -- need to draw lasers last
  foreach(lasers,laserdraw)
 -- for key, value in ipairs(lasers) do
 --   print(value.n)
 -- end
end


function async(func)
  add(routines,cocreate(func))
end


