--[[
Hello, and thank you for downloading my addon! I hope you like it! :)
]]--

--[[------------------------------------------------------------------------------------------------------------------]]--

--Spec Selection
local TalentArt = CreateFrame("Frame")
local SpecTexture = TalentArt:CreateTexture()
TalentArt:RegisterEvent("ADDON_LOADED")
TalentArt:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
TalentArt:RegisterEvent("PLAYER_LOGIN")


TalentArt:SetScript("OnEvent", function(self, event, ...)
	SpecTexture:SetPoint("CENTER", PlayerTalentFrameSpecialization, "CENTER", 105, 5)
	SpecTexture:SetSize(420, 420)
	SpecTexture:SetDrawLayer("ARTWORK", 0)
	SpecTexture:SetParent(PlayerTalentFrameSpecialization)
	
	--[[ElvUI support;
	For some reason, it doesn't like to anchor to the spec frame by itself and requires extra touches.
	]]--
	
	if IsAddOnLoaded("ElvUI") then
			SpecTexture:SetPoint("CENTER", PlayerTalentFrameSpecialization, "CENTER", 1, -5) -- This is the anchor
			SpecTexture:SetSize(643, 470) --If there's a better method, I want to know. SetAllPoints is not good enough either.
			SpecTexture:SetParent(PlayerTalentFrameSpecialization) -- This is required for it to pop up. Is not an anchor
			SpecTexture:SetDrawLayer("BACKGROUND", 0) -- This HAS to be here or it doesn't work. DO NOT CHANGE. (I think)
	end
	
	--Aurora Support
	if IsAddOnLoaded("Aurora") then
			SpecTexture:SetPoint("CENTER", PlayerTalentFrameSpecialization, "CENTER", 1, -1)
			SpecTexture:SetSize(645, 467)
			SpecTexture:SetParent(PlayerTalentFrameSpecialization)
			SpecTexture:SetDrawLayer("BACKGROUND", 0)
	end
	
	--Skinner Support
	if IsAddOnLoaded("Skinner") then
			SpecTexture:SetPoint("CENTER", PlayerTalentFrameSpecialization, "CENTER", 0, -3)
			SpecTexture:SetSize(641, 467)
			SpecTexture:SetParent(PlayerTalentFrameSpecialization)
			SpecTexture:SetDrawLayer("BACKGROUND", 0)
	end

	--Demon Hunter
	if select(3, UnitClass("player")) == 12 and select(1, GetSpecializationInfo(GetSpecialization())) == 577 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DHHavoc.blp")
	elseif select(3, UnitClass("player")) == 12 and select(1, GetSpecializationInfo(GetSpecialization())) == 581 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DHVeng.blp")
		
	--Death Knight
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 250 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DKBlood.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 251 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DKFrost.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 252 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DKUnholy.blp")
	
	--Druid
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 102 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DruidBalance.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 103 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DruidFeral.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 104 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DruidGuardian.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 105 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\DruidResto.blp")
		
	--Hunter
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 253 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterBestiality.blp") -- ;)
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 254 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterMM.blp")
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 255 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterSV.blp")
		
	--Mage
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 62 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MageArcane.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 63 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MageFire.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 64 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MageFrost.blp")	
		
	--Monk
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 268 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MonkBM.blp")	
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 270 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MonkMW.blp")	
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 269 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\MonkWW.blp")	
		
	--Paladin
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 65 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PaladinHoly.blp")	
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 66 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PaladinProt.blp")	
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 70 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PaladinRet.blp")	
		
	--Priest
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 256 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PriestDisc.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 257 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PriestHoly.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 258 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\PriestVoid.blp")	
		
	--Rogue
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 259 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\RogueAss.blp") -- ( °͜ʖ°)
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 260 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\RogueOutlaw.blp")
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 261 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\RogueSub.blp")
		
	--Shaman
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 262 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\ShamanEle.blp")
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 263 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\ShamanEnh.blp")
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 264 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\ShamanResto.blp")
		
	--Warlock
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 265 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarlockAff.blp")
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 266 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarlockDemo.blp")
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 267 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarlockDest.blp")
		
	--Warrior
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 71 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarriorArms.blp")
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 72 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarriorFury.blp")
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 73 then
		SpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\WarriorProt.blp")
	end
end)

--[[------------------------------------------------------------------------------------------------------------------]]--

	--Hunter Pet Spec	
--[[
GetPetTalentTree() returns the information your pet WAS in by default when you tamed them.
This function really should be changed, since it's useless.
If you use GetSpecialization(false, true), it will return a number.
1 = ferocity
2 = tenacity
3 = cunning
]]--

-- PlayerTalentFramePetSpecializationSpellScrollFrameChildSpecName --
local PetTalentArt = CreateFrame("Frame")
local PetSpecTexture = PetTalentArt:CreateTexture()
PetTalentArt:RegisterEvent("ADDON_LOADED")
PetTalentArt:RegisterEvent("UNIT_PET")
PetTalentArt:RegisterEvent("PET_SPECIALIZATION_CHANGED")
PetTalentArt:RegisterEvent("PLAYER_LOGIN")



PetTalentArt:SetScript("OnEvent", function(self, event, ...)
	PetSpecTexture:SetPoint("CENTER", PlayerTalentFramePetSpecialization, "CENTER", 105, 5)
	PetSpecTexture:SetSize(420, 420)
	PetSpecTexture:SetDrawLayer("ARTWORK", 0)
	PetSpecTexture:SetParent(PlayerTalentFramePetSpecialization)
	
		--ElvUI Support
	if IsAddOnLoaded("ElvUI") then
		PetSpecTexture:SetPoint("CENTER", PlayerTalentFramePetSpecialization, "CENTER", 1, -4)
		PetSpecTexture:SetSize(644, 471)
		PetSpecTexture:SetDrawLayer("ARTWORK", 0)
		PetSpecTexture:SetParent(PlayerTalentFramePetSpecialization)
	end
	
	--Aurora Support
	if IsAddOnLoaded("Aurora") then
		PetSpecTexture:SetPoint("CENTER", PlayerTalentFramePetSpecialization, "CENTER", 1, -1)
		PetSpecTexture:SetSize(644, 467)
		PetSpecTexture:SetDrawLayer("ARTWORK", 0)
		PetSpecTexture:SetParent(PlayerTalentFramePetSpecialization)
	end

	--Skinner Support
	if IsAddOnLoaded("Skinner") then
		PetSpecTexture:SetPoint("CENTER", PlayerTalentFramePetSpecialization, "CENTER", 0, -3)
		PetSpecTexture:SetSize(642, 467)
		PetSpecTexture:SetDrawLayer("ARTWORK", 0)
		PetSpecTexture:SetParent(PlayerTalentFramePetSpecialization)
	end
		
	
	if GetSpecialization(false, true) == 1 then
		PetSpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterPetFerocity.blp")
	elseif GetSpecialization(false, true) == 2 then
		PetSpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterPetTen.blp")
	elseif GetSpecialization(false, true) == 3 then
		PetSpecTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\SpecFrame\\HunterPetCunt.blp") --lol please don't ban me
	end
end)

--[[------------------------------------------------------------------------------------------------------------------]]--

--Talent Selection
local SelectArt = CreateFrame("Frame")
local TalentTexture = SelectArt:CreateTexture()
SelectArt:RegisterEvent("ADDON_LOADED")
SelectArt:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
SelectArt:RegisterEvent("PLAYER_LOGIN")

SelectArt:SetScript("OnEvent", function(self, event, ...)
	TalentTexture:SetPoint("CENTER", PlayerTalentFrameTalents, "CENTER", 0, 0)
	TalentTexture:SetSize(625, 375)
	TalentTexture:SetDrawLayer("ARTWORK", 0)
	TalentTexture:SetParent(PlayerTalentFrameTalents)
	
	--ElvUI support
	if IsAddOnLoaded("ElvUI") then
		TalentTexture:SetPoint("CENTER", PlayerTalentFrameTalents, "CENTER", 1, 14)
		TalentTexture:SetSize(645, 473)
	end
	
	--Aurora support
	if IsAddOnLoaded("Aurora") then
		TalentTexture:SetPoint("CENTER", PlayerTalentFrameTalents, "CENTER", 1, 17)
		TalentTexture:SetSize(644, 467)
	end
	
	--Skinner support
	if IsAddOnLoaded("Skinner") then
		TalentTexture:SetPoint("CENTER", PlayerTalentFrameTalents, "CENTER", 0, 15)
		TalentTexture:SetSize(642, 467)
	end
	
	--Demon Hunter
	if select(3, UnitClass("player")) == "Demon Hunter" and select(1, GetSpecializationInfo(GetSpecialization())) == 577 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\HavocDH.blp")
	elseif select(3, UnitClass("player")) == "Demon Hunter" and select(1, GetSpecializationInfo(GetSpecialization())) == 581 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\VengDH.blp")
		
	--Death Knight
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 250 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\BloodDK.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 251 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\FrostDK.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 252 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\UnholyDK.blp")
	
	--Druid
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 102 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\BalanceDruid.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 103 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\FeralDruid.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 104 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\GuardianDruid.blp")
	elseif select(3, UnitClass("player")) == 11 and select(1, GetSpecializationInfo(GetSpecialization())) == 105 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\RestoDruid.blp")
		
	--Hunter
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 253 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\BMHunter.blp")
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 254 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\MMHunter.blp")
	elseif select(3, UnitClass("player")) == 3 and select(1, GetSpecializationInfo(GetSpecialization())) == 255 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\SVHunter.blp")
		
	--Mage
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 62 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\ArcaneMage.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 63 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\FireMage.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 64 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\FrostMage.blp")	
		
	--Monk
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 268 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\BMMonk.blp")	
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 270 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\MWMonk.blp")	
	elseif select(3, UnitClass("player")) == 10 and select(1, GetSpecializationInfo(GetSpecialization())) == 269 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\WWMonk.blp")	
		
	--Paladin
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 65 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\HolyPally.blp")	
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 66 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\ProtPally.blp")	
	elseif select(3, UnitClass("player")) == 2 and select(1, GetSpecializationInfo(GetSpecialization())) == 70 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\RetPally.blp")	
		
	--Priest
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 256 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\DiscPriest.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 257 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\HolyPriest.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 258 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\ShadowPriest.blp")	
		
	--Rogue
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 259 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\AssRogue.blp") -- ( °͜ʖ°)
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 260 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\OutlawRogue.blp")
	elseif select(3, UnitClass("player")) == 4 and select(1, GetSpecializationInfo(GetSpecialization())) == 261 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\SubRogue.blp")
		
	--Shaman
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 262 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\EleShaman.blp")
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 263 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\EnhShaman.blp")
	elseif select(3, UnitClass("player")) == 7 and select(1, GetSpecializationInfo(GetSpecialization())) == 264 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\RestoShaman.blp")
		
	--Warlock
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 265 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\AfflictionWarlock.blp")
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 266 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\DemoWarlock.blp")
	elseif select(3, UnitClass("player")) == 9 and select(1, GetSpecializationInfo(GetSpecialization())) == 267 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\DestroWarlock.blp")
		
	--Warrior
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 71 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\ArmsWarrior.blp")
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 72 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\FuryWarrior.blp")
	elseif select(3, UnitClass("player")) == 1 and select(1, GetSpecializationInfo(GetSpecialization())) == 73 then
		TalentTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\TalentFrame\\ProtWarrior.blp")
	end
end)

--[[------------------------------------------------------------------------------------------------------------------]]--

--PvP Talent Selection
local PvPArt = CreateFrame("Frame")
local PvPTexture = PvPArt:CreateTexture()
PvPArt:RegisterEvent("ADDON_LOADED")
PvPArt:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
PvPArt:RegisterEvent("PLAYER_LOGIN")

PvPArt:SetScript("OnEvent", function(self, event, ...)
	PvPTexture:SetPoint("CENTER", PlayerTalentFramePVPTalents, "CENTER", 0, 0)
	PvPTexture:SetSize(625, 325)
	PvPTexture:SetDrawLayer("ARTWORK", 0)
	PvPTexture:SetParent(PlayerTalentFramePVPTalents)
	
	--ElvUI Support
	if IsAddOnLoaded("ElvUI") then
		PvPTexture:SetPoint("CENTER", PlayerTalentFramePVPTalents, "CENTER", 1, 39)
		PvPTexture:SetSize(645, 473)
	end
	
	--Aurora Support
	if IsAddOnLoaded("Aurora") then
		PvPTexture:SetPoint("CENTER", PlayerTalentFramePVPTalents, "CENTER", 1, 42)
		PvPTexture:SetSize(644, 467)
	end
	
	--Skinner Support
	if IsAddOnLoaded("Skinner") then
		PvPTexture:SetPoint("CENTER", PlayerTalentFramePVPTalents, "CENTER", 0, 39)
		PvPTexture:SetSize(642, 469)
	end
	
	
	--Demon Hunter
	if select(3, UnitClass("player")) == "Demon Hunter" then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIDemonHunter.blp")
		
	--Death Knight
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 250 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIDeathKnightBlood.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 251 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIDeathKnightFrost.blp")
	elseif select(3, UnitClass("player")) == 6 and select(1, GetSpecializationInfo(GetSpecialization())) == 252 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIDeathKnightUnholy.blp")
	
	--Druid
	elseif select(3, UnitClass("player")) == 11 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIDruid.blp")
		
	--Hunter
	elseif select(3, UnitClass("player")) == 3 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIHunter.blp")
		
	--Mage
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 62 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIMageArcane.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 63 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIMageFire.blp")
	elseif select(3, UnitClass("player")) == 8 and select(1, GetSpecializationInfo(GetSpecialization())) == 64 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIMageFrost.blp")	
		
	--Monk
	elseif select(3, UnitClass("player")) == 10 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIMonk.blp")
		
	--Paladin
	elseif select(3, UnitClass("player")) == 2 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIPaladin.blp")
		
	--Priest
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 256 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIPriest.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 257 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIPriest.blp")	
	elseif select(3, UnitClass("player")) == 5 and select(1, GetSpecializationInfo(GetSpecialization())) == 258 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIPriestShadow.blp")	
		
	--Rogue
	elseif select(3, UnitClass("player")) == 4 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIRogue.blp")
		
	--Shaman
	elseif select(3, UnitClass("player")) == 7 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIShaman.blp")
		
	--Warlock
	elseif select(3, UnitClass("player")) == 9 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIWarlock.blp")
		
	--Warrior
	elseif select(3, UnitClass("player")) == 1 then
		PvPTexture:SetTexture("Interface\\AddOns\\TalentArt\\Media\\PvPFrame\\ArtifactUIWarrior.blp")
	end
end)






--[[
I would like to thank everyone who helped me create this addon.
I've been hoping to do something like this for so long.
]]--

		
--[[elseif select(3, UnitClass("player")) == "CLASS" and select(1, GetSpecializationInfo(GetSpecialization())) == "SPECNAME" then
		SpecTexture:SetTexture("texturepath")
	elseif select(3, UnitClass("player")) == "CLASS" and select(1, GetSpecializationInfo(GetSpecialization())) == "SPECNAME" then
		SpecTexture:SetTexture("texturepath")
	elseif select(3, UnitClass("player")) == "CLASS" and select(1, GetSpecializationInfo(GetSpecialization())) == "SPECNAME" then
		SpecTexture:SetTexture("texturepath")]]--
