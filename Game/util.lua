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

function quad_c(wid, left, bottom, right, top, tex)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
	right = ((1 - ((1 - right) / aspect)) + (right / aspect)) / 2
	ga_win_quad(wid, left, bottom, right, top, tex)
end

function bar_c(wid, left, bottom, right, top, bg_r, bg_g, bg_b, bg_a, fg_r, fg_g, fg_b, fg_a, progress)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	left = ((1 - ((1 - left) / aspect)) + (left / aspect)) / 2
	right = ((1 - ((1 - right) / aspect)) + (right / aspect)) / 2
	mid = left + (right - left) * progress
	if progress < 1 then
		ga_win_quad_color_alpha(wid, mid, bottom, right, top, std.vec(bg_r, bg_b, bg_b), bg_a)
	end
	if progress > 0 then
		ga_win_quad_color_alpha(wid, left, bottom, mid, top, std.vec(fg_r, fg_b, fg_b), fg_a)
	end
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

local g = ga_win_set_char_size
function ga_win_set_char_size(wid, w, h)
	local aspect = ga_get_sys_f("display.camera_params.a_ratio.value")
	g(wid, w / aspect, h)
end