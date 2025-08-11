local Y_CLIP = 0.7

function p.render_icons(wid)
    if not ga_get_b("xar.hud.show_icons") then return end

    -- Icons.
    local icon_size = 0.1
    local step = icon_size + 0.01

    local cur_x = 0.01
    local cur_y = 0.01
    local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")

    local function draw_icon(tex, right)
        q = (right and quad_r) or quad_l
        if cur_y + step >= Y_CLIP then
            cur_y = 0.01
            cur_x = cur_x + step
        end
        q(wid, cur_x, cur_y, cur_x+icon_size, cur_y+icon_size, tex)
        cur_y = cur_y + step
    end
    local function draw_labelled_icon(tex, label, right)
        q = (right and quad_r) or quad_l
        if cur_y + step >= Y_CLIP then
            cur_y = 0.01
            cur_x = cur_x + step
        end
        q(wid, cur_x, cur_y, cur_x+icon_size, cur_y+icon_size, tex)
        local tx = cur_x + 0.5 * icon_size
        tx = (right and (1 - ((1 - tx) / aspect))) or (tx / aspect)
        ga_win_set_char_size(wid, 0.012, 0.024)
        ga_win_txt_center_at_bg(wid, 
            tx,
            cur_y + icon_size - 0.012,
            label
        )
        cur_y = cur_y + step
    end

    local col_red  = std.vec(1.0, 0.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    if ga_get_sys_b("game.state.saving_in_progress") then
        draw_icon "icon_save"
    end

    --Chunk database icon.
    local db_icon = ""
    local db_dirs = ga_get_sys_s("game.save.chunk_db.dirs")
    if( db_dirs == "db_1"       ) then db_icon = "icon_db_1" end
    if( db_dirs == "db_2"       ) then
        --Not showing the db2 icon because it is implied.
        -- db_icon = "icon_db_2"
        db_icon = ""
    end
    if( db_dirs == "db_1_and_2" ) then db_icon = "icon_db_1_and_2" end
    -- if( db_dirs == "db_2"       ) then db_icon = "" end --Put this back in eventually!
    if db_icon ~= "" then
        draw_icon(db_icon)
    end

    --Hardcore modifier.
    if ga_get_hardcore_mode() then
        draw_icon "icon_hardcore"
    end

    --Pacifist modifier.
    if game_kill_count.is_trying_to_be_pacifist() then
        local kill_count = game_kill_count.get_kill_count()
        local num_str = game_str.make_3_digit_big(kill_count)
        local col = col_red
        if( game_kill_count.is_pacifist() ) then col = col_green end
        win_hud.txt_col(wid, col)
        draw_labelled_icon("icon_pacifist", num_str)
        draw_icon "icon_pacifist"
    end

    --Game difficulty new way).
    -- ga_print("win_hud: pondering about difficulty...")
    if ga_get_b("xar.difficulty.custom") then
        --Using a customm difficulty.
        draw_icon "icon_custom"
    else
        local diff_num = game_difficulty.num()
        local e_diff_num = game_difficulty.easiest_num()
        -- ga_print("win_hud: diff_num = " .. tostring(diff_num))
        -- ga_print("win_hud: e_diff_num = " .. tostring(e_diff_num))
        if( diff_num == e_diff_num ) then
            --Only need to show the current difficult.
            local icon_name = game_difficulty.icon(diff_num)
            if( icon_name ~= "" ) then
                if not game_genesis.enabled() then
                    draw_icon(icon_name)
                end
            end
        else
            --Need to show an icon from the easiest difficulty (in grey)
            --and the current difficulty.
            draw_icon(game_difficulty.icon_once(e_diff_num))
            --
            local icon_name = game_difficulty.icon(diff_num)
            if( icon_name ~= "" ) then
                if not game_genesis.enabled() then
                    draw_icon(icon_name)
                end
            end
        end
    end

    if ga_get_b("xar.movement.rocket") then
        draw_icon "icon_rocket"
    end

    if ga_get_b("xar.movement.brake") then
        draw_icon "icon_brake"
    end    

    if ga_exists("xar.key_time.yellow") then
        local key_time = ga_get_f("xar.key_time.yellow")
        if (key_time > 0.0) then
            draw_labelled_icon("key_yellow", math.floor(key_time))
        end
    end
    
    if ga_exists("xar.key_time.blue") then
        local key_time = ga_get_f("xar.key_time.blue")
        if (key_time > 0.0) then
            draw_labelled_icon("key_yellow", math.floor(key_time))
        end
    end

    if ga_exists("xar.key_time.green") then
        local key_time = ga_get_f("xar.key_time.green")
        if (key_time > 0.0) then
            draw_labelled_icon("key_green", math.floor(key_time))
        end
    end

    if ga_exists("xar.key_time.universe") then
        local key_time = ga_get_f("xar.key_time.universe")
        if (key_time > 0.0) then
            draw_labelled_icon("ent_credits", math.floor(key_time))
        end
    end

    if ga_exists("xar.key_time.laser_genesis") then
        local key_time = ga_get_f("xar.key_time.laser_genesis")
        if (key_time > 0.0) then
            draw_labelled_icon("key_laser_genesis", math.floor(key_time))
        end
    end

    if ga_exists("xar.key_time.dans_house") then
        local key_time = ga_get_f("xar.key_time.dans_house")
        if (key_time > 0.0) then
            draw_labelled_icon("key_dans_house", math.floor(key_time))
        end
    end

    if ga_exists("xar.xp_5x_stacking_time") then
        local xp_time = ga_get_f("xar.xp_5x_stacking_time")
        if (xp_time > 0.0) then
            draw_labelled_icon("icon_xp_5x", math.floor(xp_time))
        end
    end

    if ga_exists("xar.damage_5x_stacking_time") then
        local xp_time = ga_get_f("xar.damage_5x_stacking_time")
        if (xp_time > 0.0) then
            draw_labelled_icon("icon_damage_5x", math.floor(xp_time))
        end
    end

    local invun_time = ga_get_f("xar.invun_stacking_time")
    if( invun_time > 0.0 ) then
        draw_labelled_icon("icon_invun", math.floor(invun_time))
    end

    --Tracking marker (beacon).
    game_tracking_marker.refresh_attack_display()
    if game_tracking_marker.exists_and_enabled() then
        local dist = game_tracking_marker.get_dist()
        local dist_str = game_str.make_3_digit_big(dist)
        draw_labelled_icon("icon_beacon", dist_str)
    end

    if ga_exists("xar.emp_end_time") then
        local emp_end_time = ga_get_f("xar.emp_end_time")
        local game_time = ga_get_game_time()
        if( emp_end_time > game_time ) then
            local diff = math.floor(emp_end_time - game_time)
            local emp_text_col = game_ment_emp.get_hud_emp_icon_text_color()
            win_hud.txt_col(wid, emp_text_col)
            draw_labelled_icon("ammo_gun8", diff)
        end
    end

    if ga_get_b("xar.player.arcade.inside") then
        draw_icon "icon_arcade"
    end

    local game_time                 = ga_get_game_time()
    local quasar_drive_end_time     = ga_get_f("xar.player.gun0.quasar_drive_end")
    local black_hole_drive_end_time = ga_get_f("xar.player.gun0.black_hole_drive_end")
    if( game_time < quasar_drive_end_time ) then
        local diff = math.floor(quasar_drive_end_time - game_time)
        draw_labelled_icon("icon_quasar_drive", diff)
    elseif( game_time < black_hole_drive_end_time ) then
        local diff = math.floor(black_hole_drive_end_time - game_time)
        draw_labelled_icon("ammo_gun0", diff)
    end
end
