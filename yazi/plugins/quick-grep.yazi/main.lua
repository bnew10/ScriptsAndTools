local hovered = ya.sync(function()
	local h = cx.active.current.hovered
	if not h then
		return {}
	end

	return {
		url = h.url,
	}
end)

local state = ya.sync(function()
	return cx.active.current.cwd
end)

local function fail(s, ...)
	ya.notify({ title = "quick-grep", content = string.format(s, ...), timeout = 5, level = "error" })
end

local function entry()
	local _permit = ya.hide()
	local cwd = tostring(state())

	local quickGrep, qgerr = Command("quick-grep"):cwd(cwd):stdout(Command.PIPED):spawn()

	local output, err =
		Command("awk"):args({ "-F", ":", "{ print $1 }" }):stdin(quickGrep:take_stdout()):stdout(Command.PIPED):output()

	if not quickGrep then
		return fail("Failed to start `quick-grep`, error: " .. qgerr)
	end

	if not output then
		return fail("Cannot read `quick-grep` output, error: " .. err)
	elseif not output.status.success and output.status.code ~= 130 then
		return fail(output.stderr)
	end

	local target = output.stdout:gsub("\n$", "")
	if target ~= "" then
		ya.manager_emit("reveal", { target })
		while true do
			local h = hovered()
			if h.url then
				ya.manager_emit("open", { h.url })
				break
			end
		end
	end
end

return { entry = entry }
