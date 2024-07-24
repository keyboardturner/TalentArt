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
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. L["NoConfig"] )
	else
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name )
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
		local category, layout = Settings.RegisterCanvasLayoutCategory(TalentArtPanel, TalentArtPanel.name, TalentArtPanel.name);
		TalentArtPanel.name = L["Name"]
		category.ID = TalentArtPanel.name;
		Settings.RegisterAddOnCategory(category)

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
		TalentArtPanel.specName:SetPoint("TOPLEFT", 155, -53)
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
	if PlayerSpellsFrame == nil then
		return
	end
	if PlayerSpellsFrame.TalentsFrame == nil then
		return
	end
	local specID = GetSpecializationInfo(GetSpecialization())
	local bingus = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())

	--print("DEBUG talent build ID: " .. (bingus or "nil"))
	--print(L.talentTextures[backgroundTester][texture])

	local class, classIndex = UnitClassBase("player")
	if ((TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil)) and talentArt.specChecker() == false then
		--(TalentArt_DB[specID] ~= nil)
		for k, v in pairs(L.defaultTextures[class]) do
			if k == GetSpecialization() then
				--print("DEBUG class 1: " .. class)
				--print("DEBUG texture 1: " .. L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])
			end
		end
	else
		if TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			PlayerSpellsFrame.TalentsFrame.Background:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].background)
			PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].right)
			PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].flash)
			PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetTexture(TalentArt_DB[talentArt.specChecker(specID)].mid)
		else
			for k, v in pairs(L.defaultTextures[class]) do
				if k == GetSpecialization() then
					--print("DEBUG class 2: " .. class)
					--print("DEBUG texture 2: " .. L.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(L.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])
				end
			end
		end
		if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) ~= nil then
			--print("DEBUG class 3: " .. class)
			--print("DEBUG texture 3: " .. L.defaultTextures[class][k])
			PlayerSpellsFrame.TalentsFrame.Background:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].background)
			PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].right)
			PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].flash)
			PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetTexture(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())].mid)
		end
	end
end

function talentArt:login(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "TalentArt" then
		if not TalentArt_DB then
			TalentArt_DB = defaultsTable;
		end
		--TalentArtPanel.ArtButton:SetText(L["DropdownButtonText"])
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
				PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(L.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(L.defaultTextures[class][k])

			end
		end
	end
end

talentArt:SetScript("OnEvent", talentArt.eventDelay)
talentArt.Events:SetScript("OnEvent", talentArt.login)
EventRegistry:RegisterCallback('PlayerSpellsFrame.TalentTab.Show', talentArt.doStuff)
EventRegistry:RegisterCallback('PlayerSpellsFrame.OpenFrame', talentArt.doStuff)

local TableOStuff = {
	[1] = {
		ThemeName = "Classic",
		ThemeFile = "Classic",
		Data = {
			[1] = {
				className = "Death Knight",
				classFile = "DeathKnight",
				specs = {
					[1] = {
						specName = "Blood",
						specFile = "Blood",
					},
					[2] = {
						specName = "Frost",
						specFile = "Frost",
					},
					[3] = {
						specName = "Unholy",
						specFile = "Unholy",
					},
				},
			},
			[2] = {
				className = "Druid",
				classFile = "Druid",
				specs = {
					[1] = {
						specName = "Balance",
						specFile = "Balance",
					},
					[2] = {
						specName = "Feral",
						specFile = "Feral",
					},
					[3] = {
						specName = "Restoration",
						specFile = "Resto",
					},
				},
			},
			[3] = {
				className = "Hunter",
				classFile = "Hunter",
				specs = {
					[1] = {
						specName = "Beast Master",
						specFile = "Beast",
					},
					[2] = {
						specName = "Marksmanship",
						specFile = "MM",
					},
					[3] = {
						specName = "Survival",
						specFile = "SV",
					},
					[4] = {
						specName = "Cunning",
						specFile = "PetCunning",
					},
					[5] = {
						specName = "Ferocity",
						specFile = "PetFerocity",
					},
					[6] = {
						specName = "Tenacity",
						specFile = "PetTenacity",
					},
				},
			},
			[4] = {
				className = "Mage",
				classFile = "Mage",
				specs = {
					[1] = {
						specName = "Arcane",
						specFile = "Arcane",
					},
					[2] = {
						specName = "Fire",
						specFile = "Fire",
					},
					[3] = {
						specName = "Frost",
						specFile = "Frost",
					},
				},
			},
			[5] = {
				className = "Paladin",
				classFile = "Paladin",
				specs = {
					[1] = {
						specName = "Holy",
						specFile = "Holy",
					},
					[2] = {
						specName = "Protection",
						specFile = "Prot",
					},
					[3] = {
						specName = "Retribution",
						specFile = "Ret",
					},
				},
			},
			[6] = {
				className = "Priest",
				classFile = "Priest",
				specs = {
					[1] = {
						specName = "Discipline",
						specFile = "Disc",
					},
					[2] = {
						specName = "Holy",
						specFile = "Holy",
					},
					[3] = {
						specName = "Shadow",
						specFile = "Void",
					},
				},
			},
			[7] = {
				className = "Rogue",
				classFile = "Rogue",
				specs = {
					[1] = {
						specName = "Assassination",
						specFile = "Ass",
					},
					[2] = {
						specName = "Combat",
						specFile = "Outlaw",
					},
					[3] = {
						specName = "Subtlety",
						specFile = "Sub",
					},
				},
			},
			[8] = {
				className = "Shaman",
				classFile = "Shaman",
				specs = {
					[1] = {
						specName = "Elemental",
						specFile = "Ele",
					},
					[2] = {
						specName = "Enhancement",
						specFile = "Enh",
					},
					[3] = {
						specName = "Restoration",
						specFile = "Resto",
					},
				},
			},
			[9] = {
				className = "Warlock",
				classFile = "Warlock",
				specs = {
					[1] = {
						specName = "Affliction",
						specFile = "Aff",
					},
					[2] = {
						specName = "Demonology",
						specFile = "Demo",
					},
					[3] = {
						specName = "Destruction",
						specFile = "Dest",
					},
				},
			},
			[10] = {
				className = "Warrior",
				classFile = "Warrior",
				specs = {
					[1] = {
						specName = "Arms 1",
						specFile = "Arms1",
					},
					[2] = {
						specName = "Arms 2",
						specFile = "Arms2",
					},
					[3] = {
						specName = "Fury",
						specFile = "Fury",
					},
					[4] = {
						specName = "Protection",
						specFile = "Prot",
					},
				},
			},
		},
	},

	[2] = {
		ThemeName = "Artifact Traits",
		ThemeFile = "Artifact",
		Data = {
			[1] = {
				className = "Death Knight",
				classFile = "DeathKnight",
			},
			[2] = {
				className = "Demon Hunter",
				classFile = "DemonHunter",
			},
			[3] = {
				className = "Druid",
				classFile = "Druid",
			},
			[4] = {
				className = "Hunter",
				classFile = "Hunter",
			},
			[5] = {
				className = "Mage",
				classFile = "Mage",
			},
			[6] = {
				className = "Monk",
				classFile = "Monk",
			},
			[7] = {
				className = "Paladin",
				classFile = "Paladin",
			},
			[8] = {
				className = "Priest",
				classFile = "Priest",
			},
			[9] = {
				className = "Priest Shadow",
				classFile = "PriestShadow",
			},
			[10] = {
				className = "Rogue",
				classFile = "Rogue",
			},
			[11] = {
				className = "Shaman",
				classFile = "Shaman",
			},
			[12] = {
				className = "Warlock",
				classFile = "Warlock",
			},
			[13] = {
				className = "Warrior",
				classFile = "Warrior",
			},
		},
	},
	
	[3] = {
		ThemeName = "Blizzard Website",
		ThemeFile = "Website",
		Data = {
			[1] = {
				className = "Death Knight",
				classFile = "DeathKnight",
			},
			[2] = {
				className = "Demon Hunter",
				classFile = "DemonHunter",
			},
			[3] = {
				className = "Druid",
				classFile = "Druid",
			},
			[4] = {
				className = "Evoker",
				classFile = "Evoker",
			},
			[5] = {
				className = "Hunter",
				classFile = "Hunter",
			},
			[6] = {
				className = "Mage",
				classFile = "Mage",
			},
			[7] = {
				className = "Monk",
				classFile = "Monk",
			},
			[8] = {
				className = "Paladin",
				classFile = "Paladin",
			},
			[9] = {
				className = "Priest",
				classFile = "Priest",
			},
			[10] = {
				className = "Rogue",
				classFile = "Rogue",
			},
			[11] = {
				className = "Shaman",
				classFile = "Shaman",
			},
			[12] = {
				className = "Warlock",
				classFile = "Warlock",
			},
			[13] = {
				className = "Warrior",
				classFile = "Warrior",
			},
		},
	},
};

--New 11.0.0 Menu API change
local Dropdown = CreateFrame("DropdownButton", nil, TalentArtPanel, "WowStyle1DropdownTemplate")
Dropdown:SetDefaultText("Art Selection")
Dropdown:SetPoint("TOPLEFT", 0, -50);
Dropdown:SetSize(150,30)
Dropdown:SetupMenu(function(dropdown, rootDescription)
	--rootDescription:CreateTitle("Test Menu")

	--Classic
	local elementDescription = rootDescription:CreateButton(TableOStuff[1]["ThemeName"])
	for k, v in ipairs(TableOStuff[1]["Data"]) do
		local submenumenu = elementDescription:CreateButton(TableOStuff[1]["Data"][k]["className"])
		for subk, subv in ipairs(TableOStuff[1]["Data"][k]["specs"]) do
			local submenumenuButton = submenumenu:CreateButton(TableOStuff[1]["Data"][k]["specs"][subk]["specName"], function()
				local bingle = L.talentTextures[TableOStuff[1]["ThemeFile"]][TableOStuff[1]["Data"][k]["classFile"]..TableOStuff[1]["Data"][k]["specs"][subk]["specFile"]]
				local bingleBackground = L.talentTextures[TableOStuff[1]["ThemeFile"]][TableOStuff[1]["Data"][k]["classFile"]..TableOStuff[1]["Data"][k]["specs"][subk]["specFile"]]["background"]
				if talentArt.specChecker() ~= false then
					TalentArt_DB[talentArt.specChecker(specID)] = bingle
					TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
				else
					TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = bingle
					TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
				end

				talentArt.eventDelay()
			end)
		end
	end

	--Artifacts
	local elementDescription = rootDescription:CreateButton(TableOStuff[2]["ThemeName"])
	for k, v in ipairs(TableOStuff[2]["Data"]) do
		local submenumenu = elementDescription:CreateButton(TableOStuff[2]["Data"][k]["className"], function()
			local bingle = L.talentTextures[TableOStuff[2]["ThemeFile"]][TableOStuff[2]["Data"][k]["classFile"]]
			local bingleBackground = L.talentTextures[TableOStuff[2]["ThemeFile"]][TableOStuff[2]["Data"][k]["classFile"]]["background"]
			if talentArt.specChecker() ~= false then
				TalentArt_DB[talentArt.specChecker(specID)] = bingle
				TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
			else
				TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = bingle
				TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
			end

			talentArt.eventDelay()
		end)
	end

	--Website
	local elementDescription = rootDescription:CreateButton(TableOStuff[3]["ThemeName"])
	for k, v in ipairs(TableOStuff[3]["Data"]) do
		local submenumenu = elementDescription:CreateButton(TableOStuff[3]["Data"][k]["className"], function()
			local bingle = L.talentTextures[TableOStuff[3]["ThemeFile"]][TableOStuff[3]["Data"][k]["classFile"]]
			local bingleBackground = L.talentTextures[TableOStuff[3]["ThemeFile"]][TableOStuff[3]["Data"][k]["classFile"]]["background"]
			if talentArt.specChecker() ~= false then
				TalentArt_DB[talentArt.specChecker(specID)] = bingle
				TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
			else
				TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = bingle
				TalentArtPanel.Preview.tex:SetTexture(bingleBackground)
			end

			talentArt.eventDelay()
		end)
	end
end)


function talentArt.TalentFrameEventFrame()
	if UnitAffectingCombat("player") ~= true then
		Dropdown:ClearAllPoints()
		Dropdown:SetParent(PlayerSpellsFrame.TalentsFrame)
		Dropdown:Show()
		Dropdown:SetPoint("BOTTOM", PlayerSpellsFrame.TalentsFrame.LoadSystem.Dropdown, "TOP", 0, 2.5)
		Dropdown:SetSize(200,25)
	else
		return
	end
end

function talentArt.SettingsPanelEventFrame()
	if UnitAffectingCombat("player") ~= true then
		Dropdown:ClearAllPoints()
		Dropdown:SetParent(TalentArtPanel)
		Dropdown:Show()
		Dropdown:SetPoint("TOPLEFT", TalentArtPanel, "TOPLEFT", 0, -50);
		Dropdown:SetSize(150,30)
	else
		return
	end
end

EventRegistry:RegisterCallback('PlayerSpellsFrame.TalentTab.Show', talentArt.TalentFrameEventFrame)
EventRegistry:RegisterCallback('Settings.CategoryChanged', talentArt.SettingsPanelEventFrame)