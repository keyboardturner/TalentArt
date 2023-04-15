local _, L = ...

local defaultsTable = {
};

local talentTextures = {
	backgroundTester = {
		background = "Interface\\AddOns\\TalentArt\\Media\\Class2\\Rogue.blp",
		right = "Interface\\AddOns\\TalentArt\\Media\\Class2\\Rogue.blp",
		flash = "Interface\\AddOns\\TalentArt\\Media\\Class2\\Rogue.blp",
		mid = "Interface\\AddOns\\TalentArt\\Media\\Class2\\Rogue.blp",
		colorImg = {
			r = 1, g = 1, b = 1, a = 1,
		},
		colorBG = {
			r = 1, g = 1, b = 1,
		},
	},
};

local defaultTextures = {
	WARRIOR = {
		[1] = "talents-background-warrior-arms",
		[2] = "talents-background-warrior-fury",
		[3] = "talents-background-warrior-protection",
	},
	PALADIN = {
		[1] = "talents-background-paladin-holy",
		[2] = "talents-background-paladin-protection",
		[3] = "talents-background-paladin-retribution",
	},
	DEATHKNIGHT = {
		[1] = "talents-background-deathknight-blood",
		[2] = "talents-background-deathknight-frost",
		[3] = "talents-background-deathknight-unholy",
	},

	HUNTER = {
		[1] = "talents-background-hunter-beastmastery",
		[2] = "talents-background-hunter-marksmanship",
		[3] = "talents-background-hunter-survival",
	},
	SHAMAN = {
		[1] = "talents-background-shaman-elemental",
		[2] = "talents-background-shaman-enhancement",
		[3] = "talents-background-shaman-restoration",
	},
	EVOKER = {
		[1] = "talents-background-evoker-devastation",
		[2] = "talents-background-evoker-preservation",
	},
	
	DRUID = {
		[1] = "talents-background-druid-balance",
		[2] = "talents-background-druid-feral",
		[3] = "talents-background-druid-guardian",
		[4] = "talents-background-druid-restoration",
	},
	ROGUE = {
		[1] = "talents-background-rogue-assassination",
		[2] = "talents-background-rogue-outlaw",
		[3] = "talents-background-rogue-subtlety",
	},
	MONK = {
		[1] = "talents-background-monk-brewmaster",
		[2] = "talents-background-monk-mistweaver",
		[3] = "talents-background-monk-windwalker",
	},
	DEMONHUNTER = {
		[1] = "talents-background-demonhunter-havoc",
		[3] = "talents-background-demonhunter-vengeance",
	},
	
	PRIEST = {
		[1] = "talents-background-priest-discipline",
		[2] = "talents-background-priest-holy",
		[3] = "talents-background-priest-shadow",
	},
	MAGE = {
		[1] = "talents-background-mage-arcane",
		[2] = "talents-background-mage-fire",
		[3] = "talents-background-mage-frost",
	},
	WARLOCK = {
		[1] = "talents-background-warlock-affliction",
		[2] = "talents-background-warlock-demonology",
		[3] = "talents-background-warlock-destruction",
	},
};

local TalentArtPanel = CreateFrame("Frame")
TalentArtPanel:RegisterEvent("ADDON_LOADED")

TalentArtPanel.Preview = CreateFrame("Frame", nil, TalentArtPanel)
TalentArtPanel.Preview:ClearAllPoints();
TalentArtPanel.Preview:SetPoint("TOPRIGHT", TalentArtPanel, "TOPRIGHT", -25, -50*2);
TalentArtPanel.Preview:SetSize(650, 325)

TalentArtPanel.Preview.tex = TalentArtPanel.Preview:CreateTexture()
TalentArtPanel.Preview.tex:SetAllPoints(TalentArtPanel.Preview)
TalentArtPanel.Preview.tex:SetTexture(talentTextures.backgroundTester.background)


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

	print("talent build ID: " .. (bingus or "nil"))
	--print(talentTextures[backgroundTester][texture])
	


	local class, classIndex = UnitClassBase("player")
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
		for k, v in pairs(defaultTextures[class]) do
			if k == GetSpecialization() then
				--print("class: " .. class)
				print("texture: " .. defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.Background:SetAtlas(defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetAtlas(defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.BackgroundFlash:SetAtlas(defaultTextures[class][k])
				ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetAtlas(defaultTextures[class][k])
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
	for k, v in pairs(defaultTextures[class]) do
		if k == GetSpecialization() then
			ClassTalentFrame.TalentsTab.Background:SetAtlas(defaultTextures[class][k])
			ClassTalentFrame.TalentsTab.OverlayBackgroundRight:SetAtlas(defaultTextures[class][k])
			ClassTalentFrame.TalentsTab.BackgroundFlash:SetAtlas(defaultTextures[class][k])
			ClassTalentFrame.TalentsTab.OverlayBackgroundMid:SetAtlas(defaultTextures[class][k])

			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = nil

			TalentArtPanel.Preview.tex:SetAtlas(defaultTextures[class][k])
		end
	end
end

SLASH_talentart1 = "/talentart";
SlashCmdList["talentart"] = function()
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then
		print("bingus here")
	else
		TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = talentTextures.backgroundTester
	end
end


talentArt:SetScript("OnEvent", talentArt.eventDelay)
talentArt.Events:SetScript("OnEvent", talentArt.login)
EventRegistry:RegisterCallback('TalentFrame.TalentTab.Show', talentArt.doStuff)
EventRegistry:RegisterCallback('TalentFrame.OpenFrame', talentArt.doStuff)

TalentArtPanel.menu = {
	{ text = "Select an Option", isTitle = true},
	{ text = "Option 1",
		func = function()
			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = talentTextures.backgroundTester
			TalentArtPanel.Preview.tex:SetTexture(talentTextures.backgroundTester.background)
		end
	},
	{ text = "Default",
		func = function()
			TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] = talentTextures.backgroundTester
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
TalentArtPanel.ArtButton:SetScript("OnClick", function() EasyMenu(TalentArtPanel.menu, TalentArtPanel.menuFrame, "TalentArtMenuArtButton", 0 , 0, "MENU", 10) end)



--[[
for i, v in pairs(C_ClassTalents.GetConfigIDsBySpecID()) do
	local k = C_Traits.GetConfigInfo(v).name;
	print(k);
end
]]