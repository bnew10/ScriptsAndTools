local state = ya.sync(function()
	return cx.active.current.cwd
end)

local function fail(s, ...)
	ya.notify({ title = "git-toplevel", content = string.format(s, ...), timeout = 5, level = "error" })
end

local function entry()
	local cwd = tostring(state())

	local child, err = Command("git")
		:cwd(cwd)
		:arg({ "rev-parse", "--show-toplevel" })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		return fail("Failed to start `git-toplevel`, error: " .. err)
	end

	local output, err = child:wait_with_output()
	if not output then
		return fail("Cannot read `git-toplevel` output, error: " .. err)
	elseif not output.status.success and output.status.code ~= 130 then
		return fail(output.stderr)
	end

	local target = output.stdout:gsub("\n$", "")
	if target ~= "" then
		ya.manager_emit("cd", { target })
	end
end

return { entry = entry }
