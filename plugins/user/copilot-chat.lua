return {
  -- copilot chat
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  build = 'make tiktoken',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },

  module = 'CopilotChat',
  cmd = {
    'CopilotChatCommit',
    'CopilotChatCommitStaged',
    'CopilotChatDocs',
    'CopilotChatExplain',
    'CopilotChatExplainAdvanced',
    'CopilotChatFix',
    'CopilotChatFixDiagnostic',
    'CopilotChatImplement',
    'CopilotChatImplementInline',
    'CopilotChatLeetTest',
    'CopilotChatModel',
    'CopilotChatModels',
    'CopilotChatOptimize',
    'CopilotChatReadable',
    'CopilotChatRefactor',
    'CopilotChatReview',
    'CopilotChatTests',
    'CopilotChatToggle',
  },
  opts = {
    debug = false,
    clear_chat_on_new_prompt = false,
    model = 'claude-3.7-sonnet',
    prompts = {
      Explain = {
        prompt = 'Write a detailed and technical explanation of the following code.',
        system_prompt = 'COPILOT_EXPLAIN',
      },
      Review = {
        prompt = 'Review the selected code.',
        system_prompt = 'COPILOT_REVIEW',
      },
      Fix = {
        prompt = 'There is an issue in this code. Rewrite the code to show it with the bug fixed.',
        system_prompt = 'COPILOT_GENERATE',
      },
      Optimize = {
        prompt = 'Optimize the selected code to improve performance and readablilty.',
        system_prompt = 'COPILOT_GENERATE',
      },
      Docs = {
        prompt = 'Add documentation and comments for the following code. Follow these rules:\n1) The comments should not duplicate the code.\n2) Explain unidiomatic code.',
        system_prompt = 'COPILOT_GENERATE',
      },
      Tests = {
        prompt = 'Generate tests for my code.',
        system_prompt = 'COPILOT_GENERATE',
      },
      FixDiagnostic = {
        prompt = 'Please assist with the following diagnostic issue in file:',
      },
      Commit = {
        prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        context = 'git:unstaged',
      },
      CommitStaged = {
        prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        context = 'git:staged',
      },
    },
    mappings = {
      close = {
        normal = 'q',
        insert = '<C-c>',
      },
      reset = {
        normal = 'R',
        insert = '<C-R>',
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-m>',
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>',
      },
    },
  },
}
