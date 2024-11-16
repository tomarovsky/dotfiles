return {
    {
        "David-Kunz/gen.nvim",
        config = function()
            local gen = require "gen"
            gen.setup {
                model = "mistral", -- The default model to use.
                quit_map = "q", -- set keymap to close the response window
                retry_map = "<c-r>", -- set keymap to re-send the current prompt
                accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
                host = "localhost", -- The host running the Ollama service.
                port = "11434", -- The port on which the Ollama service is listening.
                display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
                show_prompt = true, -- Shows the prompt submitted to Ollama.
                show_model = true, -- Displays which model you are using at the beginning of your chat session.
                no_auto_close = true, -- Never closes the window automatically.
                file = false, -- Write the payload to a temporary file to keep the command short.
                hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
                init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
                -- Function to initialize Ollama
                command = function(options)
                    local body = {model = options.model, stream = true}
                    return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
                end,
                -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
                -- This can also be a command string.
                -- The executed command must return a JSON object with { response, context }
                -- (context property is optional).
                -- list_models = '<omitted lua function>', -- Retrieves a list of model names
                debug = false -- Prints errors and the command which is run.
            }

            gen.prompts.Create_Commit_Message_For_Code =
                { prompt = "Create commit message for this code:\n$text" }
            gen.prompts.Create_Commit_Message_For_Diff =
                { prompt = "Create commit message for this diff:\n$text" }

            vim.keymap.set({ "n", "v" }, "<leader>ai", ":Gen<CR>")
            vim.keymap.set({ "n" }, "<leader>am", function()
                gen.select_model()
            end)
            vim.keymap.set({ "n", "v" }, "<leader>ac", function()
                gen.exec(gen.prompts.Chat)
            end)
            vim.keymap.set({ "n", "v" }, "<leader>as", function()
                gen.exec(gen.prompts.Summarize)
            end)
            vim.keymap.set({ "n", "v" }, "<leader>ag", function()
                gen.exec(gen.prompts.Create_Commit_Message_For_Code)
            end)
            vim.keymap.set({ "n", "v" }, "<leader>aa", function()
                gen.exec(gen.prompts.Ask)
            end)
            vim.keymap.set({ "n", "v" }, "<leader>ar", function()
                gen.exec(gen.prompts.Review_Code)
            end)
            vim.keymap.set({ "n", "v" }, "<leader>ae", function()
                gen.exec(gen.prompts.Enhance_Code)
            end)
        end,
    },
}
