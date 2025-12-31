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

--The Original Gambling joker
SMODS.Joker {
	key = 'og_gambling',
	loc_txt = {
		name = 'The Original Gambling',
		text = {
			"If played hand contains",
			"at least {C:attention}#1#{} scored {C:attention}7s{}",
			"give each {C:attention}7{}",
			"the {C:attention}Lucky{} enhancement"
		}
	},
	config = { extra = { num_cards = 3 } },
	rarity = 1,
	atlas = "JokerAtlas",
	pos = { x = 0, y = 0 },
	cost = 7,
	loc_vars = function(self, info_queue, card)
        	info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

		return { vars = { card.ability.extra.num_cards } }
    	end,
	calculate = function(self, card, context)
        	if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            		if (function()
                		local count = 0
                		for _, playing_card in pairs(context.scoring_hand or {}) do
                    			if playing_card:get_id() == 7 then
                        			count = count + 1
                    			end
                		end
                		return count >= card.ability.extra.num_cards
            		end)() then
                		return {
            				for _, playing_card in pairs(context.scoring_hand or {}) do
                				if playing_card:get_id() == 7 then
                    					playing_card:set_ability('m_lucky', nil, true)
                    					G.E_MANAGER:add_event(Event({
                        					func = function()
                            					playing_card:juice_up()
                            					return true
                        				end
                    					}))
                				end
            				end
            				message = localize('k_lucky'),
                    			colour = G.C.MONEY
                		}
            		end
        	end
    	end

}

--Dad Braggin' joker
SMODS.Joker {
	key = 'dad_braggin',
	loc_txt = {
		name = "Dad Braggin'",
		text = {
			"Each {C:attention}King{} gives {C:money}$#1#{} when scored",
			"{X:money,C:white} X#2# {} {C:money}${} for each modifier it has"
		}
	},
	config = { extra = { money = 1, Xmult = 2 } },
	rarity = 3,
	atlas = "JokerAtlas",
	pos = { x = 1, y = 0 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
        	if context.individual and context.cardarea == G.play  then
            		if context.other_card:get_id() == 13 then
                		return {
                    
                    			func = function()
                        
                        			local current_dollars = G.GAME.dollars
                        			local target_dollars = G.GAME.dollars + card.ability.extra.money
                        			local dollar_value = target_dollars - current_dollars
                        			ease_dollars(dollar_value)
                        			card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1), colour = G.C.MONEY})
                        			return true
                    			end,
                    			extra = {
                        			Xmult = card.ability.extra.Xmult
                    			}
                		}
            		end
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