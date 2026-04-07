local addonName, TalentArt = ...;

local L = TalentArt.L;

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
TalentArtPanel.Preview.tex:SetTexture(TalentArt.talentTextures.backgroundTester.background)
TalentArtPanel.Preview.tex:SetScript("OnShow", function()
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. L["NoConfig"] )
	else
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name )
	end
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
		local class, classIndex = UnitClassBase("player")
		for k, v in pairs(TalentArt.defaultTextures[class]) do
			if k == GetSpecialization() then
				TalentArtPanel.Preview.tex:SetAtlas(TalentArt.defaultTextures[class][k])
			end
		end
		if TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			local entry = TalentArt_DB[talentArt.specChecker(specID)]
			if entry.atlas then
				TalentArtPanel.Preview.tex:SetAtlas(entry.atlas)
			else
				TalentArtPanel.Preview.tex:SetTexture(entry.background)
			end
		end
		return
	else
		local entry = TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())]
		if entry.atlas then
			TalentArtPanel.Preview.tex:SetAtlas(entry.atlas)
		else
			TalentArtPanel.Preview.tex:SetTexture(entry.background)
		end
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

local function applyFrameEntry(entry)
	if entry.atlas then
		PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(entry.atlas)
		PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(entry.atlas)
		PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(entry.atlas)
		PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(entry.atlas)
	else
		PlayerSpellsFrame.TalentsFrame.Background:SetTexture(entry.background)
		PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetTexture(entry.right)
		PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetTexture(entry.flash)
		PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetTexture(entry.mid)
	end
end

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

	local class, classIndex = UnitClassBase("player")
	if ((TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil)) and talentArt.specChecker() == false then
		--(TalentArt_DB[specID] ~= nil)
		for k, v in pairs(TalentArt.defaultTextures[class]) do
			if k == GetSpecialization() then
				--print("DEBUG class 1: " .. class)
				--print("DEBUG texture 1: " .. TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(TalentArt.defaultTextures[class][k])
			end
		end
	else
		if TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			applyFrameEntry(TalentArt_DB[talentArt.specChecker(specID)])
		else
			for k, v in pairs(TalentArt.defaultTextures[class]) do
				if k == GetSpecialization() then
					--print("DEBUG class 2: " .. class)
					--print("DEBUG texture 2: " .. TalentArt.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(TalentArt.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(TalentArt.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(TalentArt.defaultTextures[class][k])
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(TalentArt.defaultTextures[class][k])
				end
			end
		end
		if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) ~= nil then
			--print("DEBUG class 3: " .. class)
			applyFrameEntry(TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())])
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
	local specIndex = GetSpecialization()

	local configID = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())
	if configID then
		TalentArt_DB[configID] = nil
	end
	
	if talentArt.specChecker() ~= false then
		TalentArt_DB[talentArt.specChecker()] = nil
	end

	if TalentArt.defaultTextures[class] and TalentArt.defaultTextures[class][specIndex] then
		TalentArtPanel.Preview.tex:SetAtlas(TalentArt.defaultTextures[class][specIndex])
	end

	talentArt.eventDelay()
end

talentArt:SetScript("OnEvent", talentArt.eventDelay)
talentArt.Events:SetScript("OnEvent", talentArt.login)
EventRegistry:RegisterCallback('PlayerSpellsFrame.TalentTab.Show', talentArt.doStuff)
EventRegistry:RegisterCallback('PlayerSpellsFrame.OpenFrame', talentArt.doStuff)

--New 11.0.0 Menu API change
local Dropdown = CreateFrame("DropdownButton", nil, TalentArtPanel, "WowStyle1DropdownTemplate")
Dropdown:OverrideText("Art Selection")
Dropdown:SetPoint("TOPLEFT", 0, -50);
Dropdown:SetSize(150,30)

local function getCurrentKey()
	local configID = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())
	if configID ~= nil then
		return configID
	end
	return GetSpecializationInfo(GetSpecialization())
end

local function isEntrySelected(entry)
	local key = getCurrentKey()
	if not key then return false end
	return TalentArt_DB ~= nil and TalentArt_DB[key] == entry
end

local function applyEntry(entry)
	local key = getCurrentKey()
	if not key then return end
	TalentArt_DB[key] = entry
	if entry.atlas then
		TalentArtPanel.Preview.tex:SetAtlas(entry.atlas)
	else
		TalentArtPanel.Preview.tex:SetTexture(entry.background)
	end
	talentArt.eventDelay()
end

Dropdown:SetupMenu(function(dropdown, rootDescription)
	for _, theme in ipairs(TalentArt.themeList) do
		local elementDescription = rootDescription:CreateButton(theme.name)
		local seenClasses = {}
		for _, entry in ipairs(TalentArt.talentTextures[theme.key]) do
			if entry.specName then
				if not seenClasses[entry.className] then
					seenClasses[entry.className] = elementDescription:CreateButton(entry.className)
				end
				seenClasses[entry.className]:CreateRadio(entry.specName, isEntrySelected, applyEntry, entry)
			else
				elementDescription:CreateRadio(entry.className, isEntrySelected, applyEntry, entry)
			end
		end
	end

	rootDescription:CreateDivider()
	rootDescription:CreateButton("Reset to Default", function()
		talentArt.resetBackground()
		Dropdown:GenerateMenu()
	end)
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