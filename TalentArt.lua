local _, L, A = ...

local defaultsTable = {
};

local TalentArtPanel = CreateFrame("Frame")
TalentArtPanel:RegisterEvent("ADDON_LOADED")

TalentArtPanel.Preview = CreateFrame("Frame", nil, TalentArtPanel)
TalentArtPanel.Preview:ClearAllPoints();
TalentArtPanel.Preview:SetPoint("TOPRIGHT", TalentArtPanel, "TOPRIGHT", -25, -50*2);
TalentArtPanel.Preview:SetSize(650, 325)

TalentArtPanel.Preview.tex = TalentArtPanel.Preview:CreateTexture()
TalentArtPanel.Preview.tex:SetAllPoints(TalentArtPanel.Preview)
TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.backgroundTester.background)
TalentArtPanel.Preview.tex:SetScript("OnShow", function()
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. L["NoConfig"] )
		local class, classIndex = UnitClassBase("player")
		for k, v in pairs(L.defaultTextures[class]) do
			if k == GetSpecialization() then
				TalentArtPanel.Preview.tex:SetAtlas(L.defaultTextures[class][k])
			end
		end
		return
	else
	TalentArtPanel.Preview.tex:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].background)
	TalentArtPanel.specName:SetText(L["CurrentConfig"] .. C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name )
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


local talentArt = CreateFrame("Frame")
talentArt:RegisterEvent("TRAIT_CONFIG_UPDATED")
talentArt.Events = CreateFrame("Frame")
talentArt.Events:RegisterEvent("ADDON_LOADED")

function talentArt.doStuff()
	local specID = GetSpecializationInfo(GetSpecialization())
	local bingus = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())

	--print("DEBUG talent build ID: " .. (bingus or "nil"))
	--print(L.talentTextures[backgroundTester][texture])
	


	local class, classIndex = UnitClassBase("player")
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
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
		ClassTalentFrame.TalentsTab.Background:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].background)
		ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].right)
		ClassTalentFrame.TalentsTab.BackgroundFlash:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].flash)
		ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].mid)
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

			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = nil

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
	{ text = "Tester",
		func = function()
			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.backgroundTester
			TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.backgroundTester.background)
		end
	},

	{ text = "Classic Originals", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "Death Knight", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Blood", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DKBlood
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DKBlood.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DKFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DKFrost.background)
						end
					},
					{ text = "Unholy", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DKUnholy
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DKUnholy.background)
						end
					},
				},
			},
			{ text = "Druid", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Balance", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DruidBalance
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DruidBalance.background)
						end
					},
					{ text = "Feral", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DruidFeral
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DruidFeral.background)
						end
					},
					{ text = "Guardian", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DruidGuardian
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DruidGuardian.background)
						end
					},
					{ text = "Restoration", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.DruidResto
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.DruidResto.background)
						end
					},
				},
			},
			{ text = "Hunter", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Beast Master", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterBestiality
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterBestiality.background)
						end
					},
					{ text = "Marksmanship", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterMM
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterMM.background)
						end
					},
					{ text = "Survival", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterSV
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterSV.background)
						end
					},
					{ text = "Cunning", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterPetCunt
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterPetCunt.background)
						end
					},
					{ text = "Ferocity", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterPetFerocity
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterPetFerocity.background)
						end
					},
					{ text = "Tenacity", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.HunterPetTen
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.HunterPetTen.background)
						end
					},
				},
			},
			{ text = "Mage", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arcane", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.MageArcane
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.MageArcane.background)
						end
					},
					{ text = "Fire", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.MageFire
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.MageFire.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.MageFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.MageFrost.background)
						end
					},
				},
			},
			{ text = "Paladin", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Holy", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PaladinHoly
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PaladinHoly.background)
						end
					},
					{ text = "Protection", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PaladinProt
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PaladinProt.background)
						end
					},
					{ text = "Retribution", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PaladinRet
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PaladinRet.background)
						end
					},
				},
			},
			{ text = "Priest", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Discipline", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PriestDisc
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PriestDisc.background)
						end
					},
					{ text = "Holy", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PriestHoly
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PriestHoly.background)
						end
					},
					{ text = "Shadow", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.PriestVoid
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.PriestVoid.background)
						end
					},
				},
			},
			{ text = "Rogue", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Assassination", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.RogueAss
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.RogueAss.background)
						end
					},
					{ text = "Combat", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.RogueOutlaw
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.RogueOutlaw.background)
						end
					},
					{ text = "Subtlety", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.RogueSub
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.RogueSub.background)
						end
					},
				},
			},
			{ text = "Shaman", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Elemental", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.ShamanEle
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.ShamanEle.background)
						end
					},
					{ text = "Enhancement", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.ShamanEnh
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.ShamanEnh.background)
						end
					},
					{ text = "Restoration", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.ShamanResto
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.ShamanResto.background)
						end
					},
				},
			},
			{ text = "Warlock", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Affliction", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarlockAff
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarlockAff.background)
						end
					},
					{ text = "Demonology", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarlockDemo
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarlockDemo.background)
						end
					},
					{ text = "Destruction", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarlockDest
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarlockDest.background)
						end
					},
				},
			},
			{ text = "Warrior", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arms", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarriorArms
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarriorArms.background)
						end
					},
					{ text = "Fury", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarriorFury
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarriorFury.background)
						end
					},
					{ text = "Protection", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.SpecFrame.WarriorProt
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.SpecFrame.WarriorProt.background)
						end
					},
				},
			},

		},
	},


	{ text = "Artifact Traits", notCheckable = true, hasArrow = true,
		menuList = {
			{ text = "Death Knight", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Blood", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightBlood.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightFrost.background)
						end
					},
					{ text = "Unholy", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDeathKnightUnholy.background)
						end
					},
				},
			},
			{ text = "Demon Hunter", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDemonHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDemonHunter.background)
				end
			},
			{ text = "Druid", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIDruid
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIDruid.background)
				end
			},
			{ text = "Hunter", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIHunter
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIHunter.background)
				end
			},
			{ text = "Mage", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Arcane", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageArcane
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageArcane.background)
						end
					},
					{ text = "Fire", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageFire
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFire.background)
						end
					},
					{ text = "Frost", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMageFrost
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMageFrost.background)
						end
					},
				},
			},
			{ text = "Monk", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIMonk
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIMonk.background)
				end
			},
			{ text = "Paladin", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPaladin
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPaladin.background)
				end
			},
			{ text = "Priest", notCheckable = true, hasArrow = true,
				menuList = {
					{ text = "Light", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPriest
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriest.background)
						end
					},
					{ text = "Shadow", notCheckable = false, hasArrow = false,
						func = function()
							TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIPriestShadow
							TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIPriestShadow.background)
						end
					},
				},
			},
			{ text = "Rogue", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIRogue
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIRogue.background)
				end
			},
			{ text = "Shaman", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIShaman
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIShaman.background)
				end
			},
			{ text = "Warlock", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIWarlock
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarlock.background)
				end
			},
			{ text = "Warrior", notCheckable = false, hasArrow = false,
				func = function()
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.PvPFrame.ArtifactUIWarrior
					TalentArtPanel.Preview.tex:SetTexture(L.talentTextures.PvPFrame.ArtifactUIWarrior.background)
				end
			},
		},
	},

	{ text = "Default",
		func = function()
			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = L.talentTextures.backgroundTester
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
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then 
		print("DEBUG You have no loadout selected! Remember to instead use a nil replacer dummy!")
		return
	end
	EasyMenu(TalentArtPanel.menu, TalentArtPanel.menuFrame, "TalentArtMenuArtButton", 0 , 0, "MENU", 10)
end)