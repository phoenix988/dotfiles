function saveSession()
  local sessionFile = "last_session"
  local sessionPath = vim.fn.expand('~/.local/share/nvim/' .. sessionFile)
  vim.cmd('mksession! ' .. sessionPath)
  print('Session saved to: ' .. sessionPath)
end

function loadSession()
  local sessionFile = "last_session"
  local sessionPath = vim.fn.expand('~/.local/share/nvim/' .. sessionFile)
  vim.cmd('source ' .. sessionPath)
  print('Session loaded from: ' .. sessionPath)
end

vim.cmd("command! SaveSession lua saveSession()")
vim.cmd("command! LoadSession lua loadSession()")
