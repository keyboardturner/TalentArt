local addonName, TalentArt = ...;

local L = TalentArt.L;

local defaultsTable = {
	Colors = {},
	Desaturation = {}
};

local defaultColors = {
	bg = { r = 1, g = 1, b = 1, a = 1 },
	right = { r = 1, g = 1, b = 1, a = 1 },
	--flash = { r = 1, g = 1, b = 1, a = 1 },
	--mid = { r = 1, g = 1, b = 1, a = 1 },
}

local TalentArtPanel = CreateFrame("Frame")
TalentArtPanel:RegisterEvent("ADDON_LOADED")
local talentArt = CreateFrame("Frame")

TalentArtPanel.Preview = CreateFrame("Frame", nil, TalentArtPanel)
TalentArtPanel.Preview:ClearAllPoints();
TalentArtPanel.Preview:SetPoint("TOPRIGHT", TalentArtPanel, "TOPRIGHT", -25, -50*2);
TalentArtPanel.Preview:SetSize(650, 325)

TalentArtPanel.Preview.bg = TalentArtPanel.Preview:CreateTexture(nil, "BACKGROUND", nil, -1)
TalentArtPanel.Preview.bg:SetAllPoints()
TalentArtPanel.Preview.bg:SetColorTexture(0.05, 0.05, 0.05, 1)

TalentArtPanel.Preview.tex = TalentArtPanel.Preview:CreateTexture(nil, "BACKGROUND", nil, 0)
TalentArtPanel.Preview.tex:SetAllPoints(TalentArtPanel.Preview)
if TalentArt and TalentArt.talentTextures and TalentArt.talentTextures.backgroundTester then
	TalentArtPanel.Preview.tex:SetTexture(TalentArt.talentTextures.backgroundTester.background)
end

TalentArtPanel.Preview.Right = CreateFrame("Frame", nil, TalentArtPanel.Preview)
TalentArtPanel.Preview.Right:SetAllPoints(TalentArtPanel.Preview)
TalentArtPanel.Preview.Right.texRight = TalentArtPanel.Preview.Right:CreateTexture(nil, "BACKGROUND", nil, 1)
TalentArtPanel.Preview.Right.texRight:SetPoint("TOPRIGHT")
TalentArtPanel.Preview.Right.texRight:SetPoint("BOTTOMRIGHT")
local scale = 810 / 1160
TalentArtPanel.Preview.Right.texRight:SetWidth(650 * scale)
TalentArtPanel.Preview.Right.texRight:SetTexCoord(1 - scale, 1, 0, 1)

TalentArtPanel.Preview.Right.mask = TalentArtPanel.Preview.Right:CreateMaskTexture()
TalentArtPanel.Preview.Right.mask:SetTexture("interface\\AddOns\\TalentArt\\Media\\talentsanimationsmaskspecart_notexcoord.png", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
TalentArtPanel.Preview.Right.mask:SetAllPoints(TalentArtPanel.Preview.Right.texRight)
TalentArtPanel.Preview.Right.texRight:AddMaskTexture(TalentArtPanel.Preview.Right.mask)

function talentArt.getCurrentKey()
	local configID = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())
	if configID ~= nil then
		return configID
	end
	return GetSpecializationInfo(GetSpecialization())
end

function talentArt.specChecker()
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) ~= nil then
		return false
	else
		local specID = GetSpecializationInfo(GetSpecialization())
		return specID
	end
end

function talentArt.GetCurrentColors()
	local key = talentArt.getCurrentKey()
	
	if TalentArt_DB and TalentArt_DB.Colors and TalentArt_DB.Colors[key] then
		local saved = TalentArt_DB.Colors[key]
		if saved.r then
			local converted = {
				bg = CopyTable(saved),
				right = CopyTable(saved),
				--flash = CopyTable(saved),
				--mid = CopyTable(saved)
			}
			TalentArt_DB.Colors[key] = converted
			return converted
		end
		return saved
	end
	
	return defaultColors
end

TalentArtPanel.Preview:SetScript("OnShow", function()
	local colors = talentArt.GetCurrentColors()
	local key = talentArt.getCurrentKey()
	local isDesat = TalentArt_DB and TalentArt_DB.Desaturation and TalentArt_DB.Desaturation[key] or false
	
	local bgC = colors.bg 
	local rightC = colors.right 
	
	if C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID()) == nil then
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. L["NoConfig"] )
	else
		TalentArtPanel.specName:SetText(L["CurrentConfig"] .. C_Traits.GetConfigInfo(C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())).name )
	end
	
	local atlasToSet, bgTexToSet, rightTexToSet
	
	if (TalentArt_DB == nil) or (TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())] == nil) then
		local class, classIndex = UnitClassBase("player")
		local specID = GetSpecializationInfo(GetSpecialization())

		if TalentArt_DB and TalentArt_DB[talentArt.specChecker(specID)] ~= nil and talentArt.specChecker() ~= false then
			local entry = TalentArt_DB[talentArt.specChecker(specID)]
			atlasToSet = entry.atlas
			bgTexToSet = entry.background
			rightTexToSet = entry.right
		else
			for k, v in pairs(TalentArt.defaultTextures[class]) do
				if k == GetSpecialization() then
					atlasToSet = v
				end
			end
		end
	else
		local entry = TalentArt_DB[C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())]
		atlasToSet = entry.atlas
		bgTexToSet = entry.background
		rightTexToSet = entry.right
	end

	if atlasToSet then
		TalentArtPanel.Preview.tex:SetAtlas(atlasToSet)
		TalentArtPanel.Preview.Right.texRight:SetAtlas(atlasToSet)
	else
		if bgTexToSet then TalentArtPanel.Preview.tex:SetTexture(bgTexToSet) end
		if rightTexToSet or bgTexToSet then TalentArtPanel.Preview.Right.texRight:SetTexture(rightTexToSet or bgTexToSet) end
	end
	
	TalentArtPanel.Preview.tex:SetVertexColor(bgC.r, bgC.g, bgC.b, bgC.a)
	TalentArtPanel.Preview.Right.texRight:SetVertexColor(rightC.r, rightC.g, rightC.b, rightC.a)
	
	TalentArtPanel.Preview.tex:SetDesaturated(isDesat)
	TalentArtPanel.Preview.Right.texRight:SetDesaturated(isDesat)
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

		local layers = {
			{ key = "bg", name = "Background Color" },
			{ key = "right", name = "Right Overlay Color", noAlpha = true }
		}

		TalentArtPanel.swatches = {}
		local startY = -85
		local initColors = talentArt.GetCurrentColors()

		for i, layerConfig in ipairs(layers) do
			local label = TalentArtPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
			label:SetPoint("TOPLEFT", 10, startY)
			label:SetText(layerConfig.name)

			local swatch = CreateFrame("Button", nil, TalentArtPanel.scrollChild, "ColorSwatchTemplate")
			swatch:SetPoint("LEFT", label, "RIGHT", 10, 0)
			swatch:RegisterForClicks("AnyUp")
			
			TalentArtPanel.swatches[layerConfig.key] = swatch
			
			local function ApplyColor(t)
				if not t then return end
				local a = layerConfig.noAlpha and 1 or t.a
				swatch.Color:SetVertexColor(t.r, t.g, t.b, a)
				
				if TalentArt_DB then
					TalentArt_DB.Colors = TalentArt_DB.Colors or {}
					local key = talentArt.getCurrentKey()
					
					if not TalentArt_DB.Colors[key] then
						TalentArt_DB.Colors[key] = CopyTable(defaultColors)
					end
					
					TalentArt_DB.Colors[key][layerConfig.key] = { r = t.r, g = t.g, b = t.b, a = a }
				end
				
				if layerConfig.key == "bg" then
					TalentArtPanel.Preview.tex:SetVertexColor(t.r, t.g, t.b, a)
				elseif layerConfig.key == "right" then
					TalentArtPanel.Preview.Right.texRight:SetVertexColor(t.r, t.g, t.b, a)
				end
				
				talentArt.eventDelay()
			end

			local initLayerColor = initColors[layerConfig.key] or defaultColors[layerConfig.key]
			swatch.Color:SetVertexColor(initLayerColor.r, initLayerColor.g, initLayerColor.b, initLayerColor.a)

			swatch:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(layerConfig.name)
				GameTooltip:AddLine("Left Click: Open color picker", 1, 1, 1)
				GameTooltip:AddLine("Right Click: Open dropdown", 1, 1, 1)
				GameTooltip:Show()
			end)
			swatch:SetScript("OnLeave", GameTooltip_Hide)

			swatch:SetScript("OnClick", function(_, button)
				if button == "RightButton" then
					MenuUtil.CreateContextMenu(swatch, function(owner, rootDescription)
						rootDescription:CreateTitle("Color Options")

						rootDescription:CreateButton("Copy Color", function()
							local currentColors = talentArt.GetCurrentColors()
							talentArt.ColorClipboard = CopyTable(currentColors[layerConfig.key])
						end)

						local pasteBtn = rootDescription:CreateButton("Paste Color", function()
							if not talentArt.ColorClipboard then return end
							ApplyColor(CopyTable(talentArt.ColorClipboard))
						end)
						if not talentArt.ColorClipboard then pasteBtn:SetEnabled(false) end

						rootDescription:CreateButton(RESET_TO_DEFAULT, function()
							ApplyColor({ r = 1, g = 1, b = 1, a = 1 })
						end)
					end)
					return
				end

				local currentColors = talentArt.GetCurrentColors()
				local current = currentColors[layerConfig.key]
				local info = {
					r = current.r, g = current.g, b = current.b, opacity = current.a,
					hasOpacity = not layerConfig.noAlpha,
					swatchFunc = function()
						local r, g, b = ColorPickerFrame:GetColorRGB()
						local a = layerConfig.noAlpha and 1 or ColorPickerFrame:GetColorAlpha()
						ApplyColor({ r = r, g = g, b = b, a = a })
					end,
					cancelFunc = function()
						local r, g, b, a = ColorPickerFrame:GetPreviousValues()
						ApplyColor({ r = r, g = g, b = b, a = layerConfig.noAlpha and 1 or a })
					end
				}
				ColorPickerFrame:SetupColorPickerAndShow(info)
			end)

			startY = startY - 30
		end

		local desatLabel = TalentArtPanel.scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
		desatLabel:SetPoint("TOPLEFT", 10, startY - 5)
		desatLabel:SetText("Desaturate Art")

		local desatCheckbox = CreateFrame("CheckButton", nil, TalentArtPanel.scrollChild, "UICheckButtonTemplate")
		desatCheckbox:SetPoint("LEFT", desatLabel, "RIGHT", 10, 0)
		
		desatCheckbox:SetScript("OnShow", function(self)
			local key = talentArt.getCurrentKey()
			local isDesat = TalentArt_DB and TalentArt_DB.Desaturation and TalentArt_DB.Desaturation[key] or false
			self:SetChecked(isDesat)
		end)

		desatCheckbox:SetScript("OnClick", function(self)
			local key = talentArt.getCurrentKey()
			local isChecked = self:GetChecked()
			
			if TalentArt_DB then
				TalentArt_DB.Desaturation = TalentArt_DB.Desaturation or {}
				TalentArt_DB.Desaturation[key] = isChecked
			end
			
			TalentArtPanel.Preview.tex:SetDesaturated(isChecked)
			TalentArtPanel.Preview.Right.texRight:SetDesaturated(isChecked)
			talentArt.eventDelay()
		end)

	end
end

TalentArtPanel:SetScript("OnEvent", TalentArtPanel.InitializeOptions)


talentArt:RegisterEvent("TRAIT_CONFIG_UPDATED")
talentArt:RegisterEvent("PLAYER_TALENT_UPDATE")
talentArt.Events = CreateFrame("Frame")
talentArt.Events:RegisterEvent("ADDON_LOADED")

local function applyFrameEntry(entry)
	local colors = talentArt.GetCurrentColors()
	local key = talentArt.getCurrentKey()
	local isDesat = TalentArt_DB and TalentArt_DB.Desaturation and TalentArt_DB.Desaturation[key] or false
	
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

	PlayerSpellsFrame.TalentsFrame.Background:SetVertexColor(colors.bg.r, colors.bg.g, colors.bg.b, colors.bg.a)
	PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)
	--PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetVertexColor(colors.flash.r, colors.flash.g, colors.flash.b, colors.flash.a)
	PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)

	PlayerSpellsFrame.TalentsFrame.Background:SetDesaturated(isDesat)
	PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetDesaturated(isDesat)
	PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetDesaturated(isDesat)
	PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetDesaturated(isDesat)
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
	local class, classIndex = UnitClassBase("player")
	local colors = talentArt.GetCurrentColors()
	local key = talentArt.getCurrentKey()
	local isDesat = TalentArt_DB and TalentArt_DB.Desaturation and TalentArt_DB.Desaturation[key] or false

	--print("DEBUG talent build ID: " .. (bingus or "nil"))
	if TalentArtPanel.swatches then
		for k, swatch in pairs(TalentArtPanel.swatches) do
			if colors[k] then
				swatch.Color:SetVertexColor(colors[k].r, colors[k].g, colors[k].b, colors[k].a)
			end
		end
	end

	if ((TalentArt_DB == nil) or (TalentArt_DB[bingus] == nil)) and talentArt.specChecker() == false then
		--(TalentArt_DB[specID] ~= nil)
		for k, v in pairs(TalentArt.defaultTextures[class]) do
			if k == GetSpecialization() then
				--print("DEBUG class 1: " .. class)
				--print("DEBUG texture 1: " .. TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.Background:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetAtlas(TalentArt.defaultTextures[class][k])
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetAtlas(TalentArt.defaultTextures[class][k])

				PlayerSpellsFrame.TalentsFrame.Background:SetVertexColor(colors.bg.r, colors.bg.g, colors.bg.b, colors.bg.a)
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)
				--PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetVertexColor(colors.flash.r, colors.flash.g, colors.flash.b, colors.flash.a)
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)
				
				PlayerSpellsFrame.TalentsFrame.Background:SetDesaturated(isDesat)
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetDesaturated(isDesat)
				PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetDesaturated(isDesat)
				PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetDesaturated(isDesat)
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

					PlayerSpellsFrame.TalentsFrame.Background:SetVertexColor(colors.bg.r, colors.bg.g, colors.bg.b, colors.bg.a)
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)
					--PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetVertexColor(colors.flash.r, colors.flash.g, colors.flash.b, colors.flash.a)
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetVertexColor(colors.right.r, colors.right.g, colors.right.b)
					
					PlayerSpellsFrame.TalentsFrame.Background:SetDesaturated(isDesat)
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundRight:SetDesaturated(isDesat)
					PlayerSpellsFrame.TalentsFrame.BackgroundFlash:SetDesaturated(isDesat)
					PlayerSpellsFrame.TalentsFrame.OverlayBackgroundMid:SetDesaturated(isDesat)
				end
			end
		end
		if bingus ~= nil then
			--print("DEBUG class 3: " .. class)
			applyFrameEntry(TalentArt_DB[bingus])
		end
	end
end

function talentArt:login(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "TalentArt" then
		if not TalentArt_DB then
			TalentArt_DB = defaultsTable;
		end
		--TalentArtPanel.ArtButton:SetText(L["DropdownButtonText"])
		if not TalentArt_DB.Colors then
			TalentArt_DB.Colors = {}
		end
		if not TalentArt_DB.Desaturation then
			TalentArt_DB.Desaturation = {}
		end
	end
end

function talentArt.eventDelay() --the config ID is not updated at this point yet until the very next frame after
	RunNextFrame(talentArt.doStuff)
end


function talentArt.resetBackground()
	local class, classIndex = UnitClassBase("player")
	local specIndex = GetSpecialization()
	local key = talentArt.getCurrentKey()

	if TalentArt_DB then
		TalentArt_DB[key] = nil
		if TalentArt_DB.Colors then
			TalentArt_DB.Colors[key] = nil
		end
		if TalentArt_DB.Desaturation then
			TalentArt_DB.Desaturation[key] = nil
		end
	end

	local configID = C_ClassTalents.GetLastSelectedSavedConfigID(PlayerUtil.GetCurrentSpecID())
	if configID then
		TalentArt_DB[configID] = nil
	end
	
	if talentArt.specChecker() ~= false then
		TalentArt_DB[talentArt.specChecker()] = nil
	end

	if TalentArt.defaultTextures[class] and TalentArt.defaultTextures[class][specIndex] then
		TalentArtPanel.Preview.tex:SetAtlas(TalentArt.defaultTextures[class][specIndex])
		TalentArtPanel.Preview.Right.texRight:SetAtlas(TalentArt.defaultTextures[class][specIndex])
		TalentArtPanel.Preview.tex:SetVertexColor(1, 1, 1, 1)
		TalentArtPanel.Preview.Right.texRight:SetVertexColor(1, 1, 1, 1)
		TalentArtPanel.Preview.tex:SetDesaturated(false)
		TalentArtPanel.Preview.Right.texRight:SetDesaturated(false)
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

local function isEntrySelected(entry)
	local key = talentArt.getCurrentKey()
	if not key then return false end
	return TalentArt_DB ~= nil and TalentArt_DB[key] == entry
end

local function applyEntry(entry)
	local key = talentArt.getCurrentKey()
	if not key then return end
	TalentArt_DB[key] = entry
	local colors = talentArt.GetCurrentColors()
	local isDesat = TalentArt_DB.Desaturation and TalentArt_DB.Desaturation[key] or false
	
	if entry.atlas then
		TalentArtPanel.Preview.tex:SetAtlas(entry.atlas)
		TalentArtPanel.Preview.Right.texRight:SetAtlas(entry.atlas)
	else
		TalentArtPanel.Preview.tex:SetTexture(entry.background)
		TalentArtPanel.Preview.Right.texRight:SetTexture(entry.right or entry.background)
	end
	TalentArtPanel.Preview.tex:SetVertexColor(colors.bg.r, colors.bg.g, colors.bg.b, colors.bg.a)
	TalentArtPanel.Preview.Right.texRight:SetVertexColor(colors.right.r, colors.right.g, colors.right.b, colors.right.a)
	TalentArtPanel.Preview.tex:SetDesaturated(isDesat)
	TalentArtPanel.Preview.Right.texRight:SetDesaturated(isDesat)
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