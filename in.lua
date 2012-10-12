--[[
    Usage: /in 5 /say hi
    License: DO WHATEVER YOU WANT WITH IT
]]

local Timer = LibStub and LibStub('AceTimer-3.0')
if not Timer then return end

local editbox = CreateFrame('Editbox', 'SlashInEditBox')
editbox:Hide()
local eb = DEFAULT_CHAT_FRAME.editBox

local function execute(line)
    editbox:SetAttribute('chatType', eb:GetAttribute('chatType'))
    editbox:SetAttribute('tellTarget', eb:GetAttribute('tellTarget'))
    editbox:SetAttribute('channelTarget', eb:GetAttribute('channelTarget'))
    editbox:SetText(line)
    ChatEdit_SendText(editbox)
end

local function err(value, msg)
    if not value then
        print(msg)
        return true
    end
end

local function cmd(msg)
    local seconds, command, args = strsplit(' ', msg, 3)
    seconds = tonumber(seconds)

    if err(seconds, 'Error, bad arguments to /in. Must be in the form of "/in 5 /say hi"') or
        err(not IsSecureCmd(command), ('Error, /in cannot call secure command: %s'):format(command)) then
        return
    end

    Timer:ScheduleTimer(execute, seconds, strjoin(' ', command, args))
end


SLASH_IN1 = '/in'
SlashCmdList.IN = cmd



