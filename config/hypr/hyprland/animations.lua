-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({animations = {
	enabled = true,

	workspace_wraparound = false,
}})

hl.curve("linear",    { type="bezier", points={{ 0,     0     }, { 1,     1    }} })
hl.curve("cube",      { type="bezier", points={{ 0.25,  0.46  }, { 0.45,  0.94 }} })
hl.curve("quint",     { type="bezier", points={{ 0.23,  1     }, { 0.32,  1    }} })
hl.curve("quint_s",   { type="bezier", points={{ 0.86,  0     }, { 0.07,  1    }} })
hl.curve("sine",      { type="bezier", points={{ 0.39,  0.575 }, { 0.565, 1    }} })
hl.curve("exp",       { type="bezier", points={{ 0.19,  1     }, { 0.22,  1    }} })
hl.curve("exp_s",     { type="bezier", points={{ 1,     0     }, { 0,     1    }} })
hl.curve("circ",      { type="bezier", points={{ 0.075, 0.82  }, { 0.165, 1    }} })
hl.curve("circ_s",    { type="bezier", points={{ 0.785, 0.135 }, { 0.15,  0.86 }} })
hl.curve("overshot",  { type="bezier", points={{ 0.05,  0.9   }, { 0.1,   1.05 }} })
hl.curve("overshot2", { type="bezier", points={{ 0.05,  0.9   }, { 0.1,   1.2  }} })
hl.curve("tangent1",  { type="bezier", points={{ 0,     1     }, { 0,     1    }} })
hl.curve("tangent2",  { type="bezier", points={{ 0,     1     }, { 0,     1    }} })
hl.curve("custom2",   { type="bezier", points={{ 0.14,  0.75  }, { 0,     1    }} })
hl.curve("custom3",   { type="bezier", points={{ 0.1,   -5    }, { 0,     1.1  }} })

hl.animation({enabled=true, leaf="windows",
	speed  = 1.5,
	bezier = "overshot",
	style  = "popin 40%",
})
hl.animation({enabled=true, leaf="layers",
	speed  = 2,
	bezier = "overshot2",
	style  = "fade",
})
hl.animation({enabled=true, leaf="border",
	speed  = 2,
	bezier = "default",
})
hl.animation({enabled=true, leaf="fade",
	speed  = 2,
	bezier = "default",
})
hl.animation({enabled=true, leaf="workspaces",
	speed  = 1.5,
	bezier = "custom2",
})
hl.animation({enabled=true, leaf="specialWorkspace",
	speed  = 1.5,
	bezier = "default",
	style  = "slidefadevert 20%",
})
