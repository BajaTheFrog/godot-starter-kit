# Godot Project Starter Kit
A starter project configured with lots of helpful tools, systems and basic 2d assets.

**Kit Version:** `v0.0.2`<br>
**Godot Version:** `3.5.3`

## Goal
This is meant to act as a kit for quickly setting up a project and having instant access to common tools and systems. 

## Structure
### `/addons`
This is where all the different systems and tools provided by the kit are defined

### `/examples`
This is where all the example scenes that demonstrate the kit features are stored. 

## Kit Features
### `basic_2d_assets`
A collection of simple 2d assets that are available for quick prototyping purposes. 

### `clickable_area_2d`
A custom node that defines an `Area2D` that is prepped to respond to mouse clicks. 

### `components`
A collection of scripts that define some ready-to-use behavior to be composed within a node. 

### `event_bus`
The scripts that define an `Event Bus` system for communicating events through a game. Uses the observer pattern.

### `fonts`
A collection of fonts. 

### `gadgets`
Scripts and scenes for "standalone" behaviors and functionality. 

### `juice_press_feedback_system`
A system for composing "feedbacks" or ways of composing changes to nodes as a group. 

### `look_at` 
A custom node called `LookAt` which can define "look_at" behavior in the editor. 

### `mouse_listener` 
A custom node called `MouseListener` which can expose mouse information as signals to be consumed by other nodes. 

### `presentation`
A system and service for presenting special `Control` nodes that subclass `UI`. Handles layering and dismissals. 

### `sequencers`
A collection of scripts that define various `sequencers` which output values at definable intervals. 

### `transformers` 
A collection of scripts that allow for direct manipulation of transform-related properties.

### `utilities` 
A collection of common utilities helpful for math operations or async processing. 