-- called once on program starup
function _init()
  mapyoffset = 0
  mapxoffset = 0
  white=7
  gray=6
  red=8
  green=11
  blue=12
  black=0
  backgroundcolor=3

  n_plr=1
  n_uplr=n_plr+1
  n_rplr=n_plr+2
  n_dplr=n_plr+3
  n_lplr=n_plr+4
  n_wall=6
  n_neturalblock=7
  n_colorblock=8
  n_switchred=9
  n_switchgreen=n_switchred+1
  n_switchblue=n_switchred+2
  n_ulaser=12
  n_urlaser=13
  n_rlaser=14
  n_crystal=15
  n_fsmirror=16
  n_bsmirror=n_fsmirror+1
  n_hmirror=n_fsmirror+2
  n_vmirror=n_fsmirror+3
  n_vgate=20
  n_hgate=24

  routines={}
  ms={} --interactive/movable sprites
  lasertbl={}
  switchtbl={}
  tableinit()

  menuinit()
  --level1init()
end

function makekey(x, y)
    return tostring(x) .. "_" .. tostring(y)
end

-- called once per update at 30 fps
function _update()
    if (btnp(0)) then blockmove(plr,"x",-8) plr.n = n_lplr plr.d = "l" --left
    elseif (btnp(1)) then blockmove(plr,"x",8) plr.n = n_rplr plr.d = "r"--right
    elseif (btnp(2)) then blockmove(plr,"y",-8) plr.n = n_uplr plr.d = "u"--up
    elseif (btnp(3)) then blockmove(plr,"y",8) plr.n = n_dplr plr.d = "d"--down
    elseif (btnp(4)) then resetlogic()--z
    elseif (btnp(5)) then rotateblock()--x
    end

  walllocks()
  if (level==0) then
    menulogic()
  elseif (level==1) then
    level1logic()
  elseif (level==2) then
    level2logic()
  end

  lasertbl = nil
  lasertbl = {}
  for key, value in pairs(ms) do
    if value.n == n_ulaser or value.n == n_urlaser or value.n == n_rlaser  then
      if (value.color == red and redactive) or (value.color == green and greenactive) or (value.color == blue and blueactive) or (value.color == white and white) then
        updatelasers(value.n,value.x,value.y,value.d,value.color)
      end
    end
  end

  switchlogic()

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
    camera(-1*8-2,-9*8-2)
    print("press z to reset level")
    print("press x to rotate block")
    camera(0,0)
  elseif(level==1) then
  elseif level==2 then
    --Set a screen offset of -x, -y for all drawing operations
    -- camera(16,0)
 --    MAP(TILE_X, TILE_Y, [SX, SY], [TILE_W, TILE_H], [LAYERS])
--Draw section of map (starting from TILE_X, TILE_Y) at screen position SX, SY (pixels)
  end

  for v in all(lasertbl) do
    line(v.x0,v.y0,v.x1,v.y1,v.c)
    --laserhitanimation(v.x0,v.y0,v.c)
  end


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
    if value.n == n_crystal then
      print(value.active)
    end
  end

-- for key, value in ipairs(laserspritestbl) do
 --   print(value.n)
 -- end
 -- for key, value in pairs(mirroroffset) do
 --   print(key)
 -- end
end


function async(func)
  add(routines,cocreate(func))
end


-- todo
-- backround color same as eye, laser can get into player sprite
-- when a laser touches a crystal switch it to active
-- colorblock should also contain where the switch is
