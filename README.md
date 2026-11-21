# ocode

An opencode-style AI coding assistant for your terminal, powered by your own **local Ollama models**.

Chat, edit files and run commands (with your approval), look at images, videos and your screen, talk to it,
read your Gmail / Calendar / Drive, run a Discord or Telegram bot, plug in MCP servers, watch your CPU / RAM / GPU - all from one command: `ocode`.

## Install (Windows)

**Quickest:** with Python installed, run this in Command Prompt, then open a new window and type `ocode`:

```
python -m pip install --user https://github.com/Tycraft7331/Ocode/archive/refs/heads/main.zip
python -m ocode setup
```

**Or with the installer:** click the green **Code** button on GitHub → **Download ZIP**, unzip it, and follow the steps below.

### Step by step

1. Install **Python 3.9 or newer** from <https://www.python.org/downloads/> (tick *Add python.exe to PATH*).
2. Install **Ollama** from <https://ollama.com> and download a model, e.g. `ollama pull qwen2.5-coder:7b`.
3. Unzip this folder and **double-click `install.bat`**.
4. Open a **new** Command Prompt (or Windows Terminal) in any project folder and type:

```
ocode
```

`install.bat` installs ocode, adds it to your PATH, adds **"Open ocode here"** to the right-click menu of folders,
and adds an **ocode** profile to Windows Terminal. `uninstall.bat` removes all of that again (your settings and memory are kept).

## Install (Linux / macOS)

```
./install.sh
```

or `python3 -m pip install --user ".[all]"`.

## Using it

```
ocode                      open the interface in the current folder
ocode C:\projects\site     open it in another folder
ocode -m qwen3:8b -a plan  pick the model / mode (build, plan, chat)
ocode -p "fix the tests"   open it and send a message straight away
ocode --theme dracula      colour theme (18 to choose from - see below)
ocode -c                   pick up where you left off (restores your last chat tabs)

ocode run "explain this error"            ask once, print the answer, exit
type error.log | ocode run "what broke?"  pipe anything in
ocode run -a build --yes "add a README"   let it edit files without asking
ocode run -i photo.png "what is this?"    attach an image (or a video)

ocode help                 every command and shortcut  (ocode help keys · ocode help images · ocode help all)
ocode models               list your Ollama models (and which can see images)
ocode doctor               check that everything is installed and working
ocode setup                (re)do the Windows integration  ·  ocode setup --uninstall removes it
```

Inside the interface press **F1** (or type `/help`) for a searchable list of every command and shortcut,
or `ctrl+p` for the command palette. Highlights:
`shift+tab` switches Build / Plan / Chat, `ctrl+t` opens another chat tab, `ctrl+r` talks to it,
`ctrl+g` shows it your screen, `ctrl+o` attaches an image or video, `ctrl+b` opens the system monitor,
`/theme`, `/google`, `/discord`, `/memory`, `/resume` (bring back your last chats), `/export` (save a chat as Markdown), `/copy` (copy the last reply).

## Everyday extras

```
/undo   /redo              take back your last message - the reply and every file change - and bring it back
!git status                start a message with ! to run a shell command; the output stays in the chat
/btw <question>            a quick side question in a popup, not added to the chat
/sessions                  browse and reopen every chat you've had · ctrl+shift+t (or /reopen) reopens a closed tab
/editor                    write a long message in your text editor (EDITOR, or Notepad on Windows)
/compact                   summarize a long chat to free up the model's memory
F2                         switch back to the model you used before
```

Press enter while the AI is working and your message is queued. Multi-line pastes are kept whole.
`/highlights` shows what's new after an update.

## Themes

18 themes, each with matching code colours: **Catppuccin Mocha, Dracula, Everforest, GitHub Dark, Gruvbox, Matrix,
Monokai, Night Owl, Nord, One Dark, Opencode, Rosé Pine, Solarized Dark, Synthwave '84, Tokyo Night** and the light
**Catppuccin Latte, GitHub Light, Solarized Light**.

Type `/theme` for a picker with a live preview (in it: `l` logo style, `a` animations on/off, `r` random), or
`/theme dracula`, `/theme random`. The logo comes in gradient, classic and accent styles.

## Coding helpers

```
@src/app.py                put a file (or folder) into your message - press tab to complete or search
@src/app.py#20-45          only lines 20-45 of a file
up / down                  bring back messages you sent before
/undo                      undo the last file change ocode made (again to go further back)
/diff                      see what changed in your git repo
/commit                    commit, with a message ocode writes for you (you can edit it first)
/review                    review your uncommitted changes for bugs
/explain <thing>           explain a file, function or the whole project
/tests <thing>             write tests in your project's style and run them
/fix <problem>             find and fix a problem
/init                      write an OCODE.md describing your project (ocode reads it every time)
```

In Build and Plan mode ocode can also search your whole project and read web pages such as documentation
(it asks before opening a page). A chime sounds when a long task finishes.

**Your own commands:** save a prompt as a Markdown file in `%USERPROFILE%\.ocode\commands\` (or in a project's
`.ocode\commands\` folder) and it becomes a slash command named after the file. `$ARGUMENTS` is replaced by
whatever you type after it - e.g. `standup.md` containing `Summarise today's git log. $ARGUMENTS` gives you `/standup`.

## Connections

Type `/connections` to see everything ocode can link to and what's connected.

- **MCP servers** (`/mcp`): plug-in tools for the AI. Press `a` for one-click presets: Git, Fetch (read web pages), Time, Filesystem, Memory graph, Sequential thinking, Playwright (control a browser), Context7 (live library docs), GitHub (needs a token), or any custom command / `https://` URL.
  - The `npx` presets need [Node.js](https://nodejs.org); the `uvx` ones need uv (`python -m pip install uv`).
  - Servers are saved in `~/.ocode/mcp.json`, in the same `"mcpServers"` format Claude Desktop and Cursor use, so you can paste configs straight in (`o` in `/mcp` opens the file).
  - Read-only MCP tools work in Plan mode. Tools that can change things only work in Build mode and ask you first.
- **Telegram** (`/telegram`): chat with ocode from your phone. Message @BotFather, send `/newbot`, paste the token into `/telegram`, click Connect, then send your bot the pairing code ocode shows. Only your paired account gets answers. No extra packages needed.
- **Phone notifications** (`/notify`): install the free ntfy app, subscribe to a hard-to-guess topic name, and type the same name in `/notify`. You'll get a ping when a long task finishes or ocode needs your OK.
- **Discord** (`/discord`) and **Google** (`/google`), as before.

## Optional features

The installer sets these up for you. To add one later:

| Feature | Command |
|---|---|
| Images, videos, screen viewing | `python -m pip install pillow av` (plus a vision model: `ollama pull qwen2.5vl:7b`) |
| CPU / RAM monitor | `python -m pip install psutil` |
| Voice (microphone) and video sound | `python -m pip install sounddevice numpy faster-whisper` |
| Discord bot | `python -m pip install discord.py` |

## Updating

Type `/update` inside ocode (or run `ocode update` in Command Prompt). ocode checks this GitHub repository, shows
what changed, and asks before installing. On Windows it closes, updates in a new window, and reopens with your chats.
It also checks once a day by itself and tells you when a new version is out. `ocode update --check` only looks.

## Releasing a new version (for the maintainer)

1. Make your changes to `ocode.py`.
2. Bump `VERSION = "..."` near the top of `ocode.py` (e.g. `4.1.0` → `4.2.0`).
3. Commit and push to `main`. That's it - everyone's `/update` picks it up, and your commit messages are shown
   as "Recent changes". (Forgot to bump the version? Users are still offered "a newer build", but bumping it is clearer.)

The repository must be **public** for `/update` to work, because each copy downloads from GitHub without logging in.

## Troubleshooting

* `'ocode' is not recognized` - open a **new** terminal (PATH only updates for new windows), or run `python -m ocode setup`.
* Anything else - run `ocode doctor`; it tells you exactly what is missing.
* Settings, memory and tokens live in `%USERPROFILE%\.ocode` (set the `OCODE_HOME` environment variable to move them).
