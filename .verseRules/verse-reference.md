# Verse Language Reference

## Table of Contents

1. [Introduction](#introduction)
2. [Language Fundamentals](#language-fundamentals)
   - [Using Directives](#using-directives)
   - [Comments](#comments)
   - [Basic Types](#basic-types)
   - [Variables and Constants](#variables-and-constants)
   - [Type System Overview](#type-system-overview)
3. [Control Flow](#control-flow)
   - [Block Expressions](#block-expressions)
   - [If Expressions](#if-expressions)
   - [Case Expressions](#case-expressions)
   - [Loops](#loops)
   - [Failure Handling](#failure-handling)
4. [Functions](#functions)
   - [Function Declarations](#function-declarations)
   - [Parameters](#parameters)
   - [Return Types](#return-types)
   - [Function Specifiers](#function-specifiers)
   - [Generic Functions](#generic-functions)
5. [Composite Types](#composite-types)
   - [Classes](#classes)
   - [Interfaces](#interfaces)
   - [Subclasses](#subclasses)
   - [Constructor Patterns](#constructor-patterns)
   - [Parametric Types](#parametric-types)
6. [Container Types](#container-types)
   - [Array](#array)
   - [Map](#map)
   - [Tuple](#tuple)
   - [Set](#set)
   - [Option](#option)
7. [Concurrency](#concurrency)
   - [Suspending Functions](#suspending-functions)
   - [Async/Await Pattern](#asyncawait-pattern)
   - [Spawn](#spawn)
   - [Task Management](#task-management)
   - [Race and Any](#race-and-any)
   - [Time Functions](#time-functions)
   - [Timeouts](#timeouts)
8. [Common UEFN Patterns](#common-uefn-patterns)
   - [Device Setup](#device-setup)
   - [Event Handling](#event-handling)
   - [Player Management](#player-management)
   - [Game Flow](#game-flow)
9. [Debugging and Performance](#debugging-and-performance)
   - [Logging](#logging)
   - [Profiling](#profiling)
   - [Common Errors](#common-errors)
10. [Common Pitfalls](#common-pitfalls)
    - [Syntax Errors](#syntax-errors)
    - [Type Safety](#type-safety)
    - [Concurrency Issues](#concurrency-issues)

## Introduction

Verse is a functional programming language designed for Unreal Editor for Fortnite (UEFN). It combines functional programming concepts with a strong type system and native support for concurrency.

## Language Fundamentals

### Function Calling Conventions

In Verse, the syntax for calling functions depends on their effect:

1. **Square Brackets `[]`** - Used for functions that can fail (have the `<decides>` effect):
   ```verse
   # Functions that can fail (have <decides> effect)
   Result := MayFailFunction[arg1, arg2]  # Square brackets
   if (Result?):
       # Handle success
   ```

2. **Parentheses `()`** - Used for functions that always succeed:
   ```verse
   # Functions that always succeed
   Result := AlwaysSucceeds(arg1, arg2)  # Parentheses
   ```

Common functions that use square brackets:
- Mathematical operations: `Mod[a, b]`, `a / b`, `Sqrt[x]`
- Type casting: `x as? Type`
- Array/list operations: `List.Get[0]`

### Using Directives

Use `using` statements to import modules/packages:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
```

Common namespaces:
- `/Fortnite.com/Devices` - UEFN creative devices
- `/Verse.org/Simulation` - Core simulation classes
- `/UnrealEngine.com/Temporary/Diagnostics` - Logging and debug utilities
- `/Fortnite.com/Game` - Game management classes
- `/Fortnite.com/Characters` - Character management
- `/Verse.org/Random` - Random number generation

### Comments

```verse
# This is a single-line comment

<# 
   This is a multi-line comment
   It can span multiple lines
#>

1 <# inline comment #> + 2  # Can appear between expressions

<#>
    Documentation comment
    @param param1 Description of param1
    @return Description of return value
#>
```

### Basic Types

- `logic`: Boolean values (`true`/`false`)
- `int`: 64-bit signed integer (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807)
- `float`: 64-bit floating-point number (IEEE 754)
- `string`: Unicode text with emoji support
- `message`: Localizable text with `localizes` specifier
- `void`: Indicates no useful return value
- `any`: Supertype of all types
- `comparable`: Types that can be compared for equality

Example:
```verse
MyLogic: logic = true
MyInt: int = 42
MyFloat: float = 3.14
MyString: string = "Hello 🐈"
```

### Variables and Constants

Variables must be declared with `var` and can be changed:

```verse
# Variable declaration with initialization
var MyVariable: int = 42

# Variable declaration without initialization (must specify type)
var MyVariable2: int

# Change variable value
set MyVariable = 100
```

Constants are declared without `var` and cannot be changed:

```verse
# Constant declaration (must be initialized)
MyConstant: int = 42

# Type inference with :=
MyInferredConstant := 42  # Type is inferred as int
```

Optional types:

```verse
# Empty optional
var MaybeValue: ?int = false

# Optional with value
var MaybeValue2: ?int = option{42}
```

### Type System Overview

Verse has a strong, static type system with the following characteristics:

- Every expression has a type
- Type checking occurs at compile time
- Parametric polymorphism via generics
- Subtyping via interfaces

## Control Flow

### Block Expressions

Blocks group expressions and create a scope:

```verse
Result := block:
    x := 5
    y := 10
    x + y  # Block result is 15
```

### If Expressions

If expressions evaluate conditions and return a result:

```verse
# Basic if-else
Score := 75
Status := if (Score >= 50): "Pass" else: "Fail"

# If with block
Result := if (Score >= 90):
    "Excellent"
else if (Score >= 70):
    "Good"
else:
    "Needs improvement"
```

Conditional execution with optional types:

```verse
if (Data := MaybeData?):
    # Data is now unwrapped and available
    ProcessData(Data)
else:
    # Executed when MaybeData is empty (false)
    LogError("No data available")
```

### Case Expressions

Case expressions perform pattern matching:

```verse
# Match on values
Message := case (DayOfWeek):
    0: "Sunday"
    6: "Saturday"
    _: "Weekday"  # Default case

# Match on types
Result := case (Value):
    is string: $"String: {Value}"
    is int: $"Number: {Value}"
    else: "Unknown type"
```

### Loops

Infinite loop with `break`:

```verse
Counter := 0
loop:
    if (Counter >= 5):
        break
    Print(Counter)
    set Counter += 1
```

Range-based loops:

```verse
# Loop from 0 to 4 (inclusive)
for (i := 0..4):
    Print(i)  # Prints 0, 1, 2, 3, 4
```

Collection iteration:

```verse
# Array iteration
Names := array{"Alice", "Bob", "Charlie"}
for (Name : Names):
    Print($"Hello, {Name}!")

# Map iteration
Scores := map{"Alice" => 100, "Bob" => 200}
for (Name -> Score : Scores):
    Print($"{Name}: {Score}")
```

### Failure Handling

Functions can fail with the `<fails>` specifier:

```verse
LoadConfig()<fails>: Config =
    if (not FileExists("config.json")):
        fail("Config file not found")
    return ParseConfig("config.json")
```

Handle failures with the `?` operator:

```verse
# Will execute the first branch if LoadConfig() succeeds
if (Config := LoadConfig()?):
    UseConfig(Config)
else:
    # Will execute if LoadConfig() fails
    LogError("Failed to load config")
```

Use `<decides>` for predicates:

```verse
IsValidScore(Score: int)<decides>: void =
    Score >= 0 and Score <= 100

# Usage
if (IsValidScore[UserScore]):
    # UserScore is valid
```

### Defer

Schedule cleanup code that will run when the scope exits:

```verse
ProcessFile()<suspends>: void =
    File := OpenFile("data.txt")
    defer CloseFile(File)  # Will be called when function exits
    
    # Process file...
    if (Error()):
        return  # CloseFile still called
```

## Functions

### Function Declarations

Basic function:

```verse
# Function definition
Add(A: int, B: int): int =
    A + B
    
# Function with explicit return
Max(A: int, B: int): int =
    if (A > B): A
    else: B
    
# Void function
PrintMessage(Message: string): void =
    Print(Message)
```

### Parameters

Required parameters:

```verse
Greet(Name: string): string =
    $"Hello, {Name}!"
```

Optional parameters with default values:

```verse
Greet(Name: string, Greeting: string = "Hello"): string =
    $"{Greeting}, {Name}!"
    
# Call with just required parameter
Greet("Alice")  # "Hello, Alice!"

# Call with both parameters
Greet("Bob", "Hi")  # "Hi, Bob!"
```

Named arguments:

```verse
# Function with named parameters
CreatePlayer(Name: string, ?Health: int = 100, ?Level: int = 1): player =
    # Function body

# Usage with named arguments
CreatePlayer("Alice", Level := 5)  # Health will be default value (100)
```

### Return Types

Functions must specify return type:

```verse
# Return type is int
Add(A: int, B: int): int =
    A + B
    
# Return type is void
LogMessage(Message: string): void =
    Print(Message)
```

Return statements:

```verse
FindValue(Values: []int, Target: int)<fails>: int =
    for (Index := 0..Values.Length - 1):
        if (Values[Index] = Target):
            return Index  # Explicit return
    
    fail("Value not found")  # Exit with failure
```

### Function Specifiers

Function specifiers define special behaviors:

```verse
# Function that can suspend execution
ReadFileAsync(Filename: string)<suspends>: string =
    # Asynchronous code...
    
# Function that can fail
ParseJSON(Text: string)<fails>: json =
    # Return json or fail
    
# Function that decides (predicate)
IsValidEmail(Email: string)<decides>: void =
    # Return success/failure

# Transaction support
UpdateScore(PlayerID: string, Score: int)<transacts>: void =
    # Atomic operation
```

### Generic Functions

Functions with parametric types:

```verse
# Generic identity function
Identity<T>(Value: T): T = Value

# Generic function with constraints
Max<T>(A: T, B: T): T where T: comparable =
    if (A > B): A
    else: B
```

Higher-order functions:

```verse
# Function that takes a function as parameter
ApplyOperation(X: int, Y: int, Op: (int, int) -> int): int =
    Op(X, Y)
    
# Usage
Sum := ApplyOperation(5, 3, (A, B) -> A + B)  # 8
Product := ApplyOperation(5, 3, (A, B) -> A * B)  # 15
```

## Composite Types

### Classes

Class declaration:

```verse
player_state := class:
    # Properties
    var Name: string = "Unknown"
    var Health: int = 100
    var Score: int = 0
    
    # Methods
    GainHealth(Amount: int): void =
        set Health += Amount
        
    LoseHealth(Amount: int): void =
        set Health = Max(Health - Amount, 0)
```

Public and private fields:

```verse
game_manager := class:
    # Public property
    var <public> CurrentLevel: int = 1
    
    # Private property
    var <private> ActivePlayers: []player = array{}
    
    # Private method
    RemovePlayer<private>(Player: player): void =
        # Implementation
```

Editable properties:

```verse
my_device := class(creative_device):
    # Editable in UEFN editor
    @editable var SpawnLocation: vector3 = vector3{X:=0.0, Y:=0.0, Z:=0.0}
    @editable var MaxPlayers: int = 16
```

### Interfaces

Interface declaration:

```verse
damageable := interface:
    # Interface methods (no implementation)
    TakeDamage(Amount: float): void
    GetHealth(): float
```

Implementing interfaces:

```verse
enemy := class(damageable):
    var Health: float = 100.0
    
    # Interface implementation
    TakeDamage<override>(Amount: float): void =
        set Health = Max(Health - Amount, 0.0)
        
    GetHealth<override>(): float =
        Health
```

Multiple interface implementation:

```verse
player_character := class(damageable, movable, spawnable):
    # Must implement all interface methods
```

### Subclasses

Inheritance with subclasses:

```verse
# Base class
vehicle := class:
    var Speed: float = 0.0
    
    Move(): void =
        # Base implementation
        
# Subclass
car := class(vehicle):
    var FuelLevel: float = 100.0
    
    # Override base method
    Move<override>(): void =
        # Custom implementation
```

### Constructor Patterns

Factory functions:

```verse
# Constructor pattern
MakePlayer(Name: string, InitialHealth: int = 100): player =
    player{Name := Name, Health := InitialHealth}
```

Class constructors:

```verse
player_data := class:
    Name: string
    Level: int
    
    # Constructor
    MakeNewPlayer<constructor>(PlayerName: string): player_data =
        player_data{Name := PlayerName, Level := 1}
```

### Parametric Types

Generic classes:

```verse
storage<T> := class:
    var Value: T
    
    GetValue(): T = Value
    SetValue(NewValue: T): void =
        set Value = NewValue
        
# Usage
IntStorage := storage<int>{Value := 42}
StringStorage := storage<string>{Value := "Hello"}
```

## Container Types

### Array

Arrays are ordered collections:

```verse
# Empty array
var EmptyArray: []int = array{}

# Array with values
var Numbers: []int = array{1, 2, 3, 4, 5}

# Add element
set Numbers += array{6}  # Append to array

# Access by index (0-based)
FirstNumber := Numbers[0]  # 1

# Get length
Size := Numbers.Length  # 6

# Slice array
Subset := Numbers.Slice[1, 3]  # array{2, 3}
```

Array operations:

```verse
# Check if element exists
HasThree := Numbers.Contains(3)  # true

# Find element index
ThreeIndex := Numbers.Find(3)  # 2

# Remove element
NumbersWithoutThree := Numbers.RemoveElement(2)  # array{1, 2, 4, 5, 6}

# Sort array
SortedNumbers := Numbers.Sort()
```

### Map

Maps store key-value pairs:

```verse
# Empty map
var EmptyMap: map[string]int = map{}

# Map with values
var Scores: map[string]int = map{"Alice" => 100, "Bob" => 85}

# Add/update entry
set Scores["Charlie"] = 90

# Access value
AliceScore := Scores["Alice"]  # 100

# Safe access with optional
if (BobScore := Scores.Get("Bob")?):
    Print($"Bob's score: {BobScore}")

# Check if key exists
HasAlice := Scores.ContainsKey("Alice")  # true

# Remove key
ScoresWithoutAlice := Scores.RemoveKey("Alice")
```

### Tuple

Tuples group values of different types:

```verse
# Define a tuple
Position: (float, float) = (10.5, 20.0)

# Access elements
X := Position.0  # 10.5
Y := Position.1  # 20.0

# Destructure tuple
(X2, Y2) := Position
```

### Set

Sets contain unique values:

```verse
# Empty set
var EmptySet: set[int] = set{}

# Set with values
var UniqueNumbers: set[int] = set{1, 2, 3}

# Add element
set UniqueNumbers.Add(4)

# Check if element exists
HasTwo := UniqueNumbers.Contains(2)  # true

# Remove element
set UniqueNumbers.Remove(2)

# Set operations
OtherSet := set{3, 4, 5}
Union := UniqueNumbers.Union(OtherSet)  # set{1, 3, 4, 5}
Intersection := UniqueNumbers.Intersection(OtherSet)  # set{3, 4}
```

### Option

Options represent values that may or may not exist:

```verse
# Empty option
var MaybeValue: ?int = false

# Option with value
var MaybeNumber: ?int = option{42}

# Check if option has value
if (MaybeNumber?):
    # Option has value
    
# Safe unwrap with default
Number := MaybeNumber ?: 0  # 42 if has value, 0 if empty

# Extract value if present
if (Value := MaybeNumber?):
    Print($"Value: {Value}")
```

## Concurrency

### Suspending Functions

Functions that may pause execution:

```verse
LoadData()<suspends>: data =
    # Function can suspend and resume later
    Sleep(1.0)  # Pause for 1 second
    return FetchData()
```

### Async/Await Pattern

Sequential asynchronous code:

```verse
ProcessData()<suspends>: result =
    # These execute sequentially
    RawData := await FetchData()
    CleanData := await CleanData(RawData)
    return await AnalyzeData(CleanData)
```

### Spawn

Create concurrent tasks:

```verse
# Spawn concurrent tasks
Task1 := spawn LongOperation1()
Task2 := spawn LongOperation2()

# Wait for results
Result1 := await Task1
Result2 := await Task2
```

### Task Management

Manual task management:

```verse
# Create background task
BackgroundTask := task:
    while (true):
        # Background work
        Sleep(1.0)

# Later, when done
BackgroundTask.Cancel()
```

### Race and Any

Run tasks concurrently and get first result:

```verse
# Use first result from any task
FirstResult := race:
    await SlowOperation1()
    await SlowOperation2()
    
# Alternatively with any
FirstResult := await any(
    spawn Operation1(),
    spawn Operation2()
)
```

### Time Functions

Time-related operations:

```verse
# Sleep for specific duration
Sleep(2.5)  # Pause for 2.5 seconds

# Run with timeout
Result := await with_timeout(5.0, LongOperation())
if (Result is Timeout):
    Print("Operation timed out")
```

### Timeouts

Handle timeouts:

```verse
FetchWithTimeout()<suspends><fails>: data =
    Result := await with_timeout(10.0, FetchData())
    if (Result is Timeout):
        fail("Fetch operation timed out")
    return Result.Get()
```

## Common UEFN Patterns

### Device Setup

Basic device implementation:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

my_device := class(creative_device):
    # Editable properties
    @editable var TargetDevice: creative_device = creative_device{}
    
    # Initialize when device is created
    OnBegin<override>()<suspends>: void =
        # Subscribe to events
        TargetDevice.ActivatedEvent.Subscribe(OnTargetActivated)
        
    # Event handler
    OnTargetActivated(Agent: agent): void =
        # Handle activation
        Log("Device activated")
```

### Event Handling

Subscribe to events:

```verse
# Define an event
var PlayerJoinedEvent: event(player) = event(player){}

# Subscribe to the event
PlayerJoinedEvent.Subscribe(OnPlayerJoined)

# Event handler
OnPlayerJoined(Player: player): void =
    # Handle player joining
    
# Trigger the event
PlayerJoinedEvent.Signal(NewPlayer)
```

Device events:

```verse
# Connect to UEFN device events
ButtonDevice.ActivatedEvent.Subscribe(OnButtonActivated)
TriggerDevice.TriggeredEvent.Subscribe(OnTriggerEntered)

# Game lifecycle events
GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerJoined)
GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerLeft)
```

### Player Management

Player tracking:

```verse
# Store active players
var Players: []player = array{}

# Add player
AddPlayer(Player: player): void =
    set Players += array{Player}
    
# Remove player
RemovePlayer(Player: player): void =
    if (Index := Players.Find(Player)?):
        set Players = Players.RemoveElement(Index)
```

### Game Flow

Game state management:

```verse
# Game states
GameState := enum:
    Lobby
    Playing
    GameOver

# Current state
var CurrentState: GameState = GameState.Lobby

# State transitions
StartGame(): void =
    if (CurrentState = GameState.Lobby):
        set CurrentState = GameState.Playing
        SpawnPlayers()
        
EndGame(): void =
    if (CurrentState = GameState.Playing):
        set CurrentState = GameState.GameOver
        ShowResults()
```

## Debugging and Performance

### Logging

Basic logging:

```verse
using { /UnrealEngine.com/Temporary/Diagnostics }

# Print to debug console
Print("Debug message")

# Log with context
Log("Player joined: {PlayerName}")
```

### Profiling

Performance profiling:

```verse
# Profile block of code
Profile:
    # Code to profile
    ExpensiveOperation()
```

### Common Errors

Null safety:

```verse
# Unsafe - may cause null reference
PlayerHealth := Player.Health

# Safe - check for null
if (Player?):
    PlayerHealth := Player.Health
```

Type safety:

```verse
# Type mismatch
var Score: int = "100"  # Error

# Correct type
var Score: int = 100
```

## Persistence

### Creating Persistable Data

Use `weak_map` with a `player` key to create data that persists across game sessions:

```verse
# Basic persistable data
var PlayerScores:weak_map(player, int) = map{}

# Complex data structure
player_profile := struct{
    PlayerName: string
    HighScore: int
    LastPlayed: datetime
}
var PlayerProfiles:weak_map(player, player_profile) = map{}
```

### Initializing Player Data

Always check if data exists before initializing:

```verse
OnBegin<override>()<suspends>:void =
    Players := GetPlayspace().GetPlayers()
    for (Player := Players):
        if not (PlayerScores[Player]?):
            PlayerScores[Player] := 0  # Default score
```

### Best Practices

1. **Data Size**: Be mindful of storage limits per player and island
2. **Backward Compatibility**: Maintain compatibility with existing save data
3. **Validation**: Always validate loaded data
4. **Default Values**: Set sensible defaults for new players
5. **Cleanup**: Remove old player data when no longer needed

```verse
# Example of data cleanup
RemovePlayerData(Player: player): void =
    if (PlayerScores[Player]?):
        PlayerScores.Remove(Player)
```

## Common Pitfalls

### Syntax Errors

Incorrect function declaration:

```verse
# Wrong - missing return type
MyFunction() = 42

# Correct
MyFunction(): int = 42
```

Missing argument types:

```verse
# Wrong - no parameter type
Process(data) = data

# Correct
Process(Data: player_data): player_data = Data
```

### Type Safety

Incorrect option handling:

```verse
# Wrong - not checking if option has value
Score := MaybeScore  # Error

# Correct
if (Score := MaybeScore?):
    # Use Score
```

### Concurrency Issues

Race conditions:

```verse
# Potential race condition
spawn:
    set Counter += 1
spawn:
    set Counter += 1

# Better approach
CounterLock.Acquire()
set Counter += 1
CounterLock.Release()
```

Missing await:

```verse
# Wrong - not awaiting result
Result := FetchDataAsync()  # Result is a task, not the data

# Correct
Result := await FetchDataAsync()  # Result is the data
```

---

## Additional Resources

- [Verse Language Documentation](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Unreal Editor for Fortnite (UEFN) Documentation](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-documentation)
- Verse Standard Library: See Verse.digest.verse
- Fortnite API: See Fortnite.digest.verse
- Unreal Engine API: See UnrealEngine.digest.verse
