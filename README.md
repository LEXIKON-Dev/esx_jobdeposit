# esx_jobdeposit

ESX script for faction deposits. Players can deposit cash for their job at configured locations – e.g. workshop funds, police budget, or similar.

## Features

- Deposit points configurable via config (name, job, coordinates)
- Marker with adjustable size, color, and range
- Amount input via `esx_menu_dialog`
- Job members are notified about deposits
- Localization: German (`de`) and English (`en`)
- Help notify: ESX TextUI (default) or custom resource

## Dependencies

- [es_extended](https://github.com/esx-framework/esx_core)
- [esx_menu_dialog](https://github.com/esx-framework/esx_core)
- Optional: a help notify script only when `type = 'custom'`

## Installation

1. Place the `esx_jobdeposit` folder in your `resources` directory
2. Add to your `server.cfg`:
   ```
   ensure esx_jobdeposit
   ```
3. Adjust `config.lua` (points, marker, locale, help notify)
4. Restart the server

## Configuration

### Locale

```lua
Config.Locale = 'de' -- de | en
```

Add new strings in `locales/de.lua` and `locales/en.lua`. Use them in code with `_U('key')` or `_U('key', arg1, arg2)`.

### Help Notify

Two modes – no resource or export name required when using ESX:

```lua
Config.HelpNotify = {
    type = 'esx', -- 'esx' | 'custom'

    -- only relevant when type = 'custom':
    resource = 'soh_helpnotify',
    export   = 'showHelpNotification',
}
```

| Mode | Description |
|------|-------------|
| `esx` | Default. Uses the built-in ESX TextUI (`ESX.TextUI` / `HideUI`). No extra resource needed. |
| `custom` | Your own help notify script via resource name and export. |

With `type = 'esx'` (or an invalid value), the script automatically detects which ESX TextUI is available. No further setup required.

With `type = 'custom'`, the help notify resource must be running and `resource` + `export` in the config must match.

### Deposit Points

```lua
Config.EinzahlPunkte = {
    { Name = 'LADOT', job = 'mechanic', coords = vector3(-329.81, -155.95, 39.02) },
}
```

- `Name` – display name in the menu and notifications
- `job` – ESX job name; only members of this job receive the info message
- `coords` – marker position

### Marker

```lua
Config.Marker = {
    type         = 21,
    size         = vector3(0.5, 0.5, 0.5),
    color        = { r = 0, g = 139, b = 0, a = 150 },
    drawDist     = 30.0,
    interactDist = 2.0,
}
```

## In-Game Usage

1. Walk to the marker
2. Press `E`
3. Enter the amount and confirm

The money is deducted from the player's cash. The depositor and all online job members receive a notification.

## License

Free to use. Modifications and redistribution allowed.
