local addonName, TalentArt = ...;

local L = {};

TalentArt.L = L;

local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(L, {__index=defaultFunc});

local LOCALE = GetLocale()

-- all locales
L["DeathKnight"] = select(1, GetClassInfo(6))
L["Spec_Blood"] = select(2, GetSpecializationInfoByID(250))
L["Spec_FrostDK"] = select(2, GetSpecializationInfoByID(251))
L["Spec_Unholy"] = select(2, GetSpecializationInfoByID(252))
L["DemonHunter"] = select(1, GetClassInfo(12))
L["Spec_Havoc"] = select(2, GetSpecializationInfoByID(577))
L["Spec_Vengeance"] = select(2, GetSpecializationInfoByID(581))
L["Druid"] = select(1, GetClassInfo(11))
L["Spec_Balance"] = select(2, GetSpecializationInfoByID(102))
L["Spec_Feral"] = select(2, GetSpecializationInfoByID(103))
L["Spec_Guardian"] = select(2, GetSpecializationInfoByID(104))
L["Spec_RestoDruid"] = select(2, GetSpecializationInfoByID(105))
L["Evoker"] = select(1, GetClassInfo(13))
L["Spec_Devastation"] = select(2, GetSpecializationInfoByID(1467))
L["Spec_Preservation"] = select(2, GetSpecializationInfoByID(1468))
L["Spec_Augmentation"] = select(2, GetSpecializationInfoByID(1473))
L["Hunter"] = select(1, GetClassInfo(3))
L["Spec_BM"] = select(2, GetSpecializationInfoByID(253))
L["Spec_MM"] = select(2, GetSpecializationInfoByID(254))
L["Spec_SV"] = select(2, GetSpecializationInfoByID(255))
L["Mage"] = select(1, GetClassInfo(8))
L["Spec_Arcane"] = select(2, GetSpecializationInfoByID(62))
L["Spec_Fire"] = select(2, GetSpecializationInfoByID(63))
L["Spec_FrostMage"] = select(2, GetSpecializationInfoByID(64))
L["Monk"] = select(1, GetClassInfo(10))
L["Spec_Brewmaster"] = select(2, GetSpecializationInfoByID(268))
L["Spec_Mistweaver"] = select(2, GetSpecializationInfoByID(270))
L["Spec_Windwalker"] = select(2, GetSpecializationInfoByID(269))
L["Paladin"] = select(1, GetClassInfo(2))
L["Spec_HolyPaladin"] = select(2, GetSpecializationInfoByID(65))
L["Spec_ProtectionPaladin"] = select(2, GetSpecializationInfoByID(66))
L["Spec_Retribution"] = select(2, GetSpecializationInfoByID(70))
L["Priest"] = select(1, GetClassInfo(5))
L["Spec_Discipline"] = select(2, GetSpecializationInfoByID(256))
L["Spec_HolyPriest"] = select(2, GetSpecializationInfoByID(257))
L["Spec_Shadow"] = select(2, GetSpecializationInfoByID(258))
L["Rogue"] = select(1, GetClassInfo(4))
L["Spec_Assassination"] = select(2, GetSpecializationInfoByID(259))
L["Spec_Outlaw"] = select(2, GetSpecializationInfoByID(260))
L["Spec_Subtlety"] = select(2, GetSpecializationInfoByID(261))
L["Shaman"] = select(1, GetClassInfo(7))
L["Spec_Elemental"] = select(2, GetSpecializationInfoByID(262))
L["Spec_Enhancement"] = select(2, GetSpecializationInfoByID(263))
L["Spec_RestoShaman"] = select(2, GetSpecializationInfoByID(264))
L["Warlock"] = select(1, GetClassInfo(9))
L["Spec_Affliction"] = select(2, GetSpecializationInfoByID(265))
L["Spec_Demonology"] = select(2, GetSpecializationInfoByID(266))
L["Spec_Destruction"] = select(2, GetSpecializationInfoByID(267))
L["Warrior"] = select(1, GetClassInfo(1))
L["Spec_Arms"] = select(2, GetSpecializationInfoByID(71))
L["Spec_Fury"] = select(2, GetSpecializationInfoByID(72))
L["Spec_ProtectionWarrior"] = select(2, GetSpecializationInfoByID(73))
L["Spec_Cunning"] = select(2, GetSpecializationInfoByID(79))
L["Spec_Ferocity"] = select(2, GetSpecializationInfoByID(74))
L["Spec_Tenacity"] = select(2, GetSpecializationInfoByID(81))

if LOCALE == "enUS" then
	-- The EU English game client also
	-- uses the US English locale code.
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Talent Frame Art"
	L["CurrentConfig"] = "Current Loadout: "
	L["NoConfig"] = "None / Starter Build"
	L["SpecWide"] = "Spec-Wide"
	L["DesaturateArt"] = "Desaturate Art"
	L["ApplySpecWide"] = "Apply Art Spec-Wide (Ignore Loadout)"
	L["ArtSelect"] = "Art Selection"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Background Color"
	L["RightOverlayColor"] = "Right Overlay Color"

	L["LC_OpenColorPicker"] = "Left-Click: Open Color Picker"
	L["RC_OpenDropdown"] = "Right-Click: Additional Settings"
	L["ColorOptions"] = "Color Options"
	L["CopyColor"] = "Copy Color"
	L["PasteColor"] = "Paste Color"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Blizzard Website"
	L["LegionMountsArtiffacts"] = "Legion Artifacts & Mounts"
	L["BlizzDefaults"] = "Blizzard Defaults"

return end

if LOCALE == "esES" or LOCALE == "esMX" then
	-- Spanish translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte del marco de talentos"
	L["CurrentConfig"] = "Configuración actual: "
	L["NoConfig"] = "Ninguno / Construcción inicial"
	L["SpecWide"] = "A nivel de especialización"
	L["DesaturateArt"] = "Desaturar arte"
	L["ApplySpecWide"] = "Aplicar arte a toda la especialización (ignorar configuración)"
	L["ArtSelect"] = "Selección de arte"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Color de fondo"
	L["RightOverlayColor"] = "Color de superposición derecha"

	L["LC_OpenColorPicker"] = "Clic izquierdo: Abrir selector de color"
	L["RC_OpenDropdown"] = "Clic derecho: Configuración adicional"
	L["ColorOptions"] = "Opciones de color"
	L["CopyColor"] = "Copiar color"
	L["PasteColor"] = "Pegar color"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Sitio web de Blizzard"
	L["LegionMountsArtiffacts"] = "Artefactos y monturas de Legion"
	L["BlizzDefaults"] = "Valores predeterminados de Blizzard"

return end

if LOCALE == "deDE" then
	-- German translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Talentfenster-Kunst"
	L["CurrentConfig"] = "Aktuelle Konfiguration: "
	L["NoConfig"] = "Keine / Starter-Build"
	L["SpecWide"] = "Spezialisierungsweit"
	L["DesaturateArt"] = "Grafik entsättigen"
	L["ApplySpecWide"] = "Grafik spezialisierungsweit anwenden (Ausrüstung ignorieren)"
	L["ArtSelect"] = "Grafikauswahl"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Hintergrundfarbe"
	L["RightOverlayColor"] = "Farbe der rechten Überlagerung"

	L["LC_OpenColorPicker"] = "Links-Klick: Farbwähler öffnen"
	L["RC_OpenDropdown"] = "Rechts-Klick: Zusätzliche Einstellungen"
	L["ColorOptions"] = "Farboptionen"
	L["CopyColor"] = "Farbe kopieren"
	L["PasteColor"] = "Farbe einfügen"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Blizzard-Website"
	L["LegionMountsArtiffacts"] = "Legion-Artefakte & Reittiere"
	L["BlizzDefaults"] = "Blizzard-Standardwerte"

return end

if LOCALE == "frFR" then --
	-- French translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Art de la fenêtre des talents"
	L["CurrentConfig"] = "Configuration actuelle : "
	L["NoConfig"] = "Aucune / Build de départ"
	L["SpecWide"] = "À l’échelle de la spécialisation"
	L["DesaturateArt"] = "Désaturer l’illustration"
	L["ApplySpecWide"] = "Appliquer l’illustration à toute la spécialisation (ignorer l’équipement)"
	L["ArtSelect"] = "Sélection d’illustration"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Couleur d’arrière-plan"
	L["RightOverlayColor"] = "Couleur de superposition droite"

	L["LC_OpenColorPicker"] = "Clic gauche : Ouvrir le sélecteur de couleur"
	L["RC_OpenDropdown"] = "Clic droit : Paramètres supplémentaires"
	L["ColorOptions"] = "Options de couleur"
	L["CopyColor"] = "Copier la couleur"
	L["PasteColor"] = "Coller la couleur"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Site web Blizzard"
	L["LegionMountsArtiffacts"] = "Artéfacts et montures de Legion"
	L["BlizzDefaults"] = "Paramètres par défaut de Blizzard"

return end

if LOCALE == "itIT" then
	-- Italian translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte della finestra dei talenti"
	L["CurrentConfig"] = "Configurazione attuale: "
	L["NoConfig"] = "Nessuna / Configurazione iniziale"
	L["SpecWide"] = "A livello di specializzazione"
	L["DesaturateArt"] = "Desatura grafica"
	L["ApplySpecWide"] = "Applica grafica a tutta la specializzazione (ignora configurazione)"
	L["ArtSelect"] = "Selezione grafica"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Colore di sfondo"
	L["RightOverlayColor"] = "Colore sovrapposizione destra"

	L["LC_OpenColorPicker"] = "Clic sinistro: Apri selettore colore"
	L["RC_OpenDropdown"] = "Clic destro: Impostazioni aggiuntive"
	L["ColorOptions"] = "Opzioni colore"
	L["CopyColor"] = "Copia colore"
	L["PasteColor"] = "Incolla colore"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Sito web Blizzard"
	L["LegionMountsArtiffacts"] = "Artefatti e cavalcature di Legion"
	L["BlizzDefaults"] = "Impostazioni predefinite Blizzard"

return end

if LOCALE == "ptBR" then
	-- Brazilian Portuguese translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Arte da Janela de Talentos"
	L["CurrentConfig"] = "Configuração Atual: "
	L["NoConfig"] = "Nenhuma / Construção Inicial"
	L["SpecWide"] = "Para toda a especialização"
	L["DesaturateArt"] = "Dessaturar arte"
	L["ApplySpecWide"] = "Aplicar arte para toda a especialização (ignorar configuração)"
	L["ArtSelect"] = "Seleção de arte"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Cor de fundo"
	L["RightOverlayColor"] = "Cor da sobreposição direita"

	L["LC_OpenColorPicker"] = "Clique esquerdo: Abrir seletor de cores"
	L["RC_OpenDropdown"] = "Clique direito: Configurações adicionais"
	L["ColorOptions"] = "Opções de cor"
	L["CopyColor"] = "Copiar cor"
	L["PasteColor"] = "Colar cor"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Site da Blizzard"
	L["LegionMountsArtiffacts"] = "Artefatos e montarias de Legion"
	L["BlizzDefaults"] = "Padrões da Blizzard"

	-- Note that the EU Portuguese WoW client also
	-- uses the Brazilian Portuguese locale code.
return end

if LOCALE == "ruRU" then
	-- Russian translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "Искусство окна талантов"
	L["CurrentConfig"] = "Текущая конфигурация: "
	L["NoConfig"] = "Нет / Начальная сборка"
	L["SpecWide"] = "Для всей специализации"
	L["DesaturateArt"] = "Обесцветить графику"
	L["ApplySpecWide"] = "Применить графику для всей специализации (игнорировать набор)"
	L["ArtSelect"] = "Выбор графики"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "Цвет фона"
	L["RightOverlayColor"] = "Цвет правого наложения"

	L["LC_OpenColorPicker"] = "ЛКМ: Открыть палитру цветов"
	L["RC_OpenDropdown"] = "ПКМ: Дополнительные настройки"
	L["ColorOptions"] = "Параметры цвета"
	L["CopyColor"] = "Копировать цвет"
	L["PasteColor"] = "Вставить цвет"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "Сайт Blizzard"
	L["LegionMountsArtiffacts"] = "Артефакты и средства передвижения Legion"
	L["BlizzDefaults"] = "Настройки Blizzard по умолчанию"

return end

if LOCALE == "koKR" then
	-- Korean translations go here
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "특성 창 배경"
	L["CurrentConfig"] = "현재 설정: "
	L["NoConfig"] = "없음 / 시작 빌드"
	L["SpecWide"] = "전문화 전체"
	L["DesaturateArt"] = "아트 채도 감소"
	L["ApplySpecWide"] = "전문화 전체에 아트 적용 (구성 무시)"
	L["ArtSelect"] = "아트 선택"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "배경 색상"
	L["RightOverlayColor"] = "오른쪽 오버레이 색상"

	L["LC_OpenColorPicker"] = "좌클릭: 색상 선택기 열기"
	L["RC_OpenDropdown"] = "우클릭: 추가 설정"
	L["ColorOptions"] = "색상 옵션"
	L["CopyColor"] = "색상 복사"
	L["PasteColor"] = "색상 붙여넣기"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "블리자드 웹사이트"
	L["LegionMountsArtiffacts"] = "군단 유물 및 탈것"
	L["BlizzDefaults"] = "블리자드 기본값"

return end

if LOCALE == "zhCN" then --
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "天赋界面背景"
	L["CurrentConfig"] = "目前使用："
	L["NoConfig"] = "无 / 默认"
	L["SpecWide"] = "专精范围"
	L["DesaturateArt"] = "降低美术饱和度"
	L["ApplySpecWide"] = "应用于整个专精（忽略配置）"
	L["ArtSelect"] = "美术选择"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "背景颜色"
	L["RightOverlayColor"] = "右侧叠加颜色"

	L["LC_OpenColorPicker"] = "左键：打开颜色选择器"
	L["RC_OpenDropdown"] = "右键：更多设置"
	L["ColorOptions"] = "颜色选项"
	L["CopyColor"] = "复制颜色"
	L["PasteColor"] = "粘贴颜色"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "暴雪官方网站"
	L["LegionMountsArtiffacts"] = "军团神器与坐骑"
	L["BlizzDefaults"] = "暴雪默认设置"

return end

if LOCALE == "zhTW" then --
	L["Name"] = "TalentArt"
	L["DropdownButtonText"] = "天賦介面背景"
	L["CurrentConfig"] = "目前使用："
	L["NoConfig"] = "無 / 預設"
	L["SpecWide"] = "專精範圍"
	L["DesaturateArt"] = "降低美術飽和度"
	L["ApplySpecWide"] = "套用至整個專精（忽略配置）"
	L["ArtSelect"] = "美術選擇"
	L["ResetToDefault"] = RESET_TO_DEFAULT
	L["Custom"] = CUSTOM
	L["BackgroundColor"] = "背景顏色"
	L["RightOverlayColor"] = "右側疊加顏色"

	L["LC_OpenColorPicker"] = "左鍵：開啟顏色選擇器"
	L["RC_OpenDropdown"] = "右鍵：其他設定"
	L["ColorOptions"] = "顏色選項"
	L["CopyColor"] = "複製顏色"
	L["PasteColor"] = "貼上顏色"

	L["Classic"] = EXPANSION_NAME0
	L["ArtifactPower"] = ARTIFACT_POWER
	L["BlizzWebsite"] = "暴雪官方網站"
	L["LegionMountsArtiffacts"] = "軍臨天下神器與坐騎"
	L["BlizzDefaults"] = "暴雪預設值"

return end
