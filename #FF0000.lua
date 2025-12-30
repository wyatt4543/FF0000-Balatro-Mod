--[[
comments go here I guess
--]]

--Create the joker atlas
SMODS.Atlas {
	-- Key for code to find it with
	key = "JokerAtlas",
	-- The name of the file, for the code to pull the atlas from
	path = "JokerAtlas.png",
	-- Width of each sprite in 1x size
	px = 138,
	-- Height of each sprite in 1x size
	py = 186
}

--Yellowprint joker
SMODS.Joker {
	key = 'yellowprint',
	loc_txt = {
		name = 'Yellowprint',
		text = {
			"Copies ability of {C:attention}Joker{} to the left"
		}
	},
}