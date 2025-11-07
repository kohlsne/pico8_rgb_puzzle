function menuinit()
  level=0
  mapxoffset = 0
  mapyoffset = 0
  local startx = 2*8
  local starty = 13*8
  ms = nil
  ms = {}
  ms[makekey(startx, starty)] = { n=n_plr, x=startx, y=starty, moving=false, d=nil }
  ms[makekey(1*8, 8*7)] = { n=n_ulaser, x=1*8, y=7*8, moving=false, color=red, d="u", active = true}
  ms[makekey(1*8, 1*8)] = { n=n_fsmirror, x=1*8, y=1*8, moving=false }
  ms[makekey(4*8, 1*8)] = { n=n_bsmirror, x=4*8, y=1*8, moving=false }
  ms[makekey(4*8, 4*8)] = { n=n_fsmirror, x=4*8, y=4*8, moving=false }
  ms[makekey(4*8, 8*7)] = { n=n_urlaser, x=4*8, y=7*8, moving=false, color=red, d="ul", active = true}

  ms[makekey(8*8, 8*1)] = { n=n_rlaser, x=8*8, y=1*8, moving=false, color=green, d="l", active = true}
  ms[makekey(5*8, 1*8)] = { n=n_fsmirror, x=5*8, y=1*8, moving=false }
  ms[makekey(5*8, 7*8)] = { n=n_bsmirror, x=5*8, y=7*8, moving=false }
  ms[makekey(8*8, 7*8)] = { n=n_fsmirror, x=8*8, y=7*8, moving=false }
  ms[makekey(8*8, 4*8)] = { n=n_bsmirror, x=8*8, y=4*8, moving=false }
  ms[makekey(6*8, 4*8)]  = { n=n_colorblock,   x=6*8,   y=4*8,   moving=false, color=green }

  ms[makekey(9*8, 7*8)] = { n=n_bsmirror, x=9*8, y=7*8, moving=false }
  ms[makekey(10*8, 4*8)]  = { n=n_colorblock,   x=10*8,   y=4*8,   moving=false, color=blue }
  ms[makekey(11*8, 7*8)] = { n=n_urlaser, x=11*8, y=7*8, moving=false, color=blue, d="ur", active = true}
  ms[makekey(11*8, 1*8)] = { n=n_urlaser, x=11*8, y=1*8, moving=false, color=blue, d="dr", active = true}
  ms[makekey(10*8, 1*8)] = { n=n_rlaser, x=10*8, y=1*8, moving=false, color=blue, d="l", active = true}
  ms[makekey(9*8, 1*8)] = { n=n_fsmirror, x=9*8, y=1*8, moving=false }
  ms[makekey(12*8, 2*8)] = { n=n_vmirror, x=12*8, y=2*8, moving=false }
  ms[makekey(12*8, 6*8)] = { n=n_vmirror, x=12*8, y=6*8, moving=false }

  ms[makekey(5*8, 12*8)] = { n=n_ulaser, x=5*8, y=12*8, moving=false, color=white, d="d", active = true}
  ms[makekey(8*8, 12*8)] = { n=n_crystal,x=8*8, y=12*8, moving=false , color=white}
  --ms[makekey(9*8, 14*8)] = { n=n_hgate,           x=9*8,   y=14*8,  moving=false , color=white}

  plr = ms[makekey(startx, starty)]
end

function level1init()
  level=1
  mapxoffset = 16
  mapyoffset = 0
  local startx = 0*8
  local starty = 1*8
  ms = nil
  ms = {}
  ms[makekey(startx, starty)] = { n=n_plr, x=startx, y=starty, moving=false, d=nil }
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
  ms[makekey(9*8, 13*8)] = { n=n_vgate,           x=9*8,   y=13*8,  moving=false , color=red}
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
  ms[makekey(10*8, 4*8)] = { n=n_vgate,           x=10*8,  y=4*8,   moving=false , color=blue}
  ms[makekey(10*8, 3*8)] = { n=n_vgate,           x=10*8,  y=3*8,   moving=false , color=green}
  ms[makekey(10*8, 2*8)] = { n=n_vgate,           x=10*8,  y=2*8,   moving=false , color=red}
  ms[makekey(13*8, 4*8)] = { n=n_ulaser,          x=13*8,  y=4*8,   moving=false , color=red, d="u", active = true}
  ms[makekey(13*8, 1*8)] = { n=n_crystal,        x=13*8,  y=1*8,   moving=false , color=red}
  ms[makekey(13*8, 2*8)] = { n=n_neturalblock,   x=13*8,  y=2*8,   moving=false }
  plr = ms[makekey(startx, starty)]
end

function level2init()
  level=2
  mapxoffset = 32
  mapyoffset = 0
  ms = nil
  ms = {}
  plr = nil
  local startx = 0*8
  local starty = 7*8
  ms[makekey(startx, starty)] = { n=n_plr, x=startx, y=starty, moving=false, d = nil }
  ms[makekey(4*8, starty)] = { n=n_fsmirror, x=4*8, y=starty, moving=false }
  ms[makekey(5*8, starty)] = { n=n_bsmirror, x=5*8, y=starty, moving=false }
  ms[makekey(9*8, 3*8)] = { n=n_vmirror, x=9*8, y=3*8, moving=false }
  ms[makekey(3*8, 3*8)] = { n=n_hmirror, x=3*8, y=3*8, moving=false }
  ms[makekey(7*8, 6*8)] = { n=n_ulaser, x=7*8, y=6*8, moving=false, color=red, d="u", active = true}
  ms[makekey(8*8, 6*8)] = { n=n_urlaser, x=8*8, y=6*8, moving=false, color=red, d="ur", active = true}
  ms[makekey(8*8, 7*8)] = { n=n_rlaser, x=8*8, y=7*8, moving=false, color=green, d="r", active = true}
  ms[makekey(8*8, 8*8)] = { n=n_urlaser, x=8*8, y=8*8, moving=false, color=green, d="dr", active = true}
  ms[makekey(7*8, 8*8)] = { n=n_ulaser, x=7*8, y=8*8, moving=false, color=blue, d="d", active = true}
  ms[makekey(6*8, 8*8)] = { n=n_urlaser, x=6*8, y=8*8, moving=false, color=blue, d="dl", active = true}
  ms[makekey(6*8, 7*8)] = { n=n_rlaser, x=6*8, y=7*8, moving=false, color=white, d="l", active = true}
  ms[makekey(6*8, 6*8)] = { n=n_urlaser, x=6*8, y=6*8, moving=false, color=white, d="ul", active = true}
  --ms[makekey(5*8, 7*8)] = { n=n_45mirror, x=5*8, y=7*8, moving=false, d="ul"}
  plr = ms[makekey(startx, starty)]
end
