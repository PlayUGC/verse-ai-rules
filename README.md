# 🚀 Verse AI Assistant Rules

✨ Supercharge your UEFN (Unreal Editor for Fortnite) development with AI-powered assistance for the Verse programming language! This repository provides comprehensive reference materials to help AI assistants generate accurate, idiomatic Verse code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![UEFN](https://img.shields.io/badge/UEFN-00A3FF?logo=unrealengine&logoColor=white)](https://dev.epicgames.com/community/learning/tutorials/1D/unreal-engine-intro-to-uefn)
[![Verse](https://img.shields.io/badge/Verse-FF6B6B?logo=code&logoColor=white)](https://dev.epicgames.com/community/learning/courses/1D/unreal-engine-intro-to-verse)

## 🤔 About This Project

Verse is a relatively new programming language, and UEFN is an emerging platform. This presents unique challenges for AI-assisted development:

1. **Limited Training Data**: As a new language, there's less publicly available Verse code for AI models to learn from.
2. **Platform Complexity**: UEFN's specific implementation details and best practices are still being established.
3. **Accuracy Concerns**: Without proper context, AI models may generate incorrect or inefficient code that doesn't follow Verse's paradigms.
4. **Lack of Specialized Models**: There are currently no widely-available AI models specifically fine-tuned for Verse development.

To address these challenges, we've created a comprehensive set of reference materials to guide AI assistants in generating high-quality Verse code.

## 📚 What's Included

This repository contains several carefully crafted resources for Verse development in UEFN:

### Core Reference Files
- **.verseRules/verse-reference.md**: Comprehensive Verse language reference
- **.verseRules/verse-patterns.md**: Common implementation patterns and best practices
- **.verseRules/verse-common-errors.md**: Solutions to frequent Verse programming issues
- **.verseRules/verification-checklist.md**: Code quality and correctness checklist

### AI Configuration
- **.cursor/** - Configuration for Cursor IDE
  - Rules for code generation and assistance
  - Development workflow guidelines
  - API usage patterns
  - Error handling strategies
  - Software engineering best practices
  - Feature request template

- **.windsurf/** - Configuration for Windsurf IDE (mirrors .cursor/)
  - Same structure as .cursor/ for compatibility with Windsurf

### Development Tools
- **.verseRules/setup-ai-assistant.ps1**: PowerShell script for initial setup (if needed)
- **.verseRules/feature-request-example.md**: Template for submitting feature requests

## 🚀 Quick Start

1. **📥 Download or clone the repository**
   ```bash
   git clone https://github.com/PlayUGC/verse-ai-rules.git
   ```

2. **💻 Open your UEFN project's code-workspace**
   - Launch Windsurf or Cursor IDE
   - Open your UEFN project's workspace

3. **🛠 Install the rules**
   - Drag the `.cursor` folder into your project (for Cursor users) OR
   - Drag the `.windsurf` folder into your project (for Windsurf users)
   - Also drag in the `.verseRules` folder which contains additional Verse-specific rules and references

4. **🤖 Start coding with AI assistance**
   - The AI will now use these reference materials when helping with Verse development
   - You'll get consistent, idiomatic Verse code following UEFN best practices
   - The AI will reference the appropriate patterns and error prevention techniques

## 🔍 Reference Hierarchy

The AI will check these resources in the following order:

1. **.verseRules/verse-reference.md** - Language reference and syntax
2. **.verseRules/verse-patterns.md** - Implementation patterns and best practices
3. **.verseRules/verse-common-errors.md** - Common issues and solutions
4. **.verseRules/verification-checklist.md** - Code quality standards
5. **.digest.verse files** - UEFN API references (automatically included in projects)

This structured approach ensures accurate, consistent code generation with proper error handling and best practices.

## ✨ Benefits

- **Dual IDE Support**: Works with both Cursor and Windsurf IDEs
- **Structured Development**: Clear guidelines for feature implementation and task breakdown
- **Comprehensive Coverage**: All common Verse programming patterns and error scenarios
- **Improved Accuracy**: Structured reference materials improve AI's understanding of Verse
- **Consistent Style**: Ensures code follows established Verse conventions
- **Error Prevention**: Built-in verification checklists and common error references

## 🛠 Troubleshooting

### 🔒 PowerShell Execution Policy Error
If you see an error about the script not being digitally signed, you'll need to change your PowerShell execution policy:

1. **Recommended Method (Temporary for current session)**:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\.verseRules\setup-ai-assistant.ps1
   ```

2. **For Current User (Permanent)**:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
   Then try running the script again.

### 🔍 Common Issues

- **AI not recognizing the rules**
  - Make sure you've dragged the correct folder (`.cursor/` or `.windsurf/`) into your project
  - Verify that the `.verseRules` folder is also in your project root
  - Restart your IDE after adding the rules

- **Missing files**
  - Ensure you've cloned the entire repository
  - Check that all files are properly extracted if downloaded as a ZIP

- **Rules not applying**
  - Verify your IDE has the necessary permissions to access the rule files
  - Check for any error messages in your IDE's output console
  - Make sure you're using a compatible version of Cursor or Windsurf
