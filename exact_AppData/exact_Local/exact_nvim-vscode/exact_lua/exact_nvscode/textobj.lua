local ai = require("mini.ai")

local function get_content_range(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local first, last
    for i, line in ipairs(lines) do
        if line:match("%S") then
            first = i;
            break
        end
    end
    for i = #lines, 1, -1 do
        if lines[i]:match("%S") then
            last = i;
            break
        end
    end
    if not first then
        first = 1
    end
    if not last then
        last = #lines
    end
    return first, last
end

ai.setup({
    -- 保険：探索行数を十分に大きく
    n_lines = 100000,

    custom_textobjects = {
        -- a e : バッファ全体（ラインワイズ）
        e = function(_, _)
            local last = vim.api.nvim_buf_line_count(0)
            return {
                from = {
                    line = 1,
                    col = 1
                },
                to = {
                    line = last,
                    col = 1
                }, -- ★ col=1 に固定（V選択では列は無視させる）
                vis_mode = "V"
            }
        end,

        -- i e : 先頭/末尾の空行を除いた実質本文（ラインワイズ）
        E = function(_, _)
            local first, last = get_content_range(0)
            return {
                from = {
                    line = first,
                    col = 1
                },
                to = {
                    line = last,
                    col = 1
                }, -- ★ ここも 1
                vis_mode = "V"
            }
        end
    }
})

-- 'ae' / 'ie' に割り当て（グローバルに依存しない呼び方）
vim.keymap.set({"x", "o"}, "ae", function()
    require("mini.ai").select_textobject("a", "e")
end, {
    silent = true,
    desc = "entire buffer (all)"
})

vim.keymap.set({"x", "o"}, "ie", function()
    require("mini.ai").select_textobject("a", "E")
end, {
    silent = true,
    desc = "entire buffer (inner)"
})
