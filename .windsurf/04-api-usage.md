---
description: 
globs: 
alwaysApply: true
---

# API Usage Guidelines

## API Verification Protocol

### Before Implementation
1. **Search** all digest files for relevant APIs
2. **Document** exact API signatures found
3. **Verify** parameter types and return values
4. **Check** for usage examples in the codebase

### When Using APIs
1. **Quote** the exact API definition from digest files
2. **Show** where the API is defined
3. **Explain** how it solves the current problem
4. **Handle** all possible return values

## Common API Patterns

### Map Operations
```verse
# Safe access
if value := Map[Key]?:
    # Use value

# Safe update
if Map.Add(Key, Value)?:
    # Successfully added

# Safe removal
if Map.Remove(Key)?:
    # Successfully removed
```

### Error Handling
```verse
# Check for failure case
if not SomeOperation()?:
    # Handle error
    return
```

## API Documentation Format

### For Each API Used
1. **Source**: `Filename.digest.verse`
2. **Signature**: `functionName(param: Type): ReturnType`
3. **Usage**: Brief description with example
4. **Errors**: Possible error conditions
5. **Notes**: Any special considerations

## When No API Is Found
1. Document your search process
2. List the files you checked
3. Describe the functionality needed
4. Propose alternatives or request guidance

## Performance Considerations
1. Cache frequently accessed values
2. Batch operations when possible
3. Avoid redundant API calls
4. Use appropriate data structures
