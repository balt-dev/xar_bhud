function p.set_txt_size(wid)
    local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
    local CHAR_WIDTH = 0.012 / aspect
    ga_win_set_char_size(wid, CHAR_WIDTH, 0.024)
end

function p.get_ammo_y_min() return 0.01 end
function p.get_ammo_width() return 0.086 end
function p.get_ammo_height() return 0.086 end

function p.render_ammo(wid)
    local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
    local RAW_CHAR_WIDTH = 0.012
    local CHAR_WIDTH = RAW_CHAR_WIDTH / aspect
    ga_win_set_char_size(wid, CHAR_WIDTH, RAW_CHAR_WIDTH*2)

    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    local size = 0.08
    
    do
    	local w = ga_get_i("xar.player.cur_wep")
    	if w == 0 then w = 10 end
        local x_min = 0.9
        local x_max = 0.9 + size
        local y_min = 1 - (w * 0.085)
        local y_max = y_min + size
        x_min = x_min - 0.095
        x_max = x_max + 0.01
        y_min = y_min - 0.01
        y_max = y_max + 0.01

    	cquad_r(wid, x_min - 0.01, y_min, x_max - 0.01, y_max, std.vec(0, 0, 0), 0.4)
    end

    local i = 0

    for raw_num = 1, 10 do
        local num = raw_num
        if (num == 10) then num = 0 end

        i = i + 1
        if game_can_use.main(num) then
            local ammo_x_delta = 0.065
            local x_min = 0.9
            local x_max = 0.9 + size
            local y_min = 1 - (i * 0.085)
            local y_max = y_min + size

            local cur_wep = ga_get_i("xar.player.cur_wep")
            if ( (raw_num%10) == cur_wep) then
                x_min = x_min - 0.01
                x_max = x_max - 0.01
            end

            local ammo_var = "xar.player.gun" .. num .. ".ammo"
            local ammo     = ga_get_i(ammo_var)
            local ammo_max = game_wep_modes.get_ammo_max(num)

            quad2_r(
                wid, x_min, y_min, x_max, y_max, "ammo_gun" .. num, "ammo_gun" .. num .. "_grey",
                ammo / ammo_max
            )

            local col = col_green
            if     (ammo < ammo_max/4) then col = col_red
            elseif (ammo < ammo_max/2) then col = col_yellow
            else                            col = col_green
            end
            if ga_get_b("xar.hud.show_ammo") and (not game_genesis.enabled()) then
                win_hud.txt_col(wid, col)
            	local s = game_str.make_3_digit_big(ammo)
                text_r(wid,
                    x_min - (RAW_CHAR_WIDTH / 2 * #s),
                    (y_min + y_max) / 2 + 0.015 - RAW_CHAR_WIDTH,
                    s
                )
                win_hud.txt_col(wid, std.vec(0, 1, 1))
                local ms = game_str.make_3_digit_big(ammo_max)
                text_r(wid,
                    x_min - (RAW_CHAR_WIDTH / 2 * #ms),
                    (y_min + y_max) / 2 - 0.015 - RAW_CHAR_WIDTH,
                    ms
                )
                win_hud.txt_col(wid, std.vec(1, 1, 1))
                local s_raw = tostring(num)
                text_r(wid,
                    x_max - RAW_CHAR_WIDTH * #s_raw,
                    y_max - 0.025,
                    s_raw
                )
            end
        end
    end
end
