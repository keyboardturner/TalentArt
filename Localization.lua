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

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte del marco de talentos"
	L["CurrentConfig"] = "Configuración actual: "
	L["NoConfig"] = "Ninguno / Construcción inicial"
return end

if LOCALE == "deDE" then
	-- German translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Talentfenster-Kunst"
	L["CurrentConfig"] = "Aktuelle Konfiguration: "
	L["NoConfig"] = "Keine / Starter-Build"
return end

if LOCALE == "frFR" then --
	-- French translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Art de la fenêtre des talents"
	L["CurrentConfig"] = "Configuration actuelle : "
	L["NoConfig"] = "Aucune / Build de départ"
return end

if LOCALE == "itIT" then
	-- Italian translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte della finestra dei talenti"
	L["CurrentConfig"] = "Configurazione attuale: "
	L["NoConfig"] = "Nessuna / Configurazione iniziale"
return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte da Janela de Talentos"
	L["CurrentConfig"] = "Configuração Atual: "
	L["NoConfig"] = "Nenhuma / Construção Inicial"

	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Искусство окна талантов"
	L["CurrentConfig"] = "Текущая конфигурация: "
	L["NoConfig"] = "Нет / Начальная сборка"
return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "특성 창 배경"
	L["CurrentConfig"] = "현재 설정: "
	L["NoConfig"] = "없음 / 시작 빌드"
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
