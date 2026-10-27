-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 theprinceofbucket
-- ClassQoL Talent Warning for WoW WotLK 3.3.5a (Interface 30300).
-- It is intentionally client-only: no server traffic, saved variables,
-- polling, or external libraries.

local Addon = {}

local TOOLTIP_TEXT = GetLocale() == "deDE"
    and "ClassQoL: Wird serverseitig auf maximalem Rang gewährt."
    or "ClassQoL: Granted by the server at maximum rank."
local MAX_TALENT_BUTTONS = 40

-- { Talent.dbc ID, talent-tab page (1-3), tier, column }.
-- The index is built once at load time. Coordinates make the add-on independent
-- of the localized client talent names and rank text.
local TALENT_COORDINATES = {
    [1] = { -- Warrior
        { 158, 2, 1, 2 }, { 161, 2, 2, 2 }, { 154, 2, 3, 4 },
    },
    [2] = { -- Paladin
        { 1450, 1, 4, 1 }, { 1446, 1, 4, 3 },
        { 1422, 2, 4, 3 }, { 2200, 2, 10, 3 },
        { 1401, 3, 2, 3 }, { 1756, 3, 5, 3 }, { 1758, 3, 7, 3 }, { 2148, 3, 9, 1 },
    },
    [3] = { -- Hunter
        { 1382, 1, 1, 2 }, { 1800, 1, 7, 1 },
        { 1361, 2, 7, 2 }, { 1343, 2, 2, 2 },
        { 2144, 3, 10, 3 },
    },
    [4] = { -- Rogue
        { 1715, 1, 9, 1 }, { 2074, 2, 9, 3 },
    },
    [5] = { -- Priest
        { 344, 1, 2, 3 }, { 346, 1, 2, 2 },
    },
    [6] = { -- Death Knight
        { 2105, 1, 6, 3 }, { 1936, 1, 7, 3 },
        { 2029, 2, 7, 3 }, { 2223, 2, 6, 1 }, { 1971, 2, 4, 4 },
        { 2013, 3, 7, 3 },
    },
    [7] = { -- Shaman
        { 610, 2, 1, 1 }, { 1647, 2, 5, 1 }, { 1689, 2, 6, 1 },
        { 588, 3, 4, 2 },
    },
    [8] = { -- Mage
        { 1727, 1, 7, 1 }, { 25, 2, 4, 1 }, { 63, 3, 3, 3 },
    },
    [9] = { -- Warlock
        { 1221, 2, 1, 1 }, { 944, 3, 1, 2 },
    },
    [11] = { -- Druid (10 is unused in the WoW class-ID table)
        { 782, 1, 3, 1 }, { 821, 3, 1, 1 },
    },
}

-- WotLK UnitClass returns the localized name and the class token, not an ID.
local CLASS_IDS = {
    WARRIOR = 1, PALADIN = 2, HUNTER = 3, ROGUE = 4, PRIEST = 5,
    DEATHKNIGHT = 6, SHAMAN = 7, MAGE = 8, WARLOCK = 9, DRUID = 11,
}
local _, classToken = UnitClass("player")
local playerClassId = CLASS_IDS[classToken]

local markedTalent = {}
for classId, entries in pairs(TALENT_COORDINATES) do
    markedTalent[classId] = {}
    for _, entry in ipairs(entries) do
        local _, tab, tier, column = entry[1], entry[2], entry[3], entry[4]
        markedTalent[classId][tab] = markedTalent[classId][tab] or {}
        markedTalent[classId][tab][tier] = markedTalent[classId][tab][tier] or {}
        markedTalent[classId][tab][tier][column] = true
    end
end

local function IsMarkedTalent(tab, tier, column)
    local byClass = markedTalent[playerClassId]
    local byTab = byClass and byClass[tab]
    local byTier = byTab and byTab[tier]
    return byTier and byTier[column] or false
end

local function SetBorder(button, visible)
    local border = button.ClassQoLTalentWarningBorder
    if not border and visible then
        -- Four solid edges, created only once for buttons that need a border.
        border = {}
        for i = 1, 4 do
            local edge = button:CreateTexture(nil, "OVERLAY")
            edge:SetTexture(1, 0.1, 0.1, 1)
            border[i] = edge
        end
        border[1]:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
        border[1]:SetPoint("TOPRIGHT", button, "TOPRIGHT", 1, 1)
        border[1]:SetHeight(2)
        border[2]:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", -1, -1)
        border[2]:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
        border[2]:SetHeight(2)
        border[3]:SetPoint("TOPLEFT", button, "TOPLEFT", -1, 1)
        border[3]:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", -1, -1)
        border[3]:SetWidth(2)
        border[4]:SetPoint("TOPRIGHT", button, "TOPRIGHT", 1, 1)
        border[4]:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 1, -1)
        border[4]:SetWidth(2)
        button.ClassQoLTalentWarningBorder = border
    end
    if border then
        for i = 1, 4 do
            if visible then border[i]:Show() else border[i]:Hide() end
        end
    end
end

function Addon:UpdateTalentFrame(frame)
    if not frame or frame ~= _G.PlayerTalentFrame then
        return
    end

    local tab = PanelTemplates_GetSelectedTab(frame)
    local ownTalents = not frame.inspect and not frame.pet and tab and tab >= 1 and tab <= 3
    local count = ownTalents and (GetNumTalents(tab, false, false) or 0) or 0
    local frameName = frame:GetName()
    for index = 1, MAX_TALENT_BUTTONS do
        local button = _G[frameName .. "Talent" .. index]
        if button then
            local visible = false
            if index <= count and button:IsShown() then
                local _, _, tier, column = GetTalentInfo(tab, index, frame.inspect, frame.pet, frame.talentGroup)
                visible = tier and IsMarkedTalent(tab, tier, column) or false
            end
            SetBorder(button, visible)
        end
    end
end

function Addon:AppendTooltip(tooltip, tab, index, inspect, pet, talentGroup)
    local frame = _G.PlayerTalentFrame
    if inspect or pet or not tab or not index or not frame or frame.pet or frame.inspect
        or not frame:IsShown() or tab < 1 or tab > 3
        or not tooltip:IsOwned(_G["PlayerTalentFrameTalent" .. index]) then
        return
    end

    local _, _, tier, column = GetTalentInfo(tab, index, inspect, pet, talentGroup)
    if tier and IsMarkedTalent(tab, tier, column) then
        tooltip:AddLine(TOOLTIP_TEXT, 1.0, 0.15, 0.15, true)
        tooltip:Show()
    end
end

local hooksInstalled = false
function Addon:InstallHooks()
    if hooksInstalled then return true end
    if not _G.PlayerTalentFrame or type(TalentFrame_Update) ~= "function" then return false end

    hooksecurefunc("TalentFrame_Update", function(frame)
        Addon:UpdateTalentFrame(frame)
    end)
    hooksecurefunc(GameTooltip, "SetTalent", function(tooltip, tab, index, inspect, pet, talentGroup)
        Addon:AppendTooltip(tooltip, tab, index, inspect, pet, talentGroup)
    end)
    hooksInstalled = true

    if PlayerTalentFrame:IsShown() then
        self:UpdateTalentFrame(PlayerTalentFrame)
    end
    return true
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, loadedAddon)
    if event == "PLAYER_LOGIN" or loadedAddon == "Blizzard_TalentUI" then
        if Addon:InstallHooks() then self:UnregisterAllEvents() end
    end
end)
