# YAQSBAR
### Yet Another Quickshell Bar

A vertical desktop bar for Hyprland, built with [Quickshell](https://quickshell.org).

## Why

I already made another bar, but it got messy and long, so i started a new one with a
better structure and better practices from the start. Still not going to be perfect tho.

## Structure

```
├── shell.qml                   Entry point — instantiates the bar and any overlays
│
├── Config/
│   ├── Settings.qml            Every tunable value: sizes, spacing, icons, fonts
│   └── Colors.qml              Palette
│
├── Strings/
│   └── Strings.qml             User-facing text, kept out of the widgets
│
├── Common/                     Mechanics that don't know what they're used for
│   ├── BarWidgetButton.qml     Square bar button — click, right-click, scroll, hover
│   ├── BarPopup.qml            Popup anchored to a bar item; positioning only
│   ├── StyledText.qml          Text with the app font applied
│   └── IconText.qml            Text with the icon font applied
│
├── Services/                   Everything that talks to the outside world
│   ├── Power.qml               Session actions + shared open state for the menu
│   └── Time.qml                Wall clock, pre-split for the stacked layout
│
└── Modules/                    Features — where a widget's policy lives
    ├── Bar/
    │   ├── Bar.qml             The PanelWindow, one per monitor
    │   ├── BarSection.qml      A start/center/end run of widgets
    │   ├── WidgetRegistry.qml  Maps widget names in Settings to components
    │   ├── Workspaces.qml      Workspaces, specials, hover tooltips
    │   ├── Clock.qml           Stacked clock
    │   └── Power.qml           Button that opens the power menu
    └── PowerMenu/
        ├── PowerMenu.qml       Centred full-screen overlay
        └── PowerAction.qml     A single action tile
```

The four top-level directories are a rule, not a filing convention:

- **Config** holds values.
- **Common** holds reusable windows, buttons, etc.
- **Services** hold everything that talks to the outside world — the compositor, the
  system clock, processes. They're singletons, which is also how state crosses window
  boundaries, since a widget in one window can't reach an overlay in another.
- **Modules** hold features. They combine the other three and are the only place a
  widget's actual policy lives.

## Objective

- Create a usable shell/bar for my pc with everything I need.
- Make most settings customizable.
- Add translations.
- Learn more quickshell.