function resetlogic()
  if plr.moving==false then
    if level==0 then
      menuinit()
    elseif level==1 then
      level1init()
    elseif level==2 then
      level2init()
    end
  end
end

function menulogic()
  if ms[makekey(16*8,1*8)] ~= nil and ms[makekey(16*8,1*8)] == plr then
    level1init()
  end
 --crystallogic(makekey(8*8,12*8),makekey(9*8,14*8),white)
--  ms[makekey(8*8, 12*8)] = { n=n_crystal,x=8*8, y=12*8, moving=false , color=white}
--  ms[makekey(9*8, 14*8)] = { n=n_hgate,           x=9*8,   y=14*8,  moving=false , color=white}
end

function walllocks()
  --remove plr logic and just run when plr is seletcted?
  local y = starty
  --Add wall lock
  if ms[makekey(0,y)] ~= nil and ms[makekey(0,y)] == plr and ms[makekey(-8,y)] == nil then
    ms[makekey(-8,y)] = { n=n_wall,   x=-8,   y=y,  moving=false }
  end
  if ms[makekey(1*8,y)] ~= nil and ms[makekey(1*8,y)] == plr and ms[makekey(0,y)] == nil then
    ms[makekey(0,y)] = { n=n_wall,   x=0,   y=y,  moving=false }
    ms[makekey(-8,y)] = nil
  end
end

function level1logic()
  --Add wall lock
 -- if ms[makekey(0*8,1*8)] ~= nil and ms[makekey(0*8,1*8)] == plr and ms[makekey(-8,1*8)] == nil then
 --   ms[makekey(-8,1*8)] = { n=n_wall,   x=-8,   y=1*8,  moving=false }
 -- end
 -- if ms[makekey(1*8,1*8)] ~= nil and ms[makekey(1*8,1*8)] == plr and ms[makekey(0*8,1*8)] == nil then
 --   ms[makekey(0*8,1*8)] = { n=n_wall,   x=0*8,   y=1*8,  moving=false }
 --   ms[makekey(-8,1*8)] = nil
 -- end
  -- first switch
 -- switchlogic(makekey(12*8,14*8),makekey(9*8,13*8),red)
 -- switchlogic(makekey(8*8,4*8),makekey(10*8,4*8),blue)
 -- switchlogic(makekey(8*8,3*8),makekey(10*8,3*8),green)
 -- switchlogic(makekey(8*8,1*8),makekey(10*8,2*8),red)

  if ms[makekey(16*8,7*8)] ~= nil and ms[makekey(16*8,7*8)] == plr then
    level2init()
  end
end

function level2logic()
end

--function switchlogic(switchkey,gatekey,color)
--  -- switch key in the table will be the block
--  if ms[switchkey] ~= nil and ms[gatekey] ~= nil and ms[gatekey].moving == false and ms[switchkey].n == n_colorblock and ms[switchkey].color == color and ms[gatekey].color == color and fget(ms[gatekey].n,0) == true  then
--    gateopen(ms[gatekey], 10, {ms[gatekey].n+1,ms[gatekey].n+2,ms[gatekey].n+3,0})
--  end
--end

function switchlogic()
  for switch  in all(switchtbl) do
    local switchkey = makekey(switch.x,switch.y)
    --ms switchkey will be colorblock
    if (ms[switchkey] ~= nil and ms[switchkey].n == n_colorblock and ms[switchkey].color == switch.c) then
      switch.active = true
      if switch.activatelaser == true then
        if switch.c == red and redactive == false then sfx(4) redactive = true end
        if switch.c == green and greenactive == false then sfx(4) greenactive = true end
        if switch.c == blue and blueactive == false then  sfx(4) blueactive = true end
      else --  gateopen
        local gatekey = makekey(switch.xgate,switch.ygate)
        if ms[gatekey] ~= nil and (ms[gatekey].n == n_hgate or ms[gatekey].n == n_vgate) and (ms[gatekey].moving == false) then
          gateopen(ms[gatekey], 10, {ms[gatekey].n+1,ms[gatekey].n+2,ms[gatekey].n+3,ms[gatekey].n+4})
        end
      end
    --elseif (ms[switchkey] ~=nil and ms[switchkey].n ~= n_colorblock) or (ms[switchkey] ~=nil and ms[switchkey].n == n_colorblock and ms[switchkey].color ~= switch.c) or (ms[switchkey]==nil) then
    --elseif ms[switchkey] == nil or ms[switchkey].n ~= n_colorblock or ms[switchkey].color ~= switch.c then
    else
      switch.active = false
      if switch.activatelaser == true then
        if switch.c == red and redactive == true then sfx(3) redactive = false end
        if switch.c == green and greenactive == true then sfx(3) greenactive = false end
        if switch.c == blue and blueactive == true then sfx(3) blueactive = false end
      else -- gate close
        local gatekey = makekey(switch.xgate,switch.ygate)
      --  if ms[gatekey] ~= nil then return end

        if ms[gatekey] == nil then
          if switch.isvgate == true then ms[gatekey] = { n=n_vgate+4, x=switch.xgate, y=switch.ygate, moving=false, color = switch.c}
          else                           ms[gatekey] = { n=n_hgate+4, x=switch.xgate, y=switch.ygate, moving=false, color = switch.c}
          end
          gateclose(ms[gatekey], 10, {ms[gatekey].n,ms[gatekey].n-1,ms[gatekey].n-2,ms[gatekey].n-3,ms[gatekey].n-4})
        end
      end
    end
  end
end


function crystallogic(crystalkey)
  -- switch key in the table will be the block
  if ms[crystalkey] ~= nil then
    local gatekey = makekey(ms[crystalkey].xgate,ms[crystalkey].ygate)
    if  ms[crystalkey].active == true and ms[gatekey] ~= nil and ms[gatekey].moving == false and (ms[gatekey].n == n_hgate or ms[gatekey].n == n_vgate)  then
      gateopen(ms[gatekey], 10, {ms[gatekey].n+1,ms[gatekey].n+2,ms[gatekey].n+3,ms[gatekey].n+4})
    elseif  ms[gatekey] == nil and ms[crystalkey].active ==  false then
      if ms[crystalkey].isvgate == true then ms[gatekey] = { n=n_vgate+4, x=ms[crystalkey].xgate, y=ms[crystalkey].ygate, moving=false, color = ms[crystalkey].color}
      else                           ms[gatekey] = { n=n_hgate+4, x=ms[crystalkey].xgate, y=ms[crystalkey].ygate, moving=false, color = ms[crystalkey].color}
      end
      gateclose(ms[gatekey], 10, {ms[gatekey].n,ms[gatekey].n-1,ms[gatekey].n-2,ms[gatekey].n-3,ms[gatekey].n-4})
    end
  end
end

function rotateblock()
  if plr.moving == true or plr.d ==nil then
    return
  end

  local x = plr.x + directionchangetable[plr.d].dx * 8
  local y = plr.y + directionchangetable[plr.d].dy * 8
  local key = makekey(x,y)
  local o = ms[key]
  if o==nil or (o.n~=n_ulaser and o.n~=n_urlaser and o.n~=n_rlaser and o.n~=n_fsmirror and o.n~=n_bsmirror and o.n~=n_hmirror and o.n~=n_vmirror) then
    return
  end
  sfx(1)

  if o.n == n_ulaser and o.d == "u" then
    o.n = n_urlaser
    o.d = "ur"
  elseif o.n == n_urlaser and o.d == "ur" then
    o.n = n_rlaser
    o.d = "r"
  elseif o.n == n_rlaser and o.d == "r" then
    o.n = n_urlaser
    o.d = "dr"
  elseif o.n == n_urlaser and o.d == "dr" then
    o.n = n_ulaser
    o.d = "d"
  elseif o.n == n_ulaser and o.d == "d" then
    o.n = n_urlaser
    o.d = "dl"
  elseif o.n == n_urlaser and o.d == "dl" then
    o.n = n_rlaser
    o.d = "l"
  elseif o.n == n_rlaser and o.d == "l" then
    o.n = n_urlaser
    o.d = "ul"
  elseif o.n == n_urlaser and o.d == "ul" then
    o.n = n_ulaser
    o.d = "u"

  elseif o.n == n_hmirror then
      o.n = n_bsmirror
  elseif o.n == n_bsmirror then
      o.n = n_vmirror
  elseif o.n == n_vmirror then
      o.n = n_fsmirror
  elseif o.n == n_fsmirror then
      o.n = n_hmirror
  end
end



