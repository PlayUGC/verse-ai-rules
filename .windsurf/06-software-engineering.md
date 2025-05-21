---
description: 
globs: 
alwaysApply: true
---

# Game Development Best Practices

## Task Breakdown & Communication

For all feature requests, first review and follow the template at `.windsurf/07-feature-request-template.md` to ensure comprehensive planning and documentation.

### 1. Task Analysis
- **Understand Requirements**
  - Clarify ambiguous requirements before starting
  - Identify edge cases and special conditions
  - Consider performance implications

- **Break Down Tasks**
  - Split work into small, testable units (1-2 hour tasks)
  - Define clear acceptance criteria for each task
  - Identify dependencies between tasks

### 2. Communication Protocol
- **Initial Plan**
  ```
  1. Task: [Brief description]
  2. Approach: [High-level solution]
  3. Subtasks:
     - [ ] Subtask 1
     - [ ] Subtask 2
  4. Potential Risks: [Any concerns or unknowns]
  ```

- **Progress Updates**
  - Share progress after completing each subtask
  - Flag blockers immediately
  - Request feedback on implementation decisions

## Code Quality Standards

### 1. Code Organization
- **File Structure**
  - Group related functionality together
  - Keep files focused and single-purpose
  - Follow project naming conventions

- **Function Design**
  - Single Responsibility Principle
  - Maximum 3 parameters per function
  - Keep functions under 20 lines when possible

### 2. Performance Considerations
- **Memory Management**
  - Cache frequently accessed values
  - Avoid allocations in update loops
  - Use object pooling for frequently created/destroyed objects

- **Optimization**
  - Profile before optimizing
  - Focus on critical paths first
  - Document performance-sensitive code

## Game-Specific Best Practices

### 1. Game Loop & Updates
- Separate fixed-update from render-update logic
- Use delta time for frame-rate independent movement
- Implement time-scaling for pause/slow-motion

### 2. Event System
- Use events for loose coupling between systems
- Implement proper event cleanup
- Consider event priorities when order matters

### 3. State Management
- Keep game state separate from rendering
- Implement proper state saving/loading
- Handle game pause/resume gracefully

## Testing Strategy

### 1. Unit Testing
- Test individual components in isolation
- Mock external dependencies
- Test edge cases and error conditions

### 2. Integration Testing
- Test component interactions
- Verify save/load functionality
- Test multiplayer synchronization

### 3. Playtesting
- Test on target hardware
- Gather performance metrics
- Document reproduction steps for bugs

## Documentation Standards

### 1. Code Comments
- Use `#` for single-line comments
- Document complex algorithms
- Explain "why" not just "what"

### 2. API Documentation
- Document public interfaces
- Include usage examples
- Note any side effects or limitations

### 3. Changelog
- Track significant changes
- Reference related issues
- Note breaking changes

## Collaboration Guidelines

### 1. Code Reviews
- Review for both correctness and maintainability
- Suggest improvements constructively
- Keep feedback specific and actionable

### 2. Version Control
- Write clear, concise commit messages
- Keep commits focused and atomic
- Use meaningful branch names

### 3. Knowledge Sharing
- Document architectural decisions
- Share learnings with the team
- Create onboarding documentation

## Performance Checklist

### Before Committing:
- [ ] No debug logging in production code
- [ ] All assets are properly optimized
- [ ] No memory leaks
- [ ] Frame rate is stable
- [ ] Build times are reasonable

## When in Doubt
1. Check the style guide
2. Look for similar patterns in the codebase
3. Ask for a code review
4. Document the decision for future reference
