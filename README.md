# TimeClap

A FiveM script that allows authorized players to freeze time for all other players on the server using a slow clap animation.

## Features

- Restricted access to specific Steam and Discord identifiers
- Slow clap animation triggers the time freeze effect
- All players except the command user are frozen in place
- Toggle functionality - use the command again to unfreeze
- Notification system informs frozen players about the time freeze
- No notification when time is unfrozen

## Installation

1. Download or clone this resource to your FiveM server's resources folder
2. Add `ensure TimeClap` to your server.cfg file
3. Configure authorized identifiers in the config.lua file
4. Restart your server or use `refresh` and `start TimeClap` commands

## Configuration

Edit the `config.lua` file to add authorized player identifiers:

```lua
Config.AllowedIdentifiers = {
    ["steam:110000123456789"] = true,
    ["discord:123456789012345678"] = true,
}
```

You can add as many Steam or Discord identifiers as needed. Make sure to use the exact format shown above.

## Usage

Authorized players can use the `/timestop` command to:
- First use: Freeze all other players and display a message to them
- Second use: Unfreeze all players

## Commands

- `/timestop` - Toggle time freeze for all players (authorized users only)

## Requirements

- FiveM server
- No additional dependencies required

## How It Works

1. Player executes `/timestop` command
2. Script checks if player has authorization
3. If authorized, player performs slow clap animation
4. At the moment of the clap, all other players are frozen
5. Frozen players receive a notification about the time freeze
6. Using the command again unfreezes all players

## Support

This script was created for FiveM servers running on the CitizenFX framework. Make sure your server is up to date for best compatibility.

## Version

Current version: 1.0.0
