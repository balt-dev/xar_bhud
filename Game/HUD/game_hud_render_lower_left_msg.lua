function p.render_lower_left_msg(wid)
    local t = game_msg.get_timer()
    --Lower left message.
    if( ga_get_b("xar.hud.msg.disable_msgs") ) then return end

    local col_white  = std.vec(1.0, 1.0, 1.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    ga_win_set_char_size(wid, 0.015, 0.03)
    win_hud.txt_col(wid, col_green)
    local messages = game_msg.get_messages()
    for i, _ in ipairs(messages) do
        local pos = #messages - i + 1
        tmsg = messages[i]
        local msg = ""
        local ttl = 0.0
        if( ga_get_sys_b("game.input.quick_cmd.entering") and pos == 1 ) then
            msg = "/" .. ga_get_sys_s("game.input.quick_cmd.partial")
            ttl = 10.0 --Ok.
        else
            msg = tmsg[1]
            ttl = 6.0 - (game_msg.get_timer() - tmsg[2])
        end
        --
        local col = col_white
        if ttl < 4.0 then col = col_green end
        if( ttl > 4.0 and ttl < 5.0 ) then
            col = win_hud.interp_col(col_green,col_white,ttl-4.0)
        end
        win_hud.txt_col(wid, col)
        --
        local min_x = 0.01
        local min_y = 0.01 + 0.033*(pos-1)
        local alpha_fade = 1.0
        if( ttl < 1.0 and ttl >= 0.0 ) then alpha_fade = ttl end
        if ttl > 0.0 then
            local color = std.vec(0.0,0.0,0.0)
            local back_alpha = 0.4 * alpha_fade
            local front_alpha = 1.0 * alpha_fade
            ga_win_set_back_params(wid, color, back_alpha, back_alpha)
            ga_win_txt_alpha_bg(wid, min_x, min_y, front_alpha, msg)
        end
    end
end
