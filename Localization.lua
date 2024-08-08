local TalentArt, L = ...; -- Let's use the private table passed to every .lua 

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Talent Frame Art"
	L["CurrentConfig"] = "Current Loadout: "
	L["NoConfig"] = "None / Starter Build"
return end

if LOCALE == "esES" or LOCALE == "esMX" then --
	-- Spanish translations go here

return end

if LOCALE == "deDE" then
	-- German translations go here

return end

if LOCALE == "frFR" then --
	-- French translations go here

return end

if LOCALE == "itIT" then
	-- Italian translations go here

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here


	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here

return end

if LOCALE == "koKR" then
	-- Korean translations go here

return end

if LOCALE == "zhCN" then --
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "天赋界面背景"
	L["CurrentConfig"] = "目前使用："
	L["NoConfig"] = "无 / 默认"
return end

if LOCALE == "zhTW" then --
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "天賦介面背景"
	L["CurrentConfig"] = "目前使用："
	L["NoConfig"] = "無 / 預設"
return end
