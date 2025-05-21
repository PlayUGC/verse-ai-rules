# Code Verification Checklist

## Function Calls
- [ ] Functions with `<decides>` effect use square brackets `[]`
  - Example: `Result := Mod[a, b]`
- [ ] Regular functions use parentheses `()`
  - Example: `Length := Len("string")`
- [ ] All potential failures are handled
  - Use `?` operator or explicit checks

## Type Safety
- [ ] All variables have explicit types
- [ ] Option types are properly handled with `?` or `?:`
- [ ] Type conversions are explicit and safe
- [ ] No `any` or untyped variables unless absolutely necessary

## Error Handling
- [ ] All possible error cases are handled
- [ ] Error messages are clear and helpful
- [ ] No silent failures
- [ ] Resources are properly cleaned up

## Performance
- [ ] No unnecessary computations in loops
- [ ] Appropriate data structures are used
- [ ] Memory usage is optimized
- [ ] No memory leaks

## UI Elements
- [ ] All required imports are included
- [ ] UI elements are properly initialized
- [ ] Event handlers are properly connected
- [ ] Memory management is handled correctly

## Common Issues to Check
- [ ] All required using directives are present
- [ ] Option types are properly initialized
- [ ] Mathematical operations handle division by zero
- [ ] Array/collection indices are within bounds
- [ ] No infinite loops or potential deadlocks

## Before Committing
- [ ] All tests pass
- [ ] Code is properly formatted
- [ ] No commented-out code remains
- [ ] All changes are properly documented

## Common Patterns

### Safe Function Calls
```verse
# Safe function call with error handling
if (Result := MayFail[args]?):
    # Handle success
else:
    # Handle failure

# Safe unwrap with default
Value := MaybeValue ?: DefaultValue
```

### Option Type Handling
```verse
# Initialize option types
var MaybeValue: ?int = none  # Empty option
var MaybeNumber: ?int = some(42)  # Option with value

# Safe access
if (Value := MaybeNumber?):
    # Use Value
```

### Mathematical Operations
```verse
# Safe division
SafeDivision := (a / b) ?: 0

# Safe modulo
if (Mod[a, b] = 0):
    # Handle multiple
```

## Quick Reference

### Common Imports
```verse
using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
```

### Common Types
- `int`, `float`, `string`, `bool` - Basic types
- `?type` - Optional type (e.g., `?int`)
- `[type]` - Array (e.g., `[int]`)
- `{key:type}` - Map (e.g., `{string:int}`)
- `(type1, type2)` - Tuple (e.g., `(int, string)`)
