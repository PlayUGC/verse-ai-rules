# Feature Request Example

## User Request
"Help me implement a feature: I need a timer in Verse that counts down from 2 minutes and then awards player XP/accolades every two minutes"

## AI Response

# Feature Request Analysis & Implementation Plan

## 1. Feature Request Summary
Create a countdown timer in Verse that starts at 2 minutes, counts down to zero, awards the player XP/accolades, and then restarts the cycle.

## 2. Feature Breakdown
- Timer Component: Create a countdown timer starting from 2 minutes
- Award System: Implement mechanism to grant XP/accolades when timer reaches zero
- Timer Reset: Automatically restart the timer after rewards are distributed
- Visual Feedback: Display timer and reward notifications to the player

## 3. Clarification Questions
1. How should the timer be displayed to the player? (HUD element, floating text, etc.)
2. What specific XP amount and/or accolades should be awarded each cycle?
3. Should the timer pause if the player is eliminated/respawns?
4. Should players be notified when rewards are granted?
5. Is this timer per-player or global for the entire game?
6. Should the timer persist between rounds/games?

## 4. Technical Approach
I'll implement this using Verse with a device-based approach:
- Create a timer_manager device to handle countdown logic
- Use Verse's builtin time functions for accurate timing
- Implement player notification system using HUD or popup messages
- Integrate with the game's existing XP/accolade systems

## 5. Implementation Plan
1. Create the basic timer device structure
2. Implement countdown logic with proper time tracking
3. Add award distribution when timer completes
4. Implement timer reset functionality
5. Add visual elements and notifications
6. Test with different gameplay scenarios
7. Optimize and refine based on testing

## 6. Next Steps
Would you like me to build this out step by step?

## User Response
"Yes, please start implementing this feature."

## AI Implementation

I'll start implementing this feature. First, let's create a tasks.md file to track our progress:

```markdown
# Implementation Tasks

## Task 1: Create Timer Device Structure ✅
- Define basic device class
- Set up required properties
- Create initialization logic

## Task 2: Implement Countdown Logic ⏳
- Add time tracking mechanism
- Create countdown update loop
- Handle time display formatting

## Task 3: Award Distribution System ⬜
- Create reward granting function
- Define XP/accolade values
- Implement player feedback

## Task 4: Timer Reset Functionality ⬜
- Add reset logic after rewards
- Ensure seamless loop behavior
- Handle edge cases (player leaving, etc.)

## Task 5: Visual Elements ⬜
- Implement HUD elements
- Create notification system
- Style visual components

## Task 6: Testing & Optimization ⬜
- Test with various gameplay scenarios
- Optimize performance
- Handle edge cases
```

Let's implement Task 1: Create Timer Device Structure

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Fortnite.com/UI }

# A device that awards XP to players every two minutes
timer_manager := class(creative_device):
    # Reference to the accolades device that grants XP to players
    @editable
    AccoladesDevice : accolades_device = accolades_device{}
    
    # The duration of the timer in seconds
    TimerDuration : float = 120.0  # 2 minutes
    
    # Track all players in game
    var ActivePlayers: [player]player = map{}
    
    # Called when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        # Set up player events
        SubscribeToPlayerEvents()
        
        # Initialize with any existing players
        for (Player : GetPlayspace().GetPlayers()):
            OnPlayerAdded(Player)
        
        # Start the main timer loop
        spawn { RunTimerLoop() }
        
        Print("Timer Manager: Initialized")
    
    # Subscribe to player events
    SubscribeToPlayerEvents(): void =
        # Get the playspace and subscribe to player events
        Playspace := GetPlayspace()
        
        # Subscribe to player added/removed events
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
        Playspace.PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
    
    # Called when a player joins the game
    OnPlayerAdded(Player: player): void =
        # Add player to the map if not already present
        if (not ActivePlayers[Player]):
            if (set ActivePlayers[Player] = Player){}
            Print("Timer Manager: Player added")
    
    # Called when a player leaves the game
    OnPlayerRemoved(Player: player): void =
        # Remove player from the active players map
        var NewActivePlayers : [player]player = map{}
        
        for (CurrentPlayer -> Value : ActivePlayers):
            if (CurrentPlayer <> Player, set NewActivePlayers[CurrentPlayer] = Value){}
        
        set ActivePlayers = NewActivePlayers
        Print("Timer Manager: Player removed")
    
    # Main timer loop
    RunTimerLoop()<suspends> : void =
        # Implementation will be added in Task 2
        Print("Timer loop started")
```

Would you like me to proceed with implementing Task 2: Countdown Logic? 