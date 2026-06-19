# esx_jobdeposit

ESX-Script für Fraktions-Einzahlungen. Spieler können an festgelegten Punkten Bargeld für ihren Job einzahlen – z. B. Werkstattkasse, Polizei-Fonds oder ähnliches.

## Features

- Einzahlungspunkte per Config definierbar (Name, Job, Koordinaten)
- Marker mit einstellbarer Größe, Farbe und Reichweite
- Dialog-Eingabe über `esx_menu_dialog`
- Job-Mitglieder werden über die Einzahlung informiert
- Lokalisierung: Deutsch (`de`) und Englisch (`en`)
- Help-Notify: ESX TextUI (Standard) oder Custom-Resource wählbar

## Abhängigkeiten

- [es_extended](https://github.com/esx-framework/esx_core)
- [esx_menu_dialog](https://github.com/esx-framework/esx_core)
- Optional: ein Help-Notify-Script nur bei `type = 'custom'`

## Installation

1. Ordner `esx_jobdeposit` in deinen `resources`-Ordner legen
2. In `server.cfg` eintragen:
   ```
   ensure esx_jobdeposit
   ```
3. `config.lua` anpassen (Punkte, Marker, Sprache, Help-Notify)
4. Server neu starten

## Konfiguration

### Sprache

```lua
Config.Locale = 'de' -- de | en
```

Neue Texte in `locales/de.lua` und `locales/en.lua` pflegen. Im Code mit `_U('key')` oder `_U('key', arg1, arg2)` verwenden.

### Help-Notify

Zwei Modi – kein Resource- oder Export-Name nötig, wenn du ESX nutzt:

```lua
Config.HelpNotify = {
    type = 'esx', -- 'esx' | 'custom'

    -- nur bei type = 'custom' relevant:
    resource = 'soh_helpnotify',
    export   = 'showHelpNotification',
}
```

| Modus | Beschreibung |
|-------|--------------|
| `esx` | Standard. Nutzt die eingebaute ESX TextUI (`ESX.TextUI` / `HideUI`). Keine extra Resource nötig. |
| `custom` | Eigenes Help-Notify-Script über Resource-Name und Export. |

Bei `type = 'esx'` (oder einem ungültigen Wert) erkennt das Script automatisch, welche ESX-TextUI verfügbar ist. Es muss nichts weiter eingestellt werden.

Bei `type = 'custom'` muss die Help-Notify-Resource laufen und `resource` + `export` in der Config passen.

### Einzahlungspunkte

```lua
Config.EinzahlPunkte = {
    { Name = 'LADOT', job = 'mechanic', coords = vector3(-329.81, -155.95, 39.02) },
}
```

- `Name` – Anzeigename im Menü und in Benachrichtigungen
- `job` – ESX-Jobname; nur Mitglieder dieses Jobs erhalten die Info-Nachricht
- `coords` – Position des Markers

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

## Nutzung ingame

1. Zum Marker laufen
2. `E` drücken
3. Betrag eingeben und bestätigen

Das Geld wird vom Bargeld des Spielers abgezogen. Der Einzahler und alle online Job-Mitglieder erhalten eine Benachrichtigung.

## Lizenz

Frei nutzbar. Anpassungen und Weitergabe erlaubt.
