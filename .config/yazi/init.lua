-- For yazi settings.
function Linemode:size_and_mtime()
    local time = math.floor(self._file.cha.mtime or 0)
    if time == 0 then
        time = ""
    else
        time = os.date("%Y/%m/%d %H:%M:%S", time)
    end
    local size = self._file:size()
    return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- For plugins.
require("full-border"):setup()
require("git"):setup()
require("smart-enter"):setup({})
