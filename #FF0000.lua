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

--Create icon atlas
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

--Dad Braggin' joker
SMODS.Joker {
	key = 'dadbraggin',
	loc_txt = {
		name = "Dad Braggin'",
		text = {
			"Each {C:attention}King{} gives {C:money}$#1#{} when scored",
			"{X:mult,C:white} X#2# {} Mult for each modifier it has"
		}
	},
	config = { extra = { money = 1, Xmult = 2 } },
	rarity = 3,
	atlas = "JokerAtlas",
	pos = { x = 1, y = 0 },
	cost = 8,

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