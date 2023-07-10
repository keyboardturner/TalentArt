local _, L = ...

local defaultsTable = {
};

local TalentArtPanel = CreateFrame("Frame")
TalentArtPanel:RegisterEvent("ADDON_LOADED")
local talentArt = CreateFrame("Frame")

TalentArtPanel.Preview = CreateFrame("Frame", nil, TalentArtPanel)
TalentArtPanel.Preview:ClearAllPoints();
TalentArtPanel.Preview:SetPoint("TOPRIGHT", TalentArtPanel, "TOPRIGHT", -25, -50*2);
TalentArtPanel.Preview:SetSize(650, 325)

function talentArt.specChecker()
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) ~= nil then
		return false
	else
		local specID = GetSpecializationInfo(GetSpecialization())
		return specID
	end
end

TalentArtPanel.Preview.tex = TalentArtPanel.Preview:CreateTexture()
TalentArtPanel.Preview.tex:SetAllPoints(TalentArtPanel.Preview)
TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.backgroundTester.background)
TalentArtPanel.Preview.tex:SetScript("OnShow", function()
	if C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())) == nil then
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. L["NoConfig"] )
	else
		if C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name ~= nil then
			TalentArtPanel.specName:SetText(L["CurrentConfig"] .. C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name )
		end
	end
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
		local class, classIndex = UnitClassBase("player")
		for k, v in pairs(L.defaultTextures[class]) do
			if k == GetSpecialization() then
				TalentArtPanel.Preview.tex:SetAtlas(L.defaultTextures[class][k])
			end
		end
		if TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			TalentArtPanel.Preview.tex:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].background)
		end
		return
	else
	TalentArtPanel.Preview.tex:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].background)
	end
end)


function TalentArtPanel:InitializeOptions(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "TalentArt" then

		TalentArtPanel.name = L["Name"]
		InterfaceOptions_AddCategory(TalentArtPanel)

		-- Create the scrolling parent frame and size it to fit inside the texture
		TalentArtPanel.scrollFrame = CreateFrame("ScrollFrame", nil, TalentArtPanel, "UIPanelScrollFrameTemplate")
		TalentArtPanel.scrollFrame:SetPoint("TOPLEFT", 3, -4)
		TalentArtPanel.scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

		-- Create the scrolling child frame, set its width to fit, and give it an arbitrary minimum height (such as 1)
		TalentArtPanel.scrollChild = CreateFrame("Frame")
		TalentArtPanel.scrollFrame:SetScrollChild(TalentArtPanel.scrollChild)
		TalentArtPanel.scrollChild:SetWidth(SettingsPanel.Container:GetWidth()-18)
		TalentArtPanel.scrollChild:SetHeight(1) 

		-- Add widgets to the scrolling child frame as desired
		TalentArtPanel.title = TalentArtPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
		TalentArtPanel.title:SetPoint("TOPLEFT", 10, -15)
		TalentArtPanel.title:SetText(L["Name"])

		TalentArtPanel.specName = TalentArtPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
		TalentArtPanel.specName:SetPoint("TOPLEFT", 150, -50)
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. "Placeholder")

		--[[
		TalentArtPanel.footer = TalentArtPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
		TalentArtPanel.footer:SetPoint("TOP", 0, -5000)
		TalentArtPanel.footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")
		]]

	end
end









TalentArtPanel:SetScript("OnEvent", TalentArtPanel.InitializeOptions)


talentArt:RegisterEvent("TRAIT_CONFIG_UPDATED")
talentArt:RegisterEvent("PLAYER_TALENT_UPDATE")
talentArt.Events = CreateFrame("Frame")
talentArt.Events:RegisterEvent("ADDON_LOADED")

function talentArt.doStuff()
	if ClassTalentFrame == nil then
		return
	end
	local specID = GetSpecializationInfo(GetSpecialization())
	
	--print("DEBUG talent build ID: " .. (bingus or "nil"))
	--print(L.talentTextures[backgroundTester][texture])

	local class, classIndex = UnitClassBase("player")
	if ((TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil)) and talentArt.specChecker() == false then
		--(TalentArt_DB[specID] ~= nil)
		for k, v in pairs(L.defaultTextures[class]) do
			if k == GetSpecialization() then
				--print("DEBUG class: " .. class)
				--print("DEBUG texture: " .. L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.Background:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])
			end
		end
	else
		if TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			ClassTalentFrame.TalentsTab.Background:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].background)
			ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].right)
			ClassTalentFrame.TalentsTab.BackgroundFlash:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].flash)
			ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].mid)
		else
			for k, v in pairs(L.defaultTextures[class]) do
				if k == GetSpecialization() then
					--print("DEBUG class: " .. class)
					--print("DEBUG texture: " .. L.defaultTextures[class][k])
					ClassTalentFrame.TalentsTab.Background:SetAtlas(L.defaultTextures[class][k])
					ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
					ClassTalentFrame.TalentsTab.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
					ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])
				end
			end
		end
		if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) ~= nil then
			ClassTalentFrame.TalentsTab.Background:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].background)
			ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].right)
			ClassTalentFrame.TalentsTab.BackgroundFlash:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].flash)
			ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].mid)
		end
	end
end

function talentArt:login(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "TalentArt" then
		if not TalentArt_DB then
			TalentArt_DB = defaultsTable;
		end
		TalentArtPanel.ArtButton:SetText(L["DropdownButtonText"])
	end
end

function talentArt.eventDelay() --the config ID is not updated at this point yet until the very next frame after
	RunNextFrame(talentArt.doStuff)
end


function talentArt.resetBackground()
	local class, classIndex = UnitClassBase("player")
	for k, v in pairs(L.defaultTextures[class]) do
		if k == GetSpecialization() then

			if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) then
				TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = nil
			end
			if talentArt.specChecker() ~= false then
				TalentArt_DB[talentArt.specChecker(specID)] = nil
			end

			TalentArtPanel.Preview.tex:SetAtlas(L.defaultTextures[class][k])

			if ClassTalentFrame == nil then
				return

			else
				ClassTalentFrame.TalentsTab.Background:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])

			end
		end
	end
end

talentArt:SetScript("OnEvent", talentArt.eventDelay)
talentArt.Events:SetScript("OnEvent", talentArt.login)
EventRegistry:RegisterCallback('TalentFrame.TalentTab.Show', talentArt.doStuff)
EventRegistry:RegisterCallback('TalentFrame.OpenFrame', talentArt.doStuff)


TalentArtPanel.menu = {

	{ text = "Select an Option", isTitle = true},
	--[[
	{ text = "Tester",
		func = function()
			if talentArt.specChecker() ~= false then
				TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.backgroundTester
				TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.backgroundTester.background)
				return
			end
			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.backgroundTester
			TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.backgroundTester.background)
		end
	},
	]]

	{ text = "Classic", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "Death Knight", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Blood", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DeathKnightBlood
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightBlood.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DeathKnightBlood
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightBlood.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DeathKnightFrost
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightFrost.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DeathKnightFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightFrost.background)
						end
					},
					{ text = "Unholy", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DeathKnightUnholy
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightUnholy.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DeathKnightUnholy
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DeathKnightUnholy.background)
						end
					},
				},
			},
			{ text = "Druid", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Balance", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DruidBalance
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidBalance.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DruidBalance
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidBalance.background)
						end
					},
					{ text = "Feral", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DruidFeral
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidFeral.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DruidFeral
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidFeral.background)
						end
					},
					{ text = "Restoration", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.DruidResto
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidResto.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.DruidResto
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.DruidResto.background)
						end
					},
				},
			},
			{ text = "Hunter", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Beast Master", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterBeast
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterBeast.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterBeast
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterBeast.background)
						end
					},
					{ text = "Marksmanship", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterMM
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterMM.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterMM
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterMM.background)
						end
					},
					{ text = "Survival", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterSV
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterSV.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterSV
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterSV.background)
						end
					},
					{ text = "Cunning", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterPetCunning
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetCunning.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterPetCunning
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetCunning.background)
						end
					},
					{ text = "Ferocity", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterPetFerocity
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetFerocity.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterPetFerocity
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetFerocity.background)
						end
					},
					{ text = "Tenacity", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.HunterPetTenacity
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetTenacity.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.HunterPetTenacity
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.HunterPetTenacity.background)
						end
					},
				},
			},
			{ text = "Mage", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arcane", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.MageArcane
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageArcane.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.MageArcane
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageArcane.background)
						end
					},
					{ text = "Fire", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.MageFire
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageFire.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.MageFire
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageFire.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.MageFrost
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageFrost.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.MageFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.MageFrost.background)
						end
					},
				},
			},
			{ text = "Paladin", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Holy", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PaladinHoly
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinHoly.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PaladinHoly
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinHoly.background)
						end
					},
					{ text = "Protection", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PaladinProt
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinProt.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PaladinProt
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinProt.background)
						end
					},
					{ text = "Retribution", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PaladinRet
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinRet.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PaladinRet
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PaladinRet.background)
						end
					},
				},
			},
			{ text = "Priest", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Discipline", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PriestDisc
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestDisc.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PriestDisc
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestDisc.background)
						end
					},
					{ text = "Holy", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PriestHoly
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestHoly.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PriestHoly
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestHoly.background)
						end
					},
					{ text = "Shadow", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.PriestVoid
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestVoid.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.PriestVoid
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.PriestVoid.background)
						end
					},
				},
			},
			{ text = "Rogue", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Assassination", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.RogueAss
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueAss.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.RogueAss
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueAss.background)
						end
					},
					{ text = "Combat", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.RogueOutlaw
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueOutlaw.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.RogueOutlaw
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueOutlaw.background)
						end
					},
					{ text = "Subtlety", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.RogueSub
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueSub.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.RogueSub
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.RogueSub.background)
						end
					},
				},
			},
			{ text = "Shaman", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Elemental", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.ShamanEle
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanEle.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.ShamanEle
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanEle.background)
						end
					},
					{ text = "Enhancement", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.ShamanEnh
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanEnh.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.ShamanEnh
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanEnh.background)
						end
					},
					{ text = "Restoration", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.ShamanResto
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanResto.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.ShamanResto
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.ShamanResto.background)
						end
					},
				},
			},
			{ text = "Warlock", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Affliction", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarlockAff
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockAff.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarlockAff
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockAff.background)
						end
					},
					{ text = "Demonology", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarlockDemo
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockDemo.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarlockDemo
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockDemo.background)
						end
					},
					{ text = "Destruction", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarlockDest
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockDest.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarlockDest
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarlockDest.background)
						end
					},
				},
			},
			{ text = "Warrior", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arms 1", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarriorArms1
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorArms1.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarriorArms1
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorArms1.background)
						end
					},
					{ text = "Arms 2", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarriorArms2
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorArms2.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarriorArms2
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorArms2.background)
						end
					},
					{ text = "Fury", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarriorFury
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorFury.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarriorFury
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorFury.background)
						end
					},
					{ text = "Protection", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Classic.WarriorProt
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorProt.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Classic.WarriorProt
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Classic.WarriorProt.background)
						end
					},
				},
			},
		},
	},


	{ text = "Artifact Traits", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "Death Knight", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.DeathKnight
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.DeathKnight.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.DeathKnight
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.DeathKnight.background)
				end
			},
			{ text = "Demon Hunter", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.DemonHunter
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.DemonHunter.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.DemonHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.DemonHunter.background)
				end
			},
			{ text = "Druid", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Druid
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Druid.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Druid
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Druid.background)
				end
			},
			{ text = "Hunter", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Hunter
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Hunter.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Hunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Hunter.background)
				end
			},
			{ text = "Mage", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Mage
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Mage.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Mage
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Mage.background)
				end
			},
			{ text = "Monk", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Monk
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Monk.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Monk
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Monk.background)
				end
			},
			{ text = "Paladin", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Paladin
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Paladin.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Paladin
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Paladin.background)
				end
			},
			{ text = "Priest", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Priest
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Priest.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Priest
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Priest.background)
				end
			},
			{ text = "Priest Shadow", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.PriestShadow
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.PriestShadow.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.PriestShadow
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.PriestShadow.background)
				end
			},
			{ text = "Rogue", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Rogue
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Rogue.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Rogue
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Rogue.background)
				end
			},
			{ text = "Shaman", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Shaman
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Shaman.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Shaman
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Shaman.background)
				end
			},
			{ text = "Warlock", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Warlock
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Warlock.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Warlock
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Warlock.background)
				end
			},
			{ text = "Warrior", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Artifact.Warrior
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Warrior.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Artifact.Warrior
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Artifact.Warrior.background)
				end
			},
		},
	},


	{ text = "Blizzard Website", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "DeathKnight", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.DeathKnight
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.DeathKnight.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.DeathKnight
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.DeathKnight.background)
				end
			},
			{ text = "DemonHunter", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.DemonHunter
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.DemonHunter.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.DemonHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.DemonHunter.background)
				end
			},
			{ text = "Druid", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Druid
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Druid.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Druid
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Druid.background)
				end
			},
			{ text = "Evoker", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Evoker
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Evoker.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Evoker
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Evoker.background)
				end
			},
			{ text = "Hunter", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Hunter
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Hunter.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Hunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Hunter.background)
				end
			},
			{ text = "Mage", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Mage
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Mage.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Mage
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Mage.background)
				end
			},
			{ text = "Monk", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Monk
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Monk.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Monk
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Monk.background)
				end
			},
			{ text = "Paladin", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Paladin
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Paladin.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Paladin
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Paladin.background)
				end
			},
			{ text = "Priest", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Priest
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Priest.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Priest
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Priest.background)
				end
			},
			{ text = "Rogue", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Rogue
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Rogue.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Rogue
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Rogue.background)
				end
			},
			{ text = "Shaman", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Shaman
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Shaman.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Shaman
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Shaman.background)
				end
			},
			{ text = "Warlock", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Warlock
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Warlock.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Warlock
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Warlock.background)
				end
			},
			{ text = "Warrior", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.Website.Warrior
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Warrior.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.Website.Warrior
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.Website.Warrior.background)
				end
			},
		},
	},

--[[
	{ text = "Pandaria Classes (Unfinished)", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "Death Knight", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Blood", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost.background)
						end
					},
					{ text = "Unholy", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy.background)
						end
					},
				},
			},
			{ text = "Demon Hunter", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIDemonHunter
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDemonHunter.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDemonHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDemonHunter.background)
				end
			},
			{ text = "Druid", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIDruid
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDruid.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDruid
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDruid.background)
				end
			},
			{ text = "Hunter", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIHunter
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIHunter.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIHunter.background)
				end
			},
			{ text = "Mage", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arcane", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIMageArcane
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageArcane.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageArcane
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageArcane.background)
						end
					},
					{ text = "Fire", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIMageFire
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFire.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageFire
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFire.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIMageFrost
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFrost.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFrost.background)
						end
					},
				},
			},
			{ text = "Monk", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIMonk
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMonk.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMonk
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMonk.background)
				end
			},
			{ text = "Paladin", notCheckable = false, hasArrow = false,
				func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIPaladin
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPaladin.background)
								return
							end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPaladin
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPaladin.background)
				end
			},
			{ text = "Priest", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Light", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIPriest
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriest.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPriest
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriest.background)
						end
					},
					{ text = "Shadow", notCheckable = false, hasArrow = false,
						func = function()
							if talentArt.specChecker() ~= false then
								TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIPriestShadow
								TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriestShadow.background)
								return
							end
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPriestShadow
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriestShadow.background)
						end
					},
				},
			},
			{ text = "Rogue", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIRogue
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIRogue.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIRogue
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIRogue.background)
				end
			},
			{ text = "Shaman", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIShaman
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIShaman.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIShaman
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIShaman.background)
				end
			},
			{ text = "Warlock", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIWarlock
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarlock.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIWarlock
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarlock.background)
				end
			},
			{ text = "Warrior", notCheckable = false, hasArrow = false,
				func = function()
					if talentArt.specChecker() ~= false then
						TalentArt_DB[talentArt.specChecker(specID)] = L.talentTextures.PvPFrame.ArtifactUIWarrior
						TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarrior.background)
						return
					end
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIWarrior
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarrior.background)
				end
			},
		},
	},
]]

	{ text = "Default",
		func = function()
			talentArt.resetBackground()
		end
	},



	--[[
	{ text = "Dragons", hasArrow = false,
		menuList = {
			{ text = ITEM_QUALITY3_DESC, func = function() TRP3_UF_DB.Border.style = "rare"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ELITE, func = function() TRP3_UF_DB.Border.style = "elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ITEM_QUALITY3_DESC .. " " .. ELITE, func = function() TRP3_UF_DB.Border.style = "rare-elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = BOSS, func = function() TRP3_UF_DB.Border.style = "boss"; PlayerDragonFrame.TextureStuff(); end },
		},
	},
	{ text = "Hearthstone", hasArrow = true,
		menuList = {
			{ text = "Coming Soon!", isTitle = true},
			--{ text = "Option 3", func = function() print("You've chosen option 3"); end },
		},
	},
	{ text = "Narcissus", hasArrow = true,
		menuList = {
			{ text = "Coming Soon!", isTitle = true},
			--{ text = "Option 3", func = function() print("You've chosen option 3"); end },
		},
	},]]
	--{ text = "PH Option 4", func = function() print("You've chosen option 4"); end },
	--{ text = "PH Option 5", func = function() print("You've chosen option 5"); end },
};


TalentArtPanel.menuFrame = CreateFrame("Frame", "TalentArtMenuFrame", TalentArtPanel, "UIDropDownMenuTemplate")

TalentArtPanel.ArtButton = CreateFrame("Button", "TalentArtMenuArtButton", TalentArtPanel, "GameMenuButtonTemplate")
TalentArtPanel.ArtButton:SetPoint("TOPLEFT", 0, -50);
--TalentArtPanel.ArtButton:SetSize(99, 81);
TalentArtPanel.ArtButton:SetScript("OnClick", function()
	--[[
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then 
		print("DEBUG You have no loadout selected! Remember to instead use a nil replacer dummy!")
		return
	end
	]]
	EasyMenu(TalentArtPanel.menu, TalentArtPanel.menuFrame, "TalentArtMenuArtButton", 0 , 0, "MENU", 10)
end)