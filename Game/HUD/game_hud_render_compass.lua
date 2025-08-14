function p.render_compass(wid)
    -- Compass (top middle of the screen).
    local camera_look = ga_get_sys_v("game.player.camera.look")
    local dir_str = ""
    local cutoff = 3.1415926 / 8.0
    if( std.angle_between_vec(camera_look, std.vec(1.0, 0.0, 0.0)) < cutoff ) then
        dir_str = "+X / RIGHT"
    end
    if( std.angle_between_vec(camera_look, std.vec(-1.0, 0.0, 0.0)) < cutoff ) then
        dir_str = "-X / LEFT"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 1.0, 0.0)) < cutoff ) then
        dir_str = "+Y / FRONT"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, -1.0, 0.0)) < cutoff ) then
        dir_str = "-Y / BACK"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 0.0, 1.0)) < cutoff ) then
        dir_str = "+Z / UP"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 0.0, -1.0)) < cutoff ) then
        dir_str = "-Z / DOWN"
    end
    local pitch = math.asin(-camera_look.z) * 180 / 3.1415926
    local yaw = math.atan2(camera_look.x, camera_look.y) * 180 / 3.1415926
    ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.02, 0.03)
    ga_win_txt_center(wid, 0.96, ("%.2f pitch, %.2f yaw"):format(pitch, yaw))
    if dir_str ~= "" then
        ga_win_txt_center(wid, 0.92, dir_str)
    end
end
