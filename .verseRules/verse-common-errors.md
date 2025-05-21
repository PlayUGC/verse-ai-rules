# Common Verse Errors and Solutions

This guide documents common errors encountered in Verse development and provides clear solutions with examples.

## Table of Contents

1. [Syntax Errors](#syntax-errors)
2. [Type Errors](#type-errors)
3. [Concurrency Errors](#concurrency-errors)
4. [Nullability Errors](#nullability-errors)
5. [Event Handling Errors](#event-handling-errors)
6. [Logic Errors](#logic-errors)
7. [Performance Issues](#performance-issues)
8. [UEFN-Specific Errors](#uefn-specific-errors)
9. [UI-Specific Errors](#ui-specific-errors)

## Syntax Errors

### Missing Colon After Function Declaration

**Error:**
```verse
Add(A: int, B: int) = A + B
```

**Error Message:**
```
Expected ':' followed by a return type
```

**Solution:**
```verse
Add(A: int, B: int): int = A + B
```

### Missing Return Type

**Error:**
```verse
Multiply(A: int, B: int) = 
    A * B
```

**Error Message:**
```
Expected ':' followed by a return type
```

**Solution:**
```verse
Multiply(A: int, B: int): int = 
    A * B
```

### Incorrect Optional Type Declaration

**Error:**
```verse
var Player: player? = null
```

**Error Message:**
```
Unexpected token '?'
```

**Solution:**
```verse
var Player: ?player = false  # Empty optional
# OR
var Player: ?player = option{SomePlayer}  # With value
```

### Missing Parameter Types

**Error:**
```verse
Process(Data) = 
    # Process data
```

**Error Message:**
```
Expected ':' followed by a type
```

**Solution:**
```verse
Process(Data: player_data): void = 
    # Process data
```

### Incorrect String Interpolation

**Error:**
```verse
Message := "Hello ${PlayerName}!"
```

**Error Message:**
```
Unexpected token '${' in string literal
```

**Solution:**
```verse
Message := $"Hello {PlayerName}!"
```

### Using Semicolons

**Error:**
```verse
Print("Hello");
var Score: int = 100;
```

**Error Message:**
```
Unexpected token ';'
```

**Solution:**
```verse
Print("Hello")
var Score: int = 100
```

### Incorrect Array Declaration

**Error:**
```verse
var Numbers = [1, 2, 3]
```

**Error Message:**
```
Unexpected token '['
```

**Solution:**
```verse
var Numbers: []int = array{1, 2, 3}
```

### Incorrect Map Declaration

**Error:**
```verse
var Scores = {"Alice": 100, "Bob": 85}
```

**Error Message:**
```
Unexpected token '{'
```

**Solution:**
```verse
var Scores: map[string]int = map{"Alice" => 100, "Bob" => 85}
```

### Incorrect Function Specifier Position

**Error:**
```verse
LoadData(): void <suspends> =
    # Function body
```

**Error Message:**
```
Unexpected token '<suspends>' after return type
```

**Solution:**
```verse
LoadData()<suspends>: void =
    # Function body
```

### Missing Function Body

**Error:**
```verse
Calculate(X: float, Y: float): float
```

**Error Message:**
```
Expected '=' followed by function body
```

**Solution:**
```verse
Calculate(X: float, Y: float): float =
    X + Y
```

## Type Errors

### Type Mismatch

**Error:**
```verse
var Score: int = "100"
```

**Error Message:**
```
Cannot convert string to int
```

**Solution:**
```verse
var Score: int = 100
```

### Incompatible Types in Conditional

**Error:**
```verse
if (PlayerName):
    # Do something
```

**Error Message:**
```
Condition must be of type 'logic', got 'string'
```

**Solution:**
```verse
if (PlayerName != ""):
    # Do something
```

### Missing Type Constraint

**Error:**
```verse
Max<T>(A: T, B: T): T =
    if (A > B): A
    else: B
```

**Error Message:**
```
Operator '>' cannot be applied to operands of type 'T'
```

**Solution:**
```verse
Max<T>(A: T, B: T): T where T: comparable =
    if (A > B): A
    else: B
```

### Incorrect Collection Element Access

**Error:**
```verse
Names := array{"Alice", "Bob"}
FirstName := Names.0
```

**Error Message:**
```
'[]string' has no member named '0'
```

**Solution:**
```verse
Names := array{"Alice", "Bob"}
FirstName := Names[0]
```

### Incorrect Tuple Element Access

**Error:**
```verse
Position := (10.0, 20.0)
X := Position[0]
```

**Error Message:**
```
'(float, float)' has no member named '[]'
```

**Solution:**
```verse
Position := (10.0, 20.0)
X := Position.0
```

## Concurrency Errors

### Missing Await

**Error:**
```verse
Result := FetchDataAsync()
```

**Error Message:**
```
Cannot use result of suspending function without 'await'
```

**Solution:**
```verse
Result := await FetchDataAsync()
```

### Missing Suspends Specifier

**Error:**
```verse
LoadGame(): void =
    Data := await LoadData()
```

**Error Message:**
```
Cannot use 'await' in a non-suspending context
```

**Solution:**
```verse
LoadGame()<suspends>: void =
    Data := await LoadData()
```

### Race Condition

**Error:**
```verse
spawn:
    set Counter += 1
spawn:
    set Counter += 1
```

**Solution:**
```verse
# Use a synchronized approach
UpdateCounter(): void =
    set Counter += 1

# Then spawn that function
spawn UpdateCounter()
spawn UpdateCounter()
```

### Blocking UI Thread

**Error:**
```verse
OnButtonClicked(Agent: agent): void =
    # Long-running operation
    ProcessLargeDataSet()
```

**Solution:**
```verse
OnButtonClicked(Agent: agent): void =
    # Spawn as a background task
    spawn ProcessLargeDataSetAsync()
```

## Nullability Errors

### Null Reference Access

**Error:**
```verse
PlayerHealth := Player.Health
```

**Error Message:**
```
'Player' might be null
```

**Solution:**
```verse
if (Player?):
    PlayerHealth := Player.Health
```

### Incorrect Option Unwrapping

**Error:**
```verse
var MaybeScore: ?int = option{100}
Score := MaybeScore
```

**Error Message:**
```
Cannot convert '?int' to 'int'
```

**Solution:**
```verse
var MaybeScore: ?int = option{100}
if (Score := MaybeScore?):
    # Use Score
```

### Missing Null Coalescing

**Error:**
```verse
PlayerName := GetPlayerName()  # May return false
```

**Solution:**
```verse
PlayerName := GetPlayerName() ?: "Unknown"
```

### Unchecked Map Access

**Error:**
```verse
Score := Scores["PlayerOne"]  # May not exist
```

**Solution:**
```verse
if (Score := Scores.Get("PlayerOne")?):
    # Use Score
```

## Event Handling Errors

### Unsubscribed Events

**Error:**
```verse
OnBegin<override>()<suspends>: void =
    SomeDevice.ActivatedEvent.Subscribe(OnActivated)
    # Missing unsubscribe
```

**Solution:**
```verse
var Subscription: ?event_subscription = false

OnBegin<override>()<suspends>: void =
    set Subscription = option{SomeDevice.ActivatedEvent.Subscribe(OnActivated)}
    
OnEnd<override>()<suspends>: void =
    if (Sub := Subscription?):
        Sub.Unsubscribe()
```

### Incorrect Event Parameter

**Error:**
```verse
OnPlayerJoined(Player: string): void =
    # Handler expects string but event provides player
```

**Solution:**
```verse
OnPlayerJoined(Player: player): void =
    # Correct parameter type
```

### Multiple Subscriptions

**Error:**
```verse
OnBegin<override>()<suspends>: void =
    # May get called multiple times
    SomeDevice.ActivatedEvent.Subscribe(OnActivated)
```

**Solution:**
```verse
var Subscribed: logic = false

OnBegin<override>()<suspends>: void =
    if (not Subscribed):
        SomeDevice.ActivatedEvent.Subscribe(OnActivated)
        set Subscribed = true
```

## Logic Errors

### Off-by-One in Range

**Error:**
```verse
# Intended to iterate through array
for (i := 1..Players.Length):
    Player := Players[i]  # Will miss first element
```

**Solution:**
```verse
# Start at 0 for zero-based indexing
for (i := 0..Players.Length - 1):
    Player := Players[i]
```

### Forgetting Return in Function

**Error:**
```verse
FindPlayer(Name: string): ?player =
    for (P : Players):
        if (P.Name = Name):
            return option{P}
    # Missing return at end of function
```

**Solution:**
```verse
FindPlayer(Name: string): ?player =
    for (P : Players):
        if (P.Name = Name):
            return option{P}
    return false
```

### Missing Seed in Random

**Error:**
```verse
RandomResult := GetRandomInt(1, 10)  # Same sequence every time
```

**Solution:**
```verse
using { /Verse.org/Random }
Seed: int = GetSimulationElapsedTime()
LocalRNG := MakeRNG(Seed)
RandomResult := LocalRNG.GetRandomInt(1, 10)
```

## Performance Issues

### Excessive Logging

**Error:**
```verse
for (i := 0..1000):
    Log("Iteration {i}")  # Heavy logging
```

**Solution:**
```verse
# Only log periodically or for significant events
if (i % 100 = 0):
    Log("Progress: {i}/1000")
```

### Inefficient Collection Operations

**Error:**
```verse
# Adding items one by one
var LargeArray: []int = array{}
for (i := 0..10000):
    set LargeArray += array{i}  # Creates a new array each time
```

**Solution:**
```verse
# Build an array first then assign once
var Items: []int = array{}
for (i := 0..10000):
    set Items += array{i}
set LargeArray = Items
```

### Unnecessary Recalculations

**Error:**
```verse
for (i := 0..1000):
    Distance := CalculateComplexDistance(Position1, Position2)  # Same calculation each time
```

**Solution:**
```verse
Distance := CalculateComplexDistance(Position1, Position2)
for (i := 0..1000):
    # Use precalculated distance
```

## UEFN-Specific Errors

### Missing Editable Attribute

**Error:**
```verse
var SpawnLocation: vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
# Not editable in UEFN editor
```

**Solution:**
```verse
@editable var SpawnLocation: vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
```

### Incorrect Device Reference

**Error:**
```verse
var TargetDevice: creative_device = creative_device{}
# Too generic, not specific to a device type
```

**Solution:**
```verse
@editable var TargetDevice: trigger_device = trigger_device{}
# Specific device type with proper interfaces
```

### Not Implementing Required Override

**Error:**
```verse
my_device := class(creative_device):
    # Missing OnBegin override
```

**Solution:**
```verse
my_device := class(creative_device):
    # Implement required methods
    OnBegin<override>()<suspends>: void =
        # Initialization code
```

### Incorrect Device Event Subscription

**Error:**
```verse
ButtonDevice.OnPressed.Subscribe(HandleButtonPress)
# Incorrect event name
```

**Solution:**
```verse
ButtonDevice.InteractedWithEvent.Subscribe(HandleButtonPress)
# Correct event name
```

## UI-Specific Errors

### Incorrect Message Creation

**Error:**
```verse
TextBlock.SetText(message{Text})  # Wrong
TextBlock.SetText(TextMessage(Text))  # Wrong
```

**Error Message:**
```
Invalid access of epic_internal class constructor
```

**Solution:**
```verse
# Define helper function
StringToMessage<localizes>(Text:string):message= "{Text}"

# Use helper function
TextBlock.SetText(StringToMessage("Some text"))
```

### Incorrect Canvas Widget Addition

**Error:**
```verse
Canvas.Add(Widget)  # Wrong
Canvas.AddSlot(Widget)  # Wrong
```

**Error Message:**
```
Unknown member 'Add' in 'canvas'
Unknown member 'AddSlot' in 'canvas'
```

**Solution:**
```verse
# Create slot first
var WidgetSlot: canvas_slot = canvas_slot:
    Widget := MyWidget
    Anchors := anchors:
        Minimum := vector2{X := 0.5, Y := 0.1}
        Maximum := vector2{X := 0.5, Y := 0.1}
    Alignment := vector2{X := 0.5, Y := 0.0}
    SizeToContent := true

# Add widget using slot
Canvas.AddWidget(WidgetSlot)
```

### Missing Localization Attribute

**Error:**
```verse
StringToMessage(Text:string):message= "{Text}"  # Missing <localizes>
```

**Error Message:**
```
Localized messages may only be initialized with a string literal
```

**Solution:**
```verse
StringToMessage<localizes>(Text:string):message= "{Text}"
```

### Incorrect Text Block Configuration

**Error:**
```verse
var TextBlock: text_block = text_block:
    SetColor(NamedColors.White)  # Wrong
    SetText("Some text")  # Wrong
```

**Error Message:**
```
Unknown member 'SetColor' in 'text_block'
This function parameter expects a value of type message
```

**Solution:**
```verse
var TextBlock: text_block = text_block:
    DefaultTextColor := NamedColors.White
    DefaultText := StringToMessage("Some text")
```

### Missing Vector2 Type

**Error:**
```verse
Anchors := anchors:
    Minimum := vector2{X := 0.5, Y := 0.1}  # Error if SpatialMath not imported
```

**Error Message:**
```
Unknown identifier 'vector2'
```

**Solution:**
```verse
using { /UnrealEngine.com/Temporary/SpatialMath }

# Then use vector2
Anchors := anchors:
    Minimum := vector2{X := 0.5, Y := 0.1}
```

### Incorrect String Interpolation in Messages

**Error:**
```verse
TextBlock.SetText(StringToMessage("Score: ${Score}"))  # Wrong
```

**Error Message:**
```
Unexpected token '${' in string literal
```

**Solution:**
```verse
TextBlock.SetText(StringToMessage("Score: {Score}"))
```