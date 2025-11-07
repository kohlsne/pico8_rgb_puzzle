-- called once on program starup
function _init()
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
  n_ulaser=19
  n_urlaser=20
  n_rlaser=21
  n_fsmirror=23
  n_bsmirror=24
  n_hmirror=25
  n_vmirror=26

  routines={}
  ms={} --interactive/movable sprites
  tableinit()

  --menuinit()
  menuinit()
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
    --elseif (btnp(4)) then blockmove(plr,"x",-8) --z
    elseif (btnp(5)) then resetlogic()--x
    end

  if (level==0) then
    menulogic()
  elseif (level==1) then
    level1logic()
  elseif (level==2) then
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
  map(mapxoffset,0,0,0,16,16)
  if (level==0) then
    camera(-2*8,-12*8)
    print("press z to reset level")
    print("press x to rotate block")
    print("press x to continue")
    camera(0,0)
  elseif(level==1) then
  elseif level==2 then
    --Set a screen offset of -x, -y for all drawing operations
    -- camera(16,0)
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
        elseif value.d == "ur" then
          spr(value.n,value.x,value.y,1,1,false,false)
        elseif value.d == "r" then
          spr(value.n,value.x,value.y,1,1,false,false)
        elseif value.d == "dr" then
          spr(value.n,value.x,value.y,1,1,false,true)
        elseif value.d == "d" then
          spr(value.n,value.x,value.y,1,1,true,true)
        elseif value.d == "dl" then
          spr(value.n,value.x,value.y,1,1,true,true)
        elseif value.d == "l" then
          spr(value.n,value.x,value.y,1,1,true,false)
        elseif value.d == "ul" then
          spr(value.n,value.x,value.y,1,1,true,false)
        end
      end
      pal()
    end
    if value.n == n_ulaser or value.n == n_urlaser or value.n == n_rlaser and value.active == true then
      add(lasers,value)
    end
  end
  -- need to draw lasers last
  --foreach(lasers,laserdraw)
   for v in all(lasers) do laserdraw(v.n,v.x,v.y,v.d,v.color) end
 -- for key, value in ipairs(lasers) do
 --   print(value.n)
 -- end
 -- for key, value in pairs(mirroroffset) do
 --   print(key)
 -- end
end


function async(func)
  add(routines,cocreate(func))
end


