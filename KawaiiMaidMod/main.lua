-- Kawaii A&M Transport System(AMTS)

local MOD = {}

mods["KawaiiMaidMod"] = MOD

function MOD.on_day_passed()
	OnDay()
end

function MOD.on_new_player_created()
	Init()
end

-- ■毎日処理
function OnDay()
	if player:get_value("Kawaii_AMTS_Active") == "true" then
		Load_AMTS_Point()
		EditRP(0)
		msg("Energy accumulates in the ATMS device")
		if AMTS_Rank < 5 then
			EditCharges(DNr, 1)
			EditCharges(DNt, 2)
		elseif AMTS_Rank < 8 then
			EditCharges(DNr, 2)
			EditCharges(DNt, 3)
		elseif AMTS_Rank < 10 then
			EditCharges(DNr, 3)
			EditCharges(DNt, 4)
		else
			EditCharges(DNr, 3)
			EditCharges(DNt, 6)
		end
		cmsg("Points increased:+" .. getAP() .. "/Total points:" .. AMTS_Point, "cyan")
		EditPoint(getAP())
	elseif player:get_value("Kawaii_AMTS_Added") == nil then --■既存キャラ用導入処理
		Init()
	end
end

-- ■新規プレイヤー
function Init()
	msg("The air in front of me began to shimmer, and then a fancy-looking metal box appeared in front of me. What is is...?")
	player:i_add(item("kawaii_amts_box", 1))
	player:set_value("Kawaii_AMTS_Added", "true")
end

