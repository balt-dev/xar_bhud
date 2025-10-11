function quad_l(wid, left, bottom, right, top, tex)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = left / aspect
	right = right / aspect
	ga_win_quad(wid, left, bottom, right, top, tex)
end

function quad_r(wid, left, bottom, right, top, tex)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = 1 - ((1 - left) / aspect)
	right = 1 - ((1 - right) / aspect)
	ga_win_quad(wid, left, bottom, right, top, tex)
end

function cquad_r(wid, left, bottom, right, top, col, alpha)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = 1 - ((1 - left) / aspect)
	right = 1 - ((1 - right) / aspect)
	ga_win_quad_color_alpha(wid, left, bottom, right, top, col, alpha)
end

function quad_c(wid, left, bottom, right, top, tex)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
	right = ((1 - ((1 - right) / aspect)) + (right / aspect)) / 2
	ga_win_quad(wid, left, bottom, right, top, tex)
end

function bar_c(wid, left, bottom, right, top, bg, fg, progress, invert)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
	right = ((1 - ((1 - right) / aspect)) + (right / aspect)) / 2
	if invert then
		mid = right + (left - right) * progress
	else
		mid = left + (right - left) * progress
	end
	if bg and progress < 1 then
		local bg_r, bg_g, bg_b = table.unpack(bg)
		ga_win_quad_color_alpha(wid, mid, bottom, right, top, std.vec(bg_r, bg_g, bg_b), bg[4] or 1)
	end
	if fg and progress > 0 then
		local fg_r, fg_g, fg_b = table.unpack(fg)
		ga_win_quad_color_alpha(wid, left, bottom, mid, top, std.vec(fg_r, fg_g, fg_b), fg[4] or 1)
	end
end

function text_c(wid, left, bottom, text)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
    ga_win_txt(wid, left, bottom, text)
end

function quad2_l(wid, left, bottom, right, top, tex1, tex2, p)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = left / aspect
	right = right / aspect
	ga_win_quad_two(wid, left, bottom, right, top, tex1, tex2, p)
end

function quad2_r(wid, left, bottom, right, top, tex1, tex2, p)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = 1 - ((1 - left) / aspect)
	right = 1 - ((1 - right) / aspect)
	ga_win_quad_two(wid, left, bottom, right, top, tex1, tex2, p)
end

function quad2_c(wid, left, bottom, right, top, tex1, tex2, p)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
	right = ((1 - ((1 - right) / aspect)) + (right / aspect)) / 2
	ga_win_quad_two(wid, left, bottom, right, top, tex1, tex2, p)
end

function txt_r(wid, x, y, txt)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	x = 1 - ((1 - x) / aspect)
	ga_win_txt_center_at_bg(wid, x, y, txt)
end