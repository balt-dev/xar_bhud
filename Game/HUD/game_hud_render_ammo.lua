function p.set_txt_size(wid)
    ga_win_set_char_size(wid, 0.012, 0.024)
end

function p.get_ammo_y_min() return 0.01 end
function p.get_ammo_width() return 0.086 end
function p.get_ammo_height() return 0.086 end

function p.render_ammo(wid)
    ga_win_set_char_size(wid, 0.012, 0.024)

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

    	cquad_r(wid, x_min - 0.03, y_min, x_max - 0.03, y_max, std.vec(0, 0, 0), 0.4)
    end

    for raw_num = 1, 10 do
        local num = raw_num
        if (num == 10) then num = 0 end

        local ammo_x_delta = 0.065
        local x_min = 0.9
        local x_max = 0.9 + size
        local y_min = 1 - (raw_num * 0.085)
        local y_max = y_min + size

        local cur_wep = ga_get_i("xar.player.cur_wep")
        if ( (raw_num%10) == cur_wep) then
            x_min = x_min - 0.03
            x_max = x_max - 0.03
        end

        local ammo_var = "xar.player.gun" .. num .. ".ammo"
        local ammo     = ga_get_i(ammo_var)
        local ammo_max = game_wep_modes.get_ammo_max(num)

        quad_r(wid, x_min, y_min, x_max, y_max, (ammo_max ~= 0 and "ammo_gun" .. num) or ("ammo_gun" .. num .. "_grey"))

        local col = col_green
        if     (ammo < ammo_max/4) then col = col_red
        elseif (ammo < ammo_max/2) then col = col_yellow
        else                            col = col_green
        end
        if ga_get_b("xar.hud.show_ammo") and (not game_genesis.enabled()) then
            win_hud.txt_col(wid, col)
            txt_r(wid, 
                x_min - 0.5 * size,
                (y_min + y_max) / 2,
                game_str.make_3_digit_big(ammo)
            )
        end
    end
end
