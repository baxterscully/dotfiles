return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
    },
    config = function ()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
      vim.keymap.set('n', '<leader>dc', dap.continue, {})
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "nvim-dap",
    },
    config = function ()
      local conda_command = vim.api.nvim_create_augroup("CondaCommand", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        pattern = "CondaActivatePost",
        group = conda_command,
        callback = function()
          local conda_path = os.getenv("CONDA_DEFAULT_ENV")
          if conda_path then
            require('dap-python').setup(conda_path .. "/bin/python")
            print("DAP python path updated~ ✨")
          end
        end
      })

      local conda_path = os.getenv("CONDA_DEFAULT_ENV")
      local conda_python = os.getenv("CONDA_PYTHON_EXE")

      if conda_path then
        local path = conda_path .. "/bin/python"
        require('dap-python').setup(path)
      elseif conda_python then
        require('dap-python').setup(conda_python)
      else
        require('dap-python').setup('/usr/bin/python')
      end
    end
  },
}
