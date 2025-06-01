local function info(content)
	return ya.notify({
		title = "Diff",
		content = content,
		timeout = 5,
	})
end

local selected_url = ya.sync(function()
	for _, u in pairs(cx.active.selected) do
		return u
	end
end)

local yanked_url = ya.sync(function()
	for _, url in pairs(cx.yanked) do
		return url
	end
end)

local hovered_url = ya.sync(function()
	local h = cx.active.current.hovered
	return h and h.url
end)

return {
	entry = function()
		local a, b = yanked_url(), hovered_url()
		if not a then
			return info("No file yanked")
		elseif not b then
			return info("No file hovered")
		end

		local _permit = ya.hide()

		Command("nv")
				:arg("-d")
				:arg(tostring(a))
				:arg(tostring(b))
				:stdin(Command.INHERIT)
				:stdout(Command.INHERIT)
				:stderr(Command.INHERIT)
				:status()
	end,
}
