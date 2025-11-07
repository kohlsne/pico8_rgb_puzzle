function tableinit()
  mirroroffset = {
    [makekey("u",n_fsmirror)] =   {dx = 1,  dy = -1, d = "r"},
    [makekey("u",n_bsmirror)] =   {dx = -1,  dy = -1, d = "l"},
    [makekey("ur",n_hmirror)] =   {dx = 3,  dy = 0, d = "dr"},
    [makekey("ur",n_vmirror)] =   {dx = 0,  dy = -3, d = "ul"},
    [makekey("r",n_fsmirror)] =   {dx = 1,  dy = -1, d = "u"},
    [makekey("r",n_bsmirror)] =   {dx = 1,  dy = 1, d = "d"},
    [makekey("dr",n_hmirror)] =   {dx = 3,  dy = 0, d = "ur"},
    [makekey("dr",n_vmirror)] =   {dx = 0,  dy = 3, d = "dl"},
    [makekey("d",n_fsmirror)] =   {dx = -1,  dy = 1, d = "l"},
    [makekey("d",n_bsmirror)] =   {dx = 1,  dy = 1, d = "r"},
    [makekey("dl",n_hmirror)] =   {dx = -3,  dy = 0, d = "ul"},
    [makekey("dl",n_vmirror)] =   {dx = 0,  dy = 3, d = "dr"},
    [makekey("l",n_fsmirror)] =   {dx = -1,  dy = 1, d = "d"},
    [makekey("l",n_bsmirror)] =   {dx = -1,  dy = -1, d = "u"},
    [makekey("ul",n_vmirror)] =   {dx = 0,  dy = -3, d = "ur"},
    [makekey("ul",n_hmirror)] =   {dx = -3,  dy = 0, d = "dl"},
  }
  directionchangetable = {
    ["u"]   =   {dx = 0,  dy = -1},
    ["ur"]  =  {dx = 1,  dy = -1},
    ["r"]   =   {dx = 1,  dy = 0},
    ["dr"]  =  {dx = 1,  dy = 1},
    ["d" ]  =   {dx = 0,  dy = 1},
    ["dl"]  =  {dx = -1, dy = 1},
    ["l"]   =   {dx = -1, dy = 0},
    ["ul"]  =  {dx = -1, dy = -1}
  }
  laseroffset = {
    ["u"]   =   {dx = 3,  dy = -1},
    ["ur"]  =  {dx = 8,  dy = -1},
    ["r"]   =   {dx = 8,  dy = 3},
    ["dr"]  =  {dx = 8,  dy = 8},
    ["d" ]  =   {dx = 3,  dy = 8},
    ["dl"]  =  {dx = -1, dy = 8},
    ["l"]   =   {dx = -1, dy = 3},
    ["ul"]  =  {dx = -1, dy = -1}
  }
end
