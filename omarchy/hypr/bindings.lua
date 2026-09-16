-- Override of ~/.config/hypr/bindings.lua (see manual/31-dotfiles.md)
--
-- Hyper (CapsLock → XKB Mod3, see hypr/input.lua) is the Omarchy/WM modifier,
-- matching the old Regolith `.Xmodmap` (`keycode 66 = Hyper_L; add mod3 =
-- Hyper_L`) and macOS HyperKey. Super/Cmd is remapped to Ctrl in the
-- browser only (Regolith xremap); Ghostty and Alacritty get Super natively
-- (see docs/desktop_cheatsheet.md).
--
-- Omarchy default SUPER bindings are disabled in hyprland.lua
-- (`omarchy_default_bindings = false`).

-- Focus window
o.bind("MOD3 + H", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("MOD3 + J", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("MOD3 + K", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("MOD3 + L", "Focus right", hl.dsp.focus({ direction = "r" }))

-- Move (swap) window
o.bind("MOD3 + SHIFT + H", "Swap window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("MOD3 + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("MOD3 + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("MOD3 + SHIFT + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))

-- Toggle window
o.bind("MOD3 + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("MOD3 + SHIFT + F", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))
o.bind("MOD3 + MINUS", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("MOD3 + SHIFT + MINUS", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Workspace
for workspace = 1, 9 do
  o.bind("MOD3 + " .. workspace, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
  o.bind("MOD3 + SHIFT + " .. workspace, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = tostring(workspace) }))
end

-- Management
o.bind("MOD3 + TAB", "Cycle window", hl.dsp.window.cycle_next())
o.bind("MOD3 + SHIFT + Q", "Close window", hl.dsp.window.close())
o.bind("CTRL + ALT + DELETE", "Close all windows", "omarchy-hyprland-window-close-all")

-- Launch
o.bind("MOD3 + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("MOD3 + SHIFT + RETURN", "Browser: Brave", { launch = "brave" })
o.bind("MOD3 + SPACE", "Omarchy menu", "omarchy-menu toggle")
o.bind("MOD3 + ALT + SPACE", "Apps menu", "omarchy-menu toggle apps")
o.bind("MOD3 + ESCAPE", "System menu", "omarchy-menu toggle system")
o.bind("XF86PowerOff", "Power menu", "omarchy-menu toggle system", { locked = true })
o.bind_toggle("MOD3 + SHIFT + SPACE", "Toggle top bar", "bar")
o.bind("MOD3 + CTRL + L", "Lock system", "omarchy-system-lock")

-- Launch apps (parity with macos/skhdrc; letters kept identical except
-- IntelliJ, which uses I here since MOD3+J is already "Focus down" above.
-- Dictionary, Notes, Mail, Reminders, Calendar, and Podcasts are skipped —
-- no equivalent app/package is installed on Omarchy for those).
o.bind("MOD3 + T", "Terminal: Alacritty", "alacritty")
o.bind("MOD3 + G", "Terminal: Ghostty", "ghostty")
o.bind("MOD3 + E", "Editor: Zed", "zed")
o.bind("MOD3 + I", "Editor: IntelliJ IDEA", "idea")
o.bind("MOD3 + W", "Browser: Chrome", "google-chrome-stable")
o.bind("MOD3 + B", "Browser: Brave", "brave")
o.bind("MOD3 + O", "Notes: Obsidian", "obsidian")
o.bind("MOD3 + S", "Slack", "slack")
o.bind("MOD3 + Z", "Zoom", "zoom")
o.bind("MOD3 + V", "Video: mpv", "mpv")

-- Click-drag move / resize (macOS HyperKey "Click Drag Move")
o.bind("MOD3 + mouse:272", "Move window", hl.dsp.window.drag(), { mouse = true })
o.bind("MOD3 + mouse:273", "Resize window", hl.dsp.window.resize(), { mouse = true })

-- Capture (Omarchy defaults without SUPER)
o.bind("PRINT", "Screenshot", "omarchy-capture-screenshot")
o.bind("ALT + PRINT", "Screenrecording", "omarchy-capture-screenrecording --stop-recording || omarchy-menu toggle trigger.capture.screenrecord")
o.bind("MOD3 + PRINT", "Color picker", "pkill hyprpicker || hyprpicker -a")

-- Laptop lid
o.bind("switch:on:Lid Switch", nil, "omarchy-system-lid-close", { locked = true })
o.bind("switch:off:Lid Switch", nil, "omarchy-hyprland-monitor-clamshell", { locked = true })

-- Super=Ctrl in the browser only (Regolith debian/xremap/config.yml).
-- auto_consuming + { ok = false } lets Super reach Ghostty/Alacritty when
-- the focused window is not a browser. send_key_state matches Omarchy's
-- clipboard binds so a held Super does not stick the synthetic Ctrl chord.
local function send_ctrl_once(key, shift)
  return function()
    local mods = shift and "CTRL SHIFT" or "CTRL"
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

local function tag_base(tag)
  return tag:gsub("%*$", "")
end

local function active_window_is_browser()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    local name = tag_base(tag)
    if name == "chromium-based-browser" or name == "firefox-based-browser" then
      return true
    end
  end

  local class = window.class or ""
  return class:find("[Cc]hrom")
    or class:find("[Bb]rave")
    or class:find("[Ff]irefox")
    or class:find("[Mm]icrosoft%-edge")
    or class:find("Vivaldi")
    or class:find("helium")
    or class:find("^zen")
    or class:find("[Ll]ibrewolf")
end

local function browser_super(key, description, ctrl_key, shift)
  o.bind("SUPER + " .. key, description, function()
    if not active_window_is_browser() then
      return { ok = false }
    end
    send_ctrl_once(ctrl_key or key, shift)()
  end, { auto_consuming = true })
end

-- Same chords as the old Brave-only xremap map.
for _, key in ipairs({ "A", "C", "D", "F", "L", "N", "R", "T", "W", "Y", "X", "V" }) do
  browser_super(key, "Browser Super=" .. key)
end
for digit = 1, 9 do
  browser_super(tostring(digit), "Browser Super=" .. digit)
end
browser_super("SHIFT + T", "Browser reopen tab", "T", true)
browser_super("SHIFT + N", "Browser private window", "N", true)
