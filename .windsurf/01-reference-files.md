---
description: 
globs: 
alwaysApply: true
---
# Reference Files Guide

## Core Reference Files

| File | When to Use | Description |
|------|-------------|-------------|
| **verse-patterns.md** | First check for implementation | Comprehensive patterns for Verse/UEFN development |
| **verse-common-errors.md** | Before implementing new features | Common errors and their solutions |
| **verification-checklist.md** | Before committing changes | Code quality and correctness checklist |
| **verse-reference.md** | Language reference | Complete Verse language reference |
| **verse-code-database.md** | Real-world examples | Solutions and patterns from user's projects |

## File Reference Order

1. **For new implementations**:
   - Check `verse-patterns.md` for relevant patterns
   - Review `verse-common-errors.md` for potential issues
   - Verify against `verification-checklist.md`
   - Search `verse-code-database.md` for examples

2. **For language questions**:
   - Check `verse-reference.md` first
   - Cross-reference with `verse-patterns.md`
   - Verify against `verse-code-database.md`

3. **For errors**:
   - Check `verse-common-errors.md` first
   - Review `verification-checklist.md`
   - Search `verse-code-database.md` for similar issues

4. **Before committing**:
   - Run through `verification-checklist.md`
   - Verify against `verse-patterns.md`
   - Check for common errors in `verse-common-errors.md`

## Pattern Usage

1. **UI Development**:
   - Use HUD Controller pattern from `verse-patterns.md`
   - Follow UI error prevention from `verse-common-errors.md`
   - Verify UI elements against `verification-checklist.md`

2. **Game Logic**:
   - Use Game State patterns from `verse-patterns.md`
   - Follow event handling patterns
   - Verify against `verse-common-errors.md`

3. **Player Management**:
   - Use Player Management patterns from `verse-patterns.md`
   - Follow player event handling patterns
   - Verify against `verification-checklist.md`

> **Note**: Always prefer local reference files over general knowledge. If a local file exists for a topic, use it as the primary source of truth.
