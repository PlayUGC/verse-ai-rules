# Cursor AI Rules Documentation

This directory contains rules and templates for the Cursor AI assistant to follow when helping with this project.

## Available Templates

### Feature Request Template (07-feature-request-template.mdc)
Use this template when requesting a new feature implementation. The AI will:
1. Break down your feature request into components
2. Ask clarifying questions
3. Propose a technical approach
4. Create a step-by-step implementation plan
5. Implement each step with your approval

### How to Use
To use the feature request template, start your message with:
```
Help me implement a feature: [describe your feature]
```

Example:
```
Help me implement a feature: Create a countdown timer that awards XP every 2 minutes
```

The AI will then follow the structured approach defined in the template to analyze, plan, and implement your feature request.

## Development Workflow
For regular development tasks that don't require the full feature request template, simply describe what you need. The AI will still use the other rules in this directory to guide its responses. 