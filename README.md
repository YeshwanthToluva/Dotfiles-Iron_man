# 🧠 Dotfile Iron Man — Live Wallpaper + Music Toggle

This is a toggleable setup for a *badass Iron Man-style* live wallpaper experience on Linux, complete with music, voice line, and style mode switch — using just a keybind.  
Built for [unixporn](https://www.reddit.com/r/unixporn), obviously 😎

## ⚙️ Features
- Live wallpaper with looping video (via `mpvpaper`)
- Random mp3 music from your custom playlist
- Startup voice line (Jarvis style)
- Fade-in music volume for cinematic effect
- Toggle between:
  - 🌌 Style Mode: live video + music
  - 🧘 Focus Mode: static wallpaper for work


## 🧾 Requirements
- [`mpvpaper`](https://github.com/Gibbtio/mpvpaper)
- [`swww`](https://github.com/LGFae/swww) (for static wallpapers)
- `mpv`
- `socat`
- `libnotify` (for `notify-send`)

Install via pacman (for Arch-based distros):

```bash
sudo pacman -S mpv socat libnotify
yay -S swww mpvpaper
```
