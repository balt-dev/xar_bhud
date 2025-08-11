local messages = {}

function p.get_messages()
    return messages
end

local t = 0

local function clean_old_messages()
    local retain = {}
    local l = #messages
    for i, message in ipairs(messages) do
        local msg, sent, fade = table.unpack(message)
        if sent + fade >= t then table.insert(retain, message) end
    end
    messages = retain
end

function p.get_timer()
    return t
end

function p.add(txt)
    table.insert(messages, {txt, t, 6.0})
end

function p.update()
    clean_old_messages()
    t = t + 0.04
end