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
			"Copies ability of",
			"{C:attention}Joker{} to the left"
		}
	},
	rarity = 3,
	atlas = "JokerAtlas",
	pos = { x = 0, y = 0 },
	cost = 10,

	calculate = function(self, card, context)
        
        	local target_joker = nil
        
        	local my_pos = nil
        	for i = 1, #G.jokers.cards do
            		if G.jokers.cards[i] == card then
                		my_pos = i
                		break
            		end
        	end
        	target_joker = (my_pos and my_pos > 1) and G.jokers.cards[my_pos - 1] or nil
        
        	local ret = SMODS.blueprint_effect(card, target_joker, context)
        	if ret then
            		SMODS.calculate_effect(ret, card)
        	end
    	end
}