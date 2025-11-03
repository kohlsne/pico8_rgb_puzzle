function level1init()
  level="1"
  mapxoffset = 0
  mapyoffset = 0
  local startx = 10*8
  local starty = 1*8
  ms = nil
  ms = {}
  ms[makekey(startx, starty)] = { n=n_plr, x=startx, y=starty, moving=false }
  ms[makekey(4*8, 1*8)]  = { n=n_neturalblock,   x=4*8,   y=1*8,   moving=false }
  ms[makekey(5*8, 2*8)]  = { n=n_neturalblock,   x=5*8,   y=2*8,   moving=false }
  ms[makekey(5*8, 3*8)]  = { n=n_neturalblock,   x=5*8,   y=3*8,   moving=false }
  ms[makekey(1*8, 5*8)]  = { n=n_neturalblock,   x=1*8,   y=5*8,   moving=false }
  ms[makekey(3*8, 5*8)]  = { n=n_neturalblock,   x=3*8,   y=5*8,   moving=false }
  ms[makekey(1*8, 7*8)]  = { n=n_neturalblock,   x=1*8,   y=7*8,   moving=false }
  ms[makekey(3*8, 7*8)]  = { n=n_neturalblock,   x=3*8,   y=7*8,   moving=false }
  ms[makekey(4*8, 11*8)] = { n=n_neturalblock,   x=4*8,   y=11*8,  moving=false }
  ms[makekey(2*8, 12*8)] = { n=n_neturalblock,   x=2*8,   y=12*8,  moving=false }
  ms[makekey(8*8, 14*8)] = { n=n_colorblock,     x=8*8,   y=14*8,  moving=false , color=red}
  ms[makekey(9*8, 13*8)] = { n=n_gate,           x=9*8,   y=13*8,  moving=false , color=red}
  ms[makekey(8*8, 5*8)]  = { n=n_neturalblock,   x=8*8,   y=5*8,   moving=false }
  ms[makekey(8*8, 6*8)]  = { n=n_neturalblock,   x=8*8,   y=6*8,   moving=false }
  ms[makekey(8*8, 7*8)]  = { n=n_neturalblock,   x=8*8,   y=7*8,   moving=false }
  ms[makekey(8*8, 8*8)]  = { n=n_neturalblock,   x=8*8,   y=8*8,   moving=false }
  ms[makekey(8*8, 9*8)]  = { n=n_neturalblock,   x=8*8,   y=9*8,   moving=false }
  ms[makekey(8*8, 10*8)] = { n=n_neturalblock,   x=8*8,   y=10*8,  moving=false }
  ms[makekey(8*8, 11*8)] = { n=n_neturalblock,   x=8*8,   y=11*8,  moving=false }
  ms[makekey(11*8, 6*8)] = { n=n_colorblock,     x=11*8,  y=6*8,   moving=false , color=green }
  ms[makekey(11*8, 7*8)] = { n=n_colorblock,     x=11*8,  y=7*8,   moving=false , color=blue}
  ms[makekey(11*8, 8*8)] = { n=n_colorblock,     x=11*8,  y=8*8,   moving=false , color=red}
  ms[makekey(14*8, 6*8)] = { n=n_neturalblock,   x=14*8,  y=6*8,   moving=false }
  ms[makekey(14*8, 7*8)] = { n=n_neturalblock,   x=14*8,  y=7*8,   moving=false }
  ms[makekey(10*8, 4*8)] = { n=n_gate,           x=10*8,  y=4*8,   moving=false , color=blue}
  ms[makekey(10*8, 3*8)] = { n=n_gate,           x=10*8,  y=3*8,   moving=false , color=green}
  ms[makekey(10*8, 2*8)] = { n=n_gate,           x=10*8,  y=2*8,   moving=false , color=red}
  ms[makekey(13*8, 4*8)] = { n=n_laser,          x=13*8,  y=4*8,   moving=false , color=red, d="u", active = true}
  ms[makekey(13*8, 1*8)] = { n=n_crystal,        x=13*8,  y=1*8,   moving=false , color=red}
  ms[makekey(13*8, 2*8)] = { n=n_neturalblock,   x=13*8,  y=2*8,   moving=false }
  ms[makekey(1*8, 14*8)] = { n=n_laser,          x=1*8,   y=14*8,   moving=false , color=red, d="u", active = true}
  plr = ms[makekey(startx, starty)]
end

function level2init()
    level="2"
    mapxoffset = mapxoffset + 16
    mapyoffset = 0
    ms = nil
    ms = {}
    plr = nil
    local startx = 0*8
    local starty = 7*8
    ms[makekey(startx, starty)] = { n=n_plr, x=startx, y=starty, moving=false }
    ms[makekey(3*8, starty)] = { n=n_neturalblock, x=3*8, y=starty, moving=false }
    ms[makekey(7*8, 7*8)] = { n=n_laser, x=7*8, y=7*8, moving=false, color=red, d="u", active = true}
    ms[makekey(7*8, 8*8)] = { n=n_laser, x=7*8, y=8*8, moving=false, color=green, d="d", active = true}
    ms[makekey(6*8, 7*8)] = { n=n_laser, x=6*8, y=7*8, moving=false, color=blue, d="l", active = true}
    ms[makekey(8*8, 7*8)] = { n=n_laser, x=8*8, y=7*8, moving=false, color=white, d="r", active = true}
    plr = ms[makekey(startx, starty)]
end
