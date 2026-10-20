# Pong — 20 Games Challenge

A Godot implementation of Pong built as part of the 20 Games Challenge. Play against a simple AI or share the keyboard for a local two-player match.

## Features

- Main menu with one-player and two-player modes.
- Human-controlled left paddle and optional AI-controlled right paddle.
- Score tracking for both sides.
- Ball speed increases on paddle-face impacts.
- Bounce direction changes with the point of contact on the paddle.
- Collision sound playback.
- Pause menu with Resume, Main Menu and Quit.
- Spacebar serve at the start and after each point.

## Requirements and startup

The project configuration records **Godot 4.7** with **GL Compatibility** rendering.

1. Clone or download the repository, preserving **Scenes**, **Scripts**, **Sounds** and **Sprites**.
2. Import **project.godot** into a compatible Godot 4 editor.
3. Allow asset imports to complete.
4. Press **F5** to run the main menu.
5. Select one or two players, then press Space to serve.

The configured gameplay viewport is 640 × 480.

## Controls

| Action | Input |
| --- | --- |
| Left paddle up/down | W / S |
| Right paddle up/down, two-player mode | Up Arrow / Down Arrow |
| Start a rally / serve again | Space |
| Toggle pause menu | Escape |

In single-player mode, the right paddle follows the ball vertically. The opponent is intentionally simple rather than predictive.

## Project organization

| Path | Responsibility |
| --- | --- |
| [Scenes/main_menu.tscn](Scenes/main_menu.tscn) | Mode selection |
| [Scenes/game.tscn](Scenes/game.tscn) | Paddles, ball, walls, scoring boundaries and labels |
| [Scenes/PauseMenu.tscn](Scenes/PauseMenu.tscn) | Pause interface |
| [Scripts/Globals.gd](Scripts/Globals.gd) | Autoloaded player-mode state |
| [Scripts/game.gd](Scripts/game.gd) | Serve state and score updates |
| [Scripts/ball.gd](Scripts/ball.gd) | Ball motion, collisions and reset |
| [Scripts/player_left.gd](Scripts/player_left.gd) | Left-paddle input |
| [Scripts/player_right.gd](Scripts/player_right.gd) | Right-paddle keyboard/AI behavior |
| [Scripts/pause_menu.gd](Scripts/pause_menu.gd) | Pause and scene navigation |
| Sounds/ and Sprites/ | Game assets |

## Tuning

Ball defaults are exposed as exported properties: initial speed **200**, speed multiplier **1.05**, maximum speed **1,000** and maximum bounce angle **60 degrees**.

The left paddle's speed is 400. The right paddle uses 400 for keyboard control and an exported AI speed of 150. Both paddles clamp their vertical position between 40 and 440.

When a point is scored, the ball resets to the center and waits for another Space press. There is no match-winning score threshold in the game controller.

## Manual checks

Test one-player and two-player controls separately. Score on both boundaries and verify that the correct counter changes. Pause during a rally, resume, return to the main menu and start a new game. Check repeated paddle-edge collisions and ball-speed changes.

The fixed paddle bounds and assumed paddle height are tied to the present scene dimensions; adjust them together if resizing the playing field.
