# Neovim Configuration

Modern Neovim config with AI completion, LSP, and clean UI.

## Features

- **AI Completion**: Local (Ollama), OpenAI, Claude, Codestral, GitHub Copilot + Chat
- **LSP**: Auto-install servers via Mason, auto-format on save
- **UI**: Molokai theme, status line, file explorer, fuzzy finder
- **Tools**: Treesitter, Git integration, commenting

---

## Prerequisites

**Required:**
```bash
# Neovim >= 0.9.0
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update && sudo apt install neovim

# Dependencies
sudo apt install git build-essential python3 python3-pip ripgrep

# Node.js (for LSP)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install 20 && nvm use 20

# Nerd Font (for icons)
# Download from https://www.nerdfonts.com/
```

**Optional (for local AI):**
```bash
# Ollama (recommended for privacy)
curl -fsSL https://ollama.com/install.sh | sh
ollama pull qwen2.5-coder:3b
```

---

## Installation

```bash
# 1. Backup existing config (if exists)
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.backup

# 2. Clone repository
mkdir -p ~/.config
git clone https://github.com/YOUR_USERNAME/nvim-config.git ~/.config/nvim

# 3. Launch Neovim (plugins will auto-install)
nvim
```

---

## Configuration

**All API keys/settings:** `lua/config/api_config.lua`

**Enable Copilot:**
```lua
M.copilot = { enabled = true, auto_trigger = true }
```
Then run `:Copilot auth` in Neovim.

**Switch AI Provider:**
```lua
M.minuet_provider = "local_ollama"  -- or "openai", "claude", "codestral"
```

**Change Models:**
```lua
M.ollama.model = "qwen2.5-coder:7b"  -- or codellama, deepseek-coder
M.openai.model = "gpt-4o"            -- or gpt-4o-mini
```

---

## Key Bindings

**Leader key:** `Space`

### General
| Key | Action |
|-----|--------|
| `<C-s>` | Save |
| `<C-q>` | Quit |
| `<leader>sn` | Save without formatting |

### File Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<C-n>` | Toggle explorer |
| `a` | Add file/directory |
| `d` | Delete |
| `r` | Rename |

### Fuzzy Finding (Telescope)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Search in files |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |

### Buffers & Windows
| Key | Action |
|-----|--------|
| `]b` / `[b` | Next/Previous buffer |
| `<leader>x` | Close buffer |
| `<leader>v` | Split vertically |
| `<leader>h` | Split horizontally |
| `<C-h/j/k/l>` | Navigate splits |

### Tabs
| Key | Action |
|-----|--------|
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn/tp` | Next/Previous tab |

### LSP Navigation
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous/Next diagnostic |
| `<leader>d` | Show diagnostic |

### Code Completion
| Key | Action |
|-----|--------|
| `<C-j>` / `<C-k>` | Navigate items |
| `<C-Space>` | Trigger completion |
| `<CR>` | Accept |
| `<Tab>` | Accept and next |

### AI Completions (Minuet)
| Key | Action |
|-----|--------|
| `<C-a>` | Accept suggestion (whole) |
| `<C-l>` | Accept suggestion (line) |
| `<M-]>` / `<M-[>` | Next/Previous suggestion |
| `<C-e>` | Dismiss |

### Copilot Chat (if enabled)
| Key | Mode | Action |
|-----|------|--------|
| `<leader>cc` | N/V | Toggle chat |
| `<leader>cq` | N/V | Quick chat |
| `<leader>cx` | V | Explain code |
| `<leader>ct` | V | Generate tests |
| `<leader>cf` | V | Fix code |
| `<leader>co` | V | Optimize code |
| `<leader>cd` | V | Document code |
| `<leader>cb` | N | Ask about buffer |
| `<leader>cp` | N | Prompt actions |
| `<leader>cr` | N | Reset chat |

### Local LLM Chat
| Key | Mode | Action |
|-----|------|--------|
| `<leader>ll` | V | Send to LLM |
| `<leader>lp` | N | Prompt LLM |

### Comments
| Key | Mode | Action |
|-----|------|--------|
| `gcc` | N | Toggle line comment |
| `gc` | V | Toggle comment |

### Other
| Key | Action |
|-----|--------|
| `<leader>bg` | Toggle background transparency |
| `<leader>lw` | Toggle line wrap |

---

## Installed LSP Servers

TypeScript/JavaScript (`ts_ls`), Python (`pylsp`, `ruff`), Lua (`lua_ls`), HTML, CSS, Tailwind, Docker, SQL, Terraform, JSON, YAML

**Add more:** Edit `lua/plugins/lsp.lua` and add to `servers` table

**Formatters/Linters:** Prettier, Stylua, Ruff, ESLint, shfmt, checkmake

---

## File Structure

```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   └── api_config.lua        # API keys & settings
│   ├── core/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── snippets.lua
│   └── plugins/
│       ├── autocompletion.lua
│       ├── copilot.lua
│       ├── copilot-chat.lua
│       ├── colortheme_molokai.lua
│       ├── lsp.lua
│       ├── minuet.lua
│       ├── telescope.lua
│       └── ...
└── README.md
```

---

## Troubleshooting

**Plugins not installing:** `:Lazy sync`

**LSP not working:** `:Mason` → Press `i` on server

**AI completions not working:**
```bash
ollama list  # Check Ollama is running
ollama run qwen2.5-coder:3b "test"
```

**Copilot not working:** `:Copilot auth`

**Icons not showing:** Install a Nerd Font and configure terminal

**Deprecation warnings:** Run `:Lazy update` to update plugins

---

## Updating

```vim
:Lazy sync      " Update plugins
:Mason          " Press 'U' to update LSP servers
```

```bash
cd ~/.config/nvim && git pull  # Update config
```

---

## Privacy

- **Ollama (default)**: All local, no data sent externally ✅
- **Copilot/OpenAI/Claude**: Code sent to external servers ❌

**For sensitive code:** Keep `M.minuet_provider = "local_ollama"` and `M.copilot.enabled = false`

---

## Credits

[lazy.nvim](https://github.com/folke/lazy.nvim) • [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) • [mason.nvim](https://github.com/williamboman/mason.nvim) • [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) • [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) • [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) • [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) • [minuet-ai](https://github.com/milanglacier/minuet-ai.nvim) • [copilot.lua](https://github.com/zbirenbaum/copilot.lua) • [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) • [gitsigns](https://github.com/lewis6991/gitsigns.nvim) • [lualine](https://github.com/nvim-lualine/lualine.nvim)

MIT License
