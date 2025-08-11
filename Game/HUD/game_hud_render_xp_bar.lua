function p.render_xp_bar(wid)
    if game_genesis.enabled() then return end
    -- We're repurposing this to do all of the bars.

    -- XP bar
    if ga_get_b("xar.hud.show_experience") then
        local amount = ga_get_i("xar.experience.to_next_level")
        local total = ga_get_i("xar.experience.to_next_level_max")
        local progress = 1.0 - (amount / total)
        bar_c(wid, 0.025, 0.025, 0.95, 0.05, 0, 0, 0, 1, 0, 1, 0, 1, progress)
    end
end
