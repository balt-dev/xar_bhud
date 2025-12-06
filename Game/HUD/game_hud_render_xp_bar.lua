function p.render_xp_bar(wid)
    if game_genesis.enabled() then return end
    -- We're repurposing this to do all of the bars.

    local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
    local RAW_CHAR_WIDTH = 0.012
    local CHAR_WIDTH = RAW_CHAR_WIDTH / aspect
    ga_win_set_char_size(wid, CHAR_WIDTH, RAW_CHAR_WIDTH*2)

    -- XP bar
    if ga_get_b("xar.hud.show_experience") then
        local level = ga_get_i("xar.experience.level")
        local amount = ga_get_i("xar.experience.to_next_level")
        local total = ga_get_i("xar.experience.to_next_level_max")
        local progress = 1.0 - (amount / total)
        bar_c(wid, 0.05, 0.02, 0.95, 0.06, {0, 0, 0}, {0, 0.7, 0}, progress)
        quad_c(wid, 0, 0.02, 0.04, 0.06, "xp")
        win_hud.txt_col(wid, std.vec(1, 1, 1))
        text_c(wid, 0.05, 0.02, ("Level %d (%d / %d)"):format(level or 0, amount or 0, total or 0))
    end
    if ga_get_b("xar.hud.show_health") then
        local health = ga_get_i("xar.player.health.amount")
        local health_max = ga_get_i("xar.player.health.max")
        local frac = health / health_max
        quad_c(wid, 0+ 0.05, 0.07+0.03, 0.04+ 0.05, 0.11+0.03, "icon_health")
        bar_c(wid, 0.05+ 0.05, 0.07+0.03, 0.45, 0.1+0.03, {1, 0, 0, 1}, {0.2, 1, 0.2, 1}, math.min(frac, 1))
        win_hud.txt_col(wid, std.vec(0, 0, 0))
        text_c(wid, 0.05+ 0.05, 0.07+0.03, ("%d / %d"):format(health, health_max))
        frac = frac - 1
        local offset = 0.00125
        local first = true
        while frac > 0 do
            if first then
                bar_c(wid, 0.05+ 0.05, 0.1+0.03 + offset, 0.45, 0.11+0.03 + offset, nil, {0.4, 0.4, 1, 0.8}, math.min(frac, 1))
                offset = offset + 0.0125
                first = false
            else
                bar_c(wid, 0.05+ 0.05, 0.1+0.03 + offset, 0.45, 0.105+0.03 + offset, nil, {1, 0.1, 1, 0.6}, math.min(frac, 1))
                offset = offset + 0.0075
            end
            frac = frac - 1
        end
        -- Armor
        local armor = ga_get_i("xar.player.armor.amount")
        local armor_max = ga_get_i("xar.player.armor.max")
        local frac = armor / armor_max
        quad_c(wid, 0.96- 0.05, 0.07+0.03, 1- 0.05, 0.11+0.03, "icon_armor")
        bar_c(wid, 0.55, 0.07+0.03, 0.95- 0.05, 0.1+0.03, {0, 0, 0, 0.2}, {0.8, 0.8, 0.8, 1}, math.min(frac, 1))
        win_hud.txt_col(wid, std.vec(0.1, 0.1, 0.1))
        text_c(wid, 0.55, 0.07+0.03, ("%d / %d"):format(armor, armor_max))
        frac = frac - 1
        local offset = 0.00125
        local first = true
        while frac > 0 do
            if first then
                bar_c(wid, 0.55, 0.1+0.03 + offset, 0.95- 0.05, 0.11+0.03 + offset, nil, {0.6, 0.6, 1, 0.8}, math.min(frac, 1))
                offset = offset + 0.0125
                first = false
            else
                bar_c(wid, 0.55, 0.1+0.03 + offset, 0.95- 0.05, 0.105+0.03 + offset, nil, {1, 0.4, 1, 0.6}, math.min(frac, 1))
                offset = offset + 0.0075
            end
            frac = frac - 1
        end
        -- Shield
        local armor = ga_get_i("xar.player.shield.amount")
        local armor_max = ga_get_i("xar.player.shield.max")
        local frac = armor / armor_max
        quad_c(wid, 0.065, 0.07, 0.09, 0.095, "icon_shield")
        bar_c(wid, 0.1, 0.07, 0.9, 0.09, {0, 0, 0, 0.4}, {0.6, 0.6, 1, 1}, math.min(frac, 1))

        ga_win_set_char_size(wid, CHAR_WIDTH * 0.83333, RAW_CHAR_WIDTH * 2 * 0.83333)
        win_hud.txt_col(wid, std.vec(0.1, 0.1, 0.1))
        text_c(wid, 0.1, 0.07, ("%d / %d"):format(armor, armor_max))
    end
    -- Hive attack
    local hive_frac = game_ment_hive_attack.get_frac()
    local progress = game_ment_hive_attack.get_frac()
    bar_c(wid, 0.05, 0.01, 0.95, 0.02, {1, 0, 0, 1}, {0, 1, 0, 1}, math.min(progress, 1))
end
