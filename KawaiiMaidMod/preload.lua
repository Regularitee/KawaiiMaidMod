-- Kawaii A&M Transport System(AMTS)

-- ■納品アイテムid,ポイント
local pac_list = {
	"diamond", 1000,
	"kawaii_amts_pac_t1_01", 250,
	"kawaii_amts_pac_t1_02", 250,
	"kawaii_amts_pac_t1_03", 250,
	"kawaii_amts_pac_t2_01", 500,
	"kawaii_amts_pac_t2_02", 500,
	"kawaii_amts_pac_t2_03", 500
}
local pac_name = {}
local pac_point = {}
for i=1, #pac_list/2 do
	pac_name[i] = pac_list[(i*2)-1]
	pac_point[i] = pac_list[i*2]
end

-- ■一般アイテムid,cost,rank --要チェック:ライター・ダクトテープ・電池・手榴弾類。R3まで使い道が無くて溜まる一方なので何か入れたい
local reward_list = {
	"bottle_plastic_small", 50, 1,
	"bottle_plastic", 100, 1,
	"jug_plastic", 200, 2,
	"jar_glass", 150, 2,
	"bottle_glass", 250, 2,
	"jar_3l_glass", 500, 2,
	"kawaii_bottle_2l", 200, 2,
	"kawaii_jerrycan_10l", 500, 2,
	"kawaii_jerrycan_20l", 700, 2,
	"lighter", 100, 2,
	"emer_blanket", 300, 2,
	"picklocks", 700, 2,
	"duct_tape", 1000, 3,
	"small_storage_battery", 500, 3,
	"battery", 500, 3,
	"toolbox", 1000, 3,
	"welder", 2000, 3,
	"soldering_iron", 750, 3,
	"solder_wire", 200, 3,
	"30gal_drum", 1000, 4,
	"smokebomb", 500, 4,
	"flashbang", 500, 4,
	"EMPbomb", 2000, 4,
	"generator_7500w", 2000, 4,
	"battery_ups", 1000, 4,
	"e_tool", 500, 5,
	"kawaii_portable_kitchen", 3000, 5,
	"medium_storage_battery", 1000, 5,
	"atomic_light", 1000, 5,
	"atomic_lamp", 2000, 5,
	"1st_aid", 2000, 6,
	"bio_tools", 3000, 6,
	"bio_power_storage_mkII", 2000, 7,
	"kawaii_UPS", 5000, 7,
	"storage_battery", 2000, 8,
	"solar_panel_v3", 5000, 9,
	"plut_cell", 2000, 10
}

-- ■素材系アイテム表示名,id,cost,rank --序盤はポイントが重すぎてなんらかの逼迫した状況専用そう。R5あたりからAPとチャージ量と係数分で現実的に…と思ったらRank5からポイント需要が…
local material_list = {
	"plastic bags", "bag_plastic", 100, 2,
	"wood planks", "2x4", 500, 2,
	"plastic piece", "plastic_chunk", 500, 2,
	"leather", "leather", 500, 2, 
	"cloth rags", "rag", 500, 2,
	"thread", "thread", 500, 2,
	"scrap metal", "scrap", 500, 2,
	"kevlar plates", "kevlar_plate", 1000, 4,
	"nomex", "nomex", 1000, 4
}

-- ■装備系アイテムid,cost,rank --消耗品系の用途が欲しい
local equip_list = {
	"kawaii_arrow_ribbon", 200, 2,
	"kawaii_crowbar_lance", 2000, 3,
	"kawaii_glass_bow", 3000, 3,
	"kawaii_spear_steel", 1500, 3,
	"kawaii_rita_and_rosa", 3500, 4,
	"kawaii_maid_hat_thermal_off", 1000, 5,
	"kawaii_maid_dress_ex", 1800, 5,
	"kawaii_secretpoach", 750, 5,
	"kawaii_arrow_feather",500, 5,
	"kawaii_leila", 6000, 6,
	"kawaii_shelia_off", 6000, 6,
	"kawaii_crystal_td", 4000, 7,
	"kawaii_maid_hat_lss", 1500, 7,
	"kawaii_maid_dress_lss", 3000, 7,
	"kawaii_boots_hi", 1500, 7,
	"kawaii_shoes_hi", 1500, 7,
	"kawaii_death_scythe", 8500, 8,
	"kawaii_arrow_little_mary", 2000, 9
}

-- ■液体表示名,内容量(L),id,コスト,ランク
local liquid_list = {
	"水", 2, "water", 250, 3, --R3は10日目。早ければ車両を触り始める頃？
	"綺麗な水", 0.5, "water_clean", 200, 3,
	"ランプオイル", 0.5, "lamp_oil", 500, 3,
	"ガソリン", 0.5, "gasoline", 500, 3,
	"綺麗な水", 2, "water_clean", 500, 4,
	"ランプオイル", 2, "lamp_oil", 1000, 4,
	"ガソリン", 2, "gasoline", 1000, 4,
	"水", 10, "water", 1000, 5, --R5は1年目秋終わり頃。基本的な物が揃う頃？ここからチャージ量とか変わるから1日あたり1.5RP
	"ガソリン", 10, "gasoline", 1500, 5,
	"軽油", 10, "diesel", 1500, 5,
	"水", 20, "water", 1500, 7, --R7は2年目夏初め？
	"ガソリン", 20, "gasoline", 3000, 7,
	"軽油", 20, "diesel", 3000, 7
}

local l_name = {}
local l_amount = {}
local l_id = {}
local l_cost = {}
local l_rank = {}
for i=1, #liquid_list/5 do
	l_name[i] = liquid_list[(i*5)-4]
	l_amount[i] = liquid_list[(i*5)-3]
	l_id[i] = liquid_list[(i*5)-2]
	l_cost[i] = liquid_list[(i*5)-1]
	l_rank[i] = liquid_list[i*5]
end

-- ■あちこちで参照しそうなやつ
AMTS_Point = 0
AMTS_RP = 0
AMTS_Rank = 1
AMTS_NextRP = 0
reqRP = { 3, 7, 12, 15, 20, 25, 30, 50, 60, 9999 } --デフォルトで1季14日、年56日 R1-4[1/D]R5-[1.5/D]R8-[2/D] R3=10 R5=37(27) R7=82(34) R8=112(23) R9=163(26) R10=223(30)
ap = { 0, 100, 200, 300, 500, 1000 }

-- ■打つのがめんどくさい
DNr = "kawaii_amts_reciver"
DNt = "kawaii_amts_transmitter"

-- ■未解放時のメニュー表記
local equipStr = "<color_dark_gray>[[Locked]]: Requires Rank2</color>"
local materialStr = "<color_dark_gray>[[Locked]]: Requires Rank2</color>"
local liquidStr = "<color_dark_gray>[[Locked]]: Requires Rank3</color>"
local armsStr = "<color_dark_gray>[[Locked]]: Requires Rank5</color>"


-- ■転送要請(アイテム入手)アイテムの処理
function amts_reciver(item2, active)
	Load_AMTS_Point()
	EditRP(0)

	if AMTS_Rank > 1 then
		equipStr = "Buy a product"
		materialStr = "Sell resources"
	end
	if AMTS_Rank > 2 then
		liquidStr = "Liquid Transfer"
	end
	if AMTS_Rank > 4 then
		armsStr = "AM-ARMS Controller"
	end
	
	local c = CreateMenu("AMTS Product Catalogue (Points:" .. AMTS_Point .. "/Rank:" .. AMTS_Rank .. "/Next:" .. AMTS_NextRP ..")" , armsStr, "Make a purchase", materialStr, liquidStr, equipStr, "Cancel")
		if c == 0 then --■AM-ARMSコントロール
			if AMTS_Rank < 5 then
				cmsg("This requires at least store rank 5", "red")
				return
			end
			ARMSMenu("AM-ARMS controller (Points::" .. AMTS_Point .. "/Rank:" .. AMTS_Rank .. "/Next:" .. AMTS_NextRP .. ")")
			
		elseif c == 1 then --■物資転送
			p3menu(reward_list,item2)
		
		elseif c == 2 then --■素材転送
			p3menu(material_list,item2)
			
		elseif c == 3 then --■液体転送
			if AMTS_Rank < 3 then
				cmsg("This requires at least store rank 3", "red")
				return
			end
			local no = LiquidMenu("What liquid do you wish transfered？(Points::" .. AMTS_Point .. "/Rank:" .. AMTS_Rank .. "/Next:" .. AMTS_NextRP ..")")
			if no == #l_name then
				msg("Transaciton cancelled")
				return
			end
			
			no = no + 1
			local bottle = ""
			if l_amount[no] == 0.5 then
				bottle = "bottle_plastic"
			elseif l_amount[no] == 2 then
				bottle = "kawaii_bottle_2l"
			elseif l_amount[no] == 10 then
				bottle = "kawaii_jerrycan_10l"
			end

			local liquid = item(l_id[no],1)
			local item = StackLiquid(bottle,l_id[no],l_amount[no]/0.25)
			ReceiveItem(item,l_cost[no],l_rank[no],item2.charges)
			
		elseif c == 4 then --■装備転送
			if AMTS_Rank < 2 then
				cmsg("This requires at least store rank 2", "red")
				return
			end
			p3menu(equip_list,item2)
			
		elseif c == 5 then

		else
			cmsg("[kawaii error!!]選択肢IDが範囲外です(R1)", "red")
		end
		
end

-- ■debug
function debugAdd()
	EditCharges(DNr, 1)
	EditCharges(DNt, 1)
	EditRP(5)
	EditPoint(500)
	msg("AP",getAP())
end

-- ■3要素配列用転送メニュー(手抜き用)
function p3menu(list,item2)
	local title = "What do you wish sent? (Points:" .. AMTS_Point .. "/Rank:" .. AMTS_Rank .. "/Next:" .. AMTS_NextRP .. ")"
	local name, rank, cost = RewardListMenu(title,list)
	if name ~= nil then
		ReceiveItem(item(name,1),cost,rank,item2.charges)
	else
		msg("キャンセルしました")
	end
end
	
-- ■納品(ポイント入手)アイテムの処理
function amts_transmitter(item2, active)
	Load_AMTS_Point()
	EditRP(0)
	
	local c = CreateMenu("AMTS-Delivery (Points owned:" .. AMTS_Point .. "/Rank:" .. AMTS_Rank .. "/Next:" .. AMTS_NextRP ..")" , "Send","Exchange list", "Request AMTS matter compressor", "Cancel")
	if c == 0 then
		local no = ItemListMenu("What do you wish to exchange for points?")
		if no == nil or no == "cancel" then
			msg("Transaction cancelled.")
			return
		end
		
		SendItem(GetInvItem(pac_name[no]),pac_point[no],item2.charges)
	elseif c == 1 then
		msg("Check the purchase list")
		viewNouhin()
	elseif c == 2 then
		if item2.charges == 0 then
			cmsg("Insufficient charges remaining", "light_red")
			return
		end
		
		player:i_add(item("kawaii_amts_pacsys",1))
		cmsg("Received an AMTS packaging system", "cyan")
		EditCharges(DNt, -1)
	elseif c == 3 then
	
	else
		cmsg("Choice ID out of range!", "red")
	end
end

-- ■AMTSインストールキット(外箱のメモを読む)
function amts_kit(item, active)
	game.popup(gText("boxmemo"))
	cmsg("You opened the fancy box", "light_green")
	player:i_add(item("kawaii_amts_box2",1))
	player:i_add(item("kawaii_amts_manual",1))
	player:i_rem(item)
end

-- ■AMTSインストールキット(施術)
function amts_kit2(item, active)
	cmsg("AMTS device implanted.", "light_green")
	player:set_value("Kawaii_AMTS_Active", "true")
	player:i_add(item("kawaii_amts_reciver", 1))
	player:i_add(item("kawaii_amts_transmitter", 1))
	player:i_add(item("kawaii_amts_point_viewer", 1))
	EditRP(0)
	EditPoint(0)
	player:i_rem(item)
end

-- ■AMTSマニュアルアイテムの処理
function amts_manual(item, active)
	game.popup(gText("manual_1"))
	game.popup(gText("manual_2"))
	game.popup(gText("manual_3"))
end

-- ■アイテム受取
function ReceiveItem(item,cost,rank,charges)
	if charges == 0 then
		cmsg("Insufficient power remaining", "light_red")
		return
	elseif rank > AMTS_Rank then
		cmsg("Insufficient store rank", "light_red")
		return
	elseif cost > AMTS_Point then
		cmsg("Insufficient points available", "light_red")
		return
	end
	
	if item:ammo_type():str() == "battery" then
		local citem = item("battery",1)
		citem.charges = item:ammo_capacity()
		item:fill_with(citem)
	end
	
	if item:typeId() == "battery" then
		local citem = item("battery",1)
		citem.charges = AMTS_Rank * 100
		item = citem
	end
	
	if item:typeId() == "lighter" then
		item.charges = 100
	end
	
	local dname = item:display_name()
	local flag = 0
	local n = material_list
	local items = {}
	for i,v in pairs(n) do
		if item:typeId() == v then
			for i=1, AMTS_Rank*2 do
				player:i_add(item)
			end
			dname = item:display_name() .. " x" .. AMTS_Rank*2 .. "(Rank)"
			flag = 1
		end
	end

	if flag == 0 then
		player:i_add(item)
	end
	EditPoint(-(cost))
	EditCharges(DNr,-1)
	msg("<color_pink>[-" .. cost .. "Point]</color>" .. dname .. " has been successfully transfered. (Points:" .. AMTS_Point .. ")")
end

-- ■アイテム納品
function SendItem(item,point,charges)
	if charges == 0 then
		cmsg("Insufficient charges remaining", "light_red")
		return
	end
	EditPoint(point)
	EditCharges(DNt, -1)
	player:i_rem(item)
	msg("<color_pink>[+" .. point .. "Point]</color>" .. item:display_name() .. " has been sent in exchange for points. (Points:" .. AMTS_Point .. ")")
	EditRP(1)
end

-- ■納品アイテム確認用リストを表示
function viewNouhin()
	local text = "         <<  Delivery Item List  >>     \n"
	for i in pairs(pac_name) do
		text = text .. "<color_pink>[" .. pac_point[i] .. "Point]</color> " .. item(pac_name[i],1):display_name() .. "\n"
	end
	game.popup(text)
end

-- ■自動獲得ポイントを返す
function getAP()
	return ap[math.floor(AMTS_Rank/2)+1]
end

-- ■地形idを返す
function getFloorID(point)
	local terrain_int_id = map:ter(point):to_i()
	local terrain = game.get_terrain_type(terrain_int_id)
	local terrain_str_id = terrain.id:str()
	return terrain_str_id
end

-- ■ランクポイントの増減と関連処理(初期化ロードは0で)
function EditRP(point)
	AMTS_RP = tonumber(player:get_value("Kawaii_AMTS_RP"))
	
	if AMTS_RP == nil then
		AMTS_RP = 0
	end
	
	if AMTS_Rank == 10 then
		ATMS_Rank = 10
		AMTS_NextRP = 9999
		return
	end
	
	AMTS_RP = AMTS_RP + point
	
	local oldRank = AMTS_Rank
	local rp2 = AMTS_RP
	local i = 1
	local d = reqRP[1]
	while AMTS_Rank < 10 and rp2 > 0 do
		if rp2 > reqRP[i] - 1 then
			rp2 = rp2 - reqRP[i]
		else
			break
		end
		i = i + 1
	end
	
	AMTS_Rank = i
	AMTS_NextRP = reqRP[i] - rp2
	
	if point > 0 and AMTS_Rank > oldRank then
		cmsg("Your AMTS rank has increased!(Rank" .. i .. ")", "light_green")
		local apt = "Bonus points earned" .. ap[math.ceil(i/2)] .. "->" .. ap[math.ceil(i/2)+1]
		local bonus = "You have received a free bonus item as a reward"
		--参考用:ap = { 0, 100, 200, 300, 500, 1000 }
		
		if i == 2 then
			bonus = bonus .. apt
			GiveItem("canteen")
			GiveItem("kawaii_raincoat")
		elseif i == 3 then
			bonus = bonus
			GiveItem("kawaii_crowbar_lance")
		elseif i == 4 then
			bonus = bonus .. apt
		elseif i == 5 then
			bonus = bonus
			local ammo = item("kawaii_308AM",1)
			ammo.charges = 20
			local mag = item("kawaii_eve_mag",1)
			mag:put_in(ammo)
			local item = item("kawaii_amts_eve",1)
			item:put_in(mag)
			player:i_add(item)
			msg("<color_light_green>Rank up bonus:</color>" .. item:display_name())
			GiveItem("kawaii_eve_mag")
			GiveItem("kawaii_scarf")
		elseif i == 6 then
			bonus = bonus .. apt
		elseif i == 7 then
			bonus = bonus
			GiveItem("kawaii_hitec_megane")
		elseif i == 8 then
			bonus = bonus .. apt
		elseif i == 9 then
			bonus = bonus
		elseif i == 10 then
			bonus = bonus .. apt
		end
		
		msg(bonus)
	end

	function GiveItem(itemstr)
		local item = item(itemstr,1)
		player:i_add(item)
		msg("<color_light_green>Rank up bonus:</color>" .. item:display_name())
	end

	player:set_value("Kawaii_AMTS_RP", tostring(AMTS_RP))
end

-- ■メニューテキスト用のランクとポイントを確認・表示・色分けして1行分返す
function MergeMenuText(name,rank,point,grayoutmode)
	local rankstr, coststr, name2
	local c = true

	if rank > AMTS_Rank then
		rankstr = "<color_dark_gray>[Rank" .. rank .. "]</color>" 
		c = false
	else
		rankstr = "<color_pink>[Rank" .. rank .. "]</color>" 
	end

	if point > AMTS_Point then
		coststr = "<color_dark_gray>[" .. point .. "Point]</color>"
		c = false
	else
		coststr = "<color_light_green>[" .. point .. "Point]</color>"
	end

	if grayoutmode == "false" then
		c = true --■一部の装備が強制的にgrayになるのではずしたい時がある
	end
	
	if c then
		name2 = rankstr .. coststr .. name
	else
		name2 = rankstr .. coststr .. "<color_dark_gray>" .. name .. "</color>"
	end
	
	return name2
end

-- ■ARMSメニュー
function ARMSMenu(title)
	local menu = game.create_uimenu()
	local choice = -1
	menu.title = title
	local n = {
	"EVE magazine loading", 500, 5
	}

	local name = {}
	local cost = {}
	local rank = {}
	for i=1, #n/3 do
		name[i] = n[(i*3)-2]
		cost[i] = n[(i*3)-1]
		rank[i] = n[i*3]
	end

	for i in pairs(name) do
		local name2 = MergeMenuText(name[i], rank[i], cost[i], "false")
		menu:addentry(name2)
	end

	menu:addentry("Cancel")
	menu:query(true)
	local no = menu.selected

	if no < #name then
		if no == 0 then
			msg("The Eve magazine was loaded via AMTS")
			local itemstr = "kawaii_eve_mag"
			local ammo = item("kawaii_308AM",1)
			local item = GetInvItem(itemstr)
			ammo.charges = item:ammo_capacity() - item:ammo_remaining()
			item:put_in(ammo)
			EditPoint(-(cost[no+1]))
			EditCharges(DNr,-1)
		end
		return
	else
		return
	end
end

-- ■液体がスタックできないのでforで回してitemで返す。液体が入ってる分他より気をつけて扱おう(うまい)
function StackLiquid(bottle,liquid,count)
	local item2 = item(bottle,1)
	for i=1,count do
		item2:fill_with(item(liquid,1))
	end
	return item2
end

-- ■液体メニューリスト
function LiquidMenu(title)
	local menu = game.create_uimenu()
	local choice = -1
	menu.title = title
	local n = l_name

	for i in pairs(n) do
		local rankstr,coststr,name
		local c = true
		if l_rank[i] > AMTS_Rank then
			rankstr = "<color_dark_gray>[Rank" .. l_rank[i] .. "]</color>" 
			c = false
		else
			rankstr = "<color_pink>[Rank" .. l_rank[i] .. "]</color>" 
		end
		if l_cost[i] > AMTS_Point then
			coststr = "<color_dark_gray>[" .. l_cost[i] .. "Point]</color>"
			c = false
		else
			coststr = "<color_light_green>[" .. l_cost[i] .. "Point]</color>"
		end

		if c then
			name = rankstr .. coststr .. l_name[i] .. "(" .. l_amount[i] .. "L)"
		else
			name = rankstr .. coststr .. "<color_dark_gray>" .. l_name[i] .. "(" .. l_amount[i] .. "L)" .. "</color>"
		end
		
		menu:addentry(name)
	end
	
	menu:addentry("Cancel")
	menu:query(true)
	choice = menu.selected
	return choice
end

-- ■リワードリストを作る
function RewardListMenu(title,itemlist)
	local menu = game.create_uimenu()
	local choice = -1
	menu.title = title
	
	local dname = {}
	local name = {}
	local cost = {}
	local rank = {}
	if itemlist == material_list then
		local x = 4
		for i=1, #itemlist/x do
			dname[i] = itemlist[(i*x)-3]
			name[i] = itemlist[(i*x)-2]
			cost[i] = itemlist[(i*x)-1]
			rank[i] = itemlist[i*x]
		end
	else
		local x = 3
		for i=1, #itemlist/x do
			name[i] = itemlist[(i*x)-2]
			cost[i] = itemlist[(i*x)-1]
			rank[i] = itemlist[i*x]
		end
	end
	
	local n = name
	for i in pairs(n) do
		local item = item(name[i],1)
		
		if item:ammo_type():str() == "battery" then
			local citem = item("battery",1)
			citem.charges = item:ammo_capacity()
			item:fill_with(citem)
		end
		
		if item:typeId() == "battery" then
			local citem = item("battery",1)
			citem.charges = AMTS_Rank * 100
			item = citem
		end
		
		if item:typeId() == "lighter" then
			item.charges = 100
		end
		
		local name2
		if itemlist == material_list then
			name2 = MergeMenuText(item:display_name() .. " x" .. AMTS_Rank*2 , rank[i], cost[i], "false")
		else
			name2 = MergeMenuText(item:display_name(), rank[i], cost[i], "false")
		end

		menu:addentry(name2)
	end
	
	menu:addentry("Cancel")
	menu:query(true)
	local no = menu.selected
	
	if no < #name then
		no = no+1
		return name[no], rank[no], cost[no]
	else
		return nil, nil, nil
	end
end

-- ■所持アイテムからリストを検索して納品リストを作る(持ってるものだけ表示)
function ItemListMenu(title)
	local menu = game.create_uimenu()
	local choice = -1
	menu.title = title
	local n = pac_name
	local has_list = {}
	local no = 0
	local count = 0
	
	for i in pairs(n) do
		if not GetInvItem(n[i]):is_null() then
			has_list[no] =  GetInvItem(n[i])
			menu:addentry("<color_light_green>[" .. pac_point[i] .. "Point]</color>" .. has_list[no]:display_name())
			has_list[no] = i
			no = no + 1
			count = count + 1
		end
	end
	if count == 0 then
		cmsg("No item has been received.", "red")
		return
	end
	
	menu:addentry("Quit")
	menu:query(true)
	choice = menu.selected
	if #has_list < choice then
		return "cancel"
	end
	return has_list[choice]
end

-- ■ポイントの増減
function EditPoint(point)
	local item = GetInvItem("kawaii_amts_point_viewer")
	Load_AMTS_Point()
	AMTS_Point = AMTS_Point + point
	
	if AMTS_Point == item:ammo_capacity() or AMTS_Point > item:ammo_capacity() then
		AMTS_Point = item:ammo_capacity()
		msg("AMTS point limit reached.")
	end
	
	AMTS_Point = math.ceil(AMTS_Point)
	item.charges = AMTS_Point
	player:set_value("Kawaii_AMTS_Point", tostring(AMTS_Point))
end

-- ■ポイントをキャラデータからロード
function Load_AMTS_Point()
	AMTS_Point = tonumber(player:get_value("Kawaii_AMTS_Point"))
	if AMTS_Point == nil then
		AMTS_Point = 0
	end
end

-- ■デバイスのチャージを増減する。ついでに増減後のチャージ量を返すけど別に受けなくてもよい
function EditCharges(name, point)
	local item = GetInvItem(name)
	if point > 0 then
		if math.floor(item.charges) < item:ammo_capacity() then
			msg(item:display_name() .. " Points increased by +" .. point .. " =")
			item.charges = item.charges + point
			if item.charges > item:ammo_capacity() then
				item.charges = item:ammo_capacity()
				msg(item:display_name() .. " The points are at maximum capacity.")
			end
			msg(item:display_name())
		else
			msg(item:display_name() .. " The points are at maximum capacity.")
		end
	end
	if point < 0 then
		if math.floor(item.charges)  > 0 then
			item.charges = item.charges + point
		else
			msg(item:display_name() .. " There are insufficient points available.")
		end
	end
	
	return item.charges
end

-- ■足下のアイテムを検索する
function getItemFloor(itemid)
	local stack = map:i_at(player:pos())
	local iter = stack:cppbegin()
	while iter ~= stack:cppend() do
		local tmp = iter:elem()
			if tmp:typeId() == itemid then
				return tmp
			end
		iter:inc()
	end
	return nil
end

-- ■インベントリ内のアイテムをid検索してitem型で返す
function GetInvItem(itemid)
	local i = 0
	local item = player:i_at(i)
	while not item:is_null() do
		if tostring(item:typeId()) == itemid then
			item = player:i_at(i)
			break
		end
		i = i + 1
		item = player:i_at(i)
	end
	return item
end

-- ■メニューつくる
function CreateMenu(title,...)
	local n = {...}
	local menu = game.create_uimenu()
	local choice = -1
	menu.title = title
	
	for i in pairs(n) do
		menu:addentry(n[i])
	end
	
	menu:query(true)
	choice = menu.selected
	return choice
end

-- ■TriPointを表示する(debug)
function PosMSG(name, point)
	msg(name, math.ceil(point.x), math.ceil(point.y), math.ceil(point.z))
end

-- ■テキストを書きやすく
function _(text)
    return tostring(text):gsub("^\t+", ""):gsub("\n\t+$", ""):gsub("(\n)\t+", "%1")
end

-- ■カラーテスト
function test_cmsg()
	cmsg("カラーテスト", "red")
	cmsg("カラーテスト", "green")
	cmsg("カラーテスト", "blue")
	cmsg("カラーテスト", "cyan")
	cmsg("カラーテスト", "magenta")
	cmsg("カラーテスト", "brown")
	cmsg("カラーテスト", "light_red")
	cmsg("カラーテスト", "light_green")
	cmsg("カラーテスト", "light_blue")
	cmsg("カラーテスト", "pink")
	cmsg("カラーテスト", "yellow")
	cmsg("カラーテスト", "light_red_red")
	cmsg("カラーテスト", "light_green_red")
end

-- ■カラーメッセージ
function cmsg(msg,color)
	local str = "<color_" .. color .. ">" .. msg .. "</color>" .. " "
	game.add_msg(tostring(str))
end

-- ■可変引数メッセージ(引数2つ以上は基本debug用に)
function msg(msg,...)
	local n = {...}
	local str = msg
	for i in pairs(n) do
		str = str .. " : " .. n[i]
	end
	game.add_msg(tostring(str))
end

-- ■配列がsetできないのでforでぐるぐる
function ArraySave(namelist)
	for i = 1, #name_list do
		player:set_value("Kawaii_name" .. i, namelist[i])
	end
end

-- ■配列がgetできないので
function ArrayLoad()
	for i = 1, #name_list do
		name_list[i-1] = player:get_value("Kawaii_name" .. i)
	end
end

-- ■テキスト置き場
function gText(name)
	local text = "missing strings"
	--本文22行が限界っぽい
	if name == "boxmemo" then
		text = _[[
		                   <color_cyan>This note was pasted on the box.</color>
		  You have been accepted into the A&M Transport System beta test.
		  Thank you for your interest in supporting our company.
		  
		  In this case is everything needed to use our product.
		  
		  In order to use this device, please apply the pre-packaged implant.
		  After that, please read the manual carefully.
		  
		  We hope you enjoy using the A&M Transport System
		  
		  <color_light_blue>A&M Transport System</color>
		  <color_light_blue>Beta Test Support Desk:</color>support@AM@AMTS
		]]
	end
	if name == "manual_1" then
		text = _[[
			 ---+---+---+---+   A&M Transport System<color_cyan>(AMTS)</color>   +---+---+---+--- 
			                         <color_cyan>(Owner's Manual)</color> 1/3
			 
			<color_pink>[Overview]</color>
			    First you must install the implant kit as per instructions, so you can 
				be connected to the Alice & Maria Dimensional Transfer network.

			<color_pink>[Implant Installation]</color>
			    1. Press both power buttons (Fig 1) of the enclosed cylinder simutaniously.
			    2. Wait until the display on the cylinder shows [Ready]
				3. Apply the marked side of the cylinder to the upper arm (Fig 2)
				4. Press the button on top of the cylinder to initialize the process.
			 
			 ---+---+---+---+---+---+---+--------+---+---+---+---+---+---+--- 
		]]
	end
	if name == "manual_2" then
		text = _[[
			 ---+---+---+---+   A&M Transport System<color_cyan>(AMTS)</color>   +---+---+---+--- 
			                         <color_cyan>(Owner's Manual)</color> 2/3
			 
			<color_pink>[How to use the system]</color>
				The entire system is controlled by a neutral interface.
				You can give commands simply by thinking about it.
				By default, an audio response will play in response to commands
				to assist in verifying the system had properly received your request.
			<color_pink>[Basic Operation]</color>
			    <color_light_blue>[Tutorial]/[ON,OFF]</color> : Toggles tutorial guidance
			    <color_light_blue>[Help]/[Search]</color> : Confirm usage with voice commands
			    <color_light_blue>[Transfer]/[ ID ]</color> : Two-way item transfer
			     - Please think of the product ID, or imagine the picture of the item 
				   to place an order with the system
				 - Please use the matter compression system to send large items (p. 51)
				 - Please read p. 42 for detailed usage and tips
			    <color_light_blue>[Time]/[ON/OFF]</color> : Displays time (p. 5)
			    <color_light_blue>[Thermometer]/[ON/OFF]</color> : Displays temperature (p. 5)
			    <color_light_blue>[Alarm]</color> : Display alarm in view (p. 5)
				 
			 ---+---+---+---+---+---+---+--------+---+---+---+---+---+---+--- 
		]]
	end
	if name == "manual_3" then
		text = _[[
			 ---+---+---+---+   A&M Transport System<color_cyan>(AMTS)</color>   +---+---+---+--- 
			                         <color_cyan>(Owner's Manual)</color> 3/3
			     
			 <color_light_blue> [Distance] / [Pointing object] </ color>: Measure the distance (p. 4)
			 <color_light_blue> [Gadget] / [File] </ color>: Display gadget in view (p. 8)
			 <color_light_blue> [Memo] / [text] </ color>: Save text (p. 9)
			 <color_light_blue> [Camera] / [Range instruction] </ color>: Save the view image (p. 11)
			 <color_light_blue> [Record] / [Start / Stop] </ color>: Save audio (p. 16)
			 <color_light_blue> [calculation] / [calculation formula] </ color>: Calculator (p. 18)
			 <color_light_blue> [Open File] / [File] </ color>: Display images, sounds, etc. (p. 20)
			 
				 
			 ---+---+---+---+---+---+---+--------+---+---+---+---+---+---+--- 
		]]
	end
	return text
end

game.register_iuse("IUSE_KAWAII_AMTS_KIT", amts_kit)
game.register_iuse("IUSE_KAWAII_AMTS_KIT2", amts_kit2)
game.register_iuse("IUSE_KAWAII_AMTS_MANUAL", amts_manual)
game.register_iuse("IUSE_KAWAII_AMTR", amts_reciver)
game.register_iuse("IUSE_KAWAII_AMTT", amts_transmitter)
