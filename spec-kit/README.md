# Spec-Kit Usage Examples

This document provides usage examples for using [GitHub's Spec-Kit](https://github.com/github/spec-kit) with different AI coding assistants. Currently with **43.7k+ GitHub Stars**, Spec-Kit represents GitHub's official solution to standardize Specification-Driven Development (SDD).

## Overview

Spec-Kit is GitHub's official toolkit that revolutionizes AI programming by addressing the "vibe-coding crisis". Instead of relying on random, ambiguous prompts that force AI to guess your requirements, Spec-Kit provides a structured, specification-driven approach that transforms unstable "what" into executable specifications, ensuring AI generates exactly what you need rather than generic solutions.

## Architecture

Spec-Kit operates through a sophisticated template and script system:

### File Structure Created
```
.specify/
├── scripts/
│   ├── bash/           # Linux/macOS scripts
│   └── ps/             # PowerShell scripts
├── templates/
│   ├── spec-template.md
│   ├── plan-template.md
│   └── constitution.md
├── memory/             # Context and state management
└── feature-branches/   # Automatic branch management
```

### Command Processing Pipeline
1. **Template Loading**: Each command loads corresponding Markdown templates
2. **Placeholder Resolution**: `[ALL_CAPS_IDENTIFIER]` placeholders filled with context
3. **Script Execution**: Bash/PowerShell scripts handle Git operations and file management
4. **Content Generation**: AI fills templates with structured, consistent content
5. **Version Control**: Automatic semantic versioning and branch management

## Installation

The test scripts in this directory automatically install all prerequisites and Spec-Kit when needed. Simply run:

```bash
# Test with Claude Code (auto-installs everything)
./test-claude.sh

# Test with Codex CLI (auto-installs everything)
./test-codex.sh

# Test with Qwen Code (auto-installs everything)
./test-qwen.sh
```

The test scripts will automatically:
- Install `uv` package manager if not found
- Install `pip` if not found
- Install `specify-cli` from PyPI (preferred) or GitHub (fallback)
- Install the corresponding AI assistant (Claude Code, Codex CLI, or Qwen Code) if not found
- Set up proper PATH configuration
- Verify all installations

## Quick Start Guide

### 1. Install Spec-Kit

#### Option A: Automatic Installation (Recommended for Testing)

Run the test scripts - they automatically install everything:

```bash
# Test with Claude Code (auto-installs prerequisites, Spec-Kit, and Claude Code)
./test-claude.sh

# Or test with other AI assistants (auto-installs everything)
./test-codex.sh  # Auto-installs Codex CLI
./test-qwen.sh    # Auto-installs Qwen Code
```

The test scripts automatically install:
- All prerequisites (`uv`, `pip`)
- Spec-Kit (`specify-cli`)
- The corresponding AI assistant (Claude Code, Codex CLI, or Qwen Code)

#### Option B: Manual Installation

Install Spec-Kit manually:

```bash
# PyPI installation (recommended)
pip install specify-cli

# Or using uv
uv pip install specify-cli

# Alternative: Install from GitHub
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# One-time usage without installation
uvx --from git+https://github.com/github/spec-kit.git specify init <PROJECT_NAME>
```

### 2. Initialize Project
```bash
specify init my-taskify-app --ai claude
```

### 3. Follow the Workflow
Open your project in your chosen AI assistant and execute the slash commands in sequence:

```
/speckit.constitution   # Define project principles (optional)
/speckit.specify       # Describe what to build
/speckit.clarify       # Clarify requirements (optional)
/speckit.plan          # Define technical approach
/speckit.analyze       # Quality check (optional)
/speckit.tasks         # Generate task breakdown
/speckit.implement     # Execute implementation
```

## Supported AI Assistants

Spec-Kit supports a comprehensive range of AI coding assistants:

- **Claude Code** ✅ (Recommended - Full support)
- **GitHub Copilot** ✅
- **Cursor** ✅
- **Gemini CLI** ✅
- **Codex CLI** ✅
- **Qwen Code** ✅
- And many others

## Usage Examples by AI Assistant

### 1. Claude Code (Recommended)

Claude Code offers the most comprehensive integration with Spec-Kit's spec-driven workflow and is GitHub's recommended choice.

#### Initialize a new project with Claude Code:
```bash
specify init my-photo-app --ai claude
```

#### Core Spec-Kit Commands Available:
Once your project is initialized, you'll have access to these essential slash commands:

**Core Workflow Commands:**
```
/speckit.constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements

/speckit.specify Build an application that can help me organize my photos in separate photo albums. Albums are grouped by date and can be re-organized by dragging and dropping on the main page.

/speckit.plan The application uses React with TypeScript and minimal dependencies. Use modern CSS Grid for layouts and local storage for data persistence.

/speckit.tasks

/speckit.implement
```

**Optional Quality Assurance Commands:**
```
/speckit.clarify    # Clarify underspecified requirements before planning
/speckit.analyze    # Analyze consistency and coverage after tasks, before implementation
/speckit.checklist  # Generate quality validation checklists
```

#### Complete Claude Code Workflow Example:
```bash
# 1. Initialize project
specify init photo-organizer --ai claude

# 2. Navigate to project
cd photo-organizer

# 3. Open with Claude Code and follow the structured workflow:
```

**In Claude Code interface:**
```
# Step 1: Define project governance (optional but recommended)
/speckit.constitution Create principles for photo management app focusing on privacy, performance, and intuitive UX

# Step 2: Create detailed specification (5 minutes)
/speckit.specify Create a photo organization app with albums grouped by date, drag-and-drop reordering, and tile-based photo previews

# Step 3: Optional clarification for complex requirements
/speckit.clarify

# Step 4: Define technical implementation plan (5 minutes)
/speckit.plan Use Vite with minimal libraries, vanilla HTML/CSS/JavaScript, local SQLite for metadata storage

# Step 5: Generate executable tasks (5 minutes)
/speckit.tasks

# Step 6: Optional quality assurance check
/speckit.analyze

# Step 7: Execute implementation
/speckit.implement
```

**Time Investment:** 15-30 minutes of specification vs. traditional 12+ hours of documentation

### 2. GitHub Copilot

GitHub Copilot integrates seamlessly with Spec-Kit for enterprise-grade development workflows.

#### Initialize a new project with GitHub Copilot:
```bash
specify init my-api-service --ai copilot
```

#### Example workflow with GitHub Copilot:
```bash
# 1. Initialize project
specify init user-api --ai copilot

# 2. Navigate to project
cd user-api

# 3. Use GitHub Copilot with slash commands:
```

**In GitHub Copilot interface:**
```
/speckit.constitution Create principles for API design, security standards, performance requirements, and testing practices

/speckit.specify Build a REST API service for managing user accounts with authentication, profile management, and role-based access control

/speckit.plan Use Node.js with Express, PostgreSQL database, JWT authentication, and comprehensive API documentation with OpenAPI/Swagger

/speckit.tasks

/speckit.implement
```

### 3. Cursor

Cursor provides excellent support for Spec-Kit's structured development approach.

#### Initialize a new project with Cursor:
```bash
specify init my-dashboard --ai cursor
```

#### Example workflow with Cursor:
```bash
# 1. Initialize project
specify init analytics-dashboard --ai cursor

# 2. Navigate to project
cd analytics-dashboard

# 3. Work with Cursor using the spec-driven approach
```

**In Cursor interface:**
```
/speckit.constitution Establish principles for dashboard design, data visualization best practices, responsive design, and accessibility standards

/speckit.specify Create an analytics dashboard that displays real-time metrics, allows filtering by date ranges, and provides exportable reports with charts and graphs

/speckit.plan Use Vue.js 3 with Composition API, Chart.js for visualizations, Tailwind CSS for styling, and mock API endpoints for development

/speckit.tasks

/speckit.implement
```

### 4. Other Supported AI Assistants

#### Gemini CLI
```bash
specify init my-project --ai gemini
```

#### Qwen Code
```bash
specify init my-dashboard --ai qwen
```

#### Codex CLI
```bash
specify init my-service --ai codex
```

All supported AI assistants follow the same structured workflow and command patterns, ensuring consistency across different development environments.

## The Complete Spec-Kit Workflow

Spec-Kit implements a rigorous 4-stage workflow with optional quality assurance steps. Each stage has specific responsibilities and must be fully validated before proceeding to the next.

### Core 4-Stage Workflow

#### 1. **Specify** (`/speckit.specify`) - *What & Why*
**Focus:** High-level requirements description
- Describe what you want to build and why
- Focus on user experience and business requirements
- **Avoid** technical implementation details
- **Output:** Structured specification document with user stories and acceptance criteria

**Example:**
```
/speckit.specify Create a real-time chat system with message history and user online status indicators
```

#### 2. **Plan** (`/speckit.plan`) - *How & With What*
**Focus:** Technical implementation strategy
- Define your tech stack and architectural choices
- Set technical constraints and dependencies
- **Output:** Comprehensive technical plan, API contracts, data models

**Example:**
```
/speckit.plan Use WebSocket for real-time messaging, PostgreSQL for message history, Redis for online status management
```

#### 3. **Tasks** (`/speckit.tasks`) - *Step-by-Step Breakdown*
**Focus:** Actionable task decomposition
- Convert specifications and plans into implementable tasks
- Each task must be independently testable
- **Output:** Numbered task list (T001, T002, etc.) with dependencies and file paths

#### 4. **Implement** (`/speckit.implement`) - *Execution*
**Focus:** Systematic code implementation
- Execute tasks in dependency order
- Follow Test-Driven Development (TDD) principles
- **Output:** Working, tested implementation

### Optional Quality Assurance Steps

#### **Constitution** (`/speckit.constitution`) - *Project Governance*
**When:** Before Specify stage
**Focus:** Establish project principles and development guidelines
- Code quality standards and testing requirements
- Performance benchmarks and security considerations
- Design system constraints and architectural principles

**Example:**
```
/speckit.constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements
```

#### **Clarify** (`/speckit.clarify`) - *Requirements Refinement*
**When:** After Specify, before Plan
**Focus:** Structured clarification of ambiguous requirements
- Systematic scanning for gaps and ambiguities
- Interactive Q&A to resolve unclear specifications
- **Limit:** Maximum 5 high-priority questions
- **Output:** Updated specification with clarifications section

#### **Analyze** (`/speckit.analyze`) - *Quality Assurance*
**When:** After Tasks, before Implement
**Focus:** Cross-document consistency and coverage analysis
- Detect duplicates, ambiguities, and specification gaps
- Verify Constitution alignment and task coverage
- **Mode:** Read-only analysis with actionable recommendations
- **Output:** Structured quality report with severity ratings (CRITICAL/HIGH/MEDIUM/LOW)

#### **Checklist** (`/speckit.checklist`) - *Validation Framework*
**When:** Throughout the process
**Focus:** Generate quality validation checklists
- Custom validation criteria based on project requirements
- Ensures adherence to established principles and standards

## Real-World Performance Comparison

### Traditional Development Workflow:
- **Product Requirements Document:** 2-3 hours
- **Design Documentation:** 2-3 hours
- **Project Structure Setup:** 30 minutes
- **Technical Specification:** 3-4 hours
- **Test Planning:** 2 hours
- **Total:** ~12 hours

### Spec-Kit Workflow:
- **Specify:** 5 minutes (with natural language)
- **Plan:** 5 minutes (with technical constraints)
- **Tasks:** 5 minutes (auto-generated)
- **Total:** ~15 minutes

**Result:** Complete specifications, implementation plans, API contracts, data models, and test scenarios - all properly version-controlled in feature branches.

## Advanced Configuration Options

### PowerShell Support (Windows)
```bash
specify init my-project --ai claude --script ps
```

### Initialize in Current Directory
```bash
specify init . --ai claude
# or
specify init --here --ai claude
```

### Skip Git Initialization
```bash
specify init my-project --ai claude --no-git
```

### Debug Mode
```bash
specify init my-project --ai claude --debug
```

## Environment Variables

Set `SPECIFY_FEATURE` when working outside Git repositories:
```bash
export SPECIFY_FEATURE=001-user-authentication
```

For Windows PowerShell:
```powershell
$env:SPECIFY_FEATURE = "001-user-authentication"
```

## When to Use Spec-Kit

### ✅ Ideal Scenarios

#### 1. **Greenfield Projects (0 to 1)**
Starting new projects from scratch where upfront specification prevents costly architectural mistakes and ensures AI builds exactly what you need.

#### 2. **Feature Development in Existing Systems (N to N+1)**
The **most advantageous scenario** for Spec-Kit. Adding features to complex codebases becomes systematic:
- Clear specification defines integration with existing systems
- Architectural constraints ensure new code fits natively rather than as "plugins"
- Maintains consistency with established project patterns

#### 3. **Legacy System Modernization**
Refactoring legacy systems where original design intent is lost:
- Modern specifications clarify key business logic
- Clean architectural design in the planning phase
- AI rebuilds systems from scratch, avoiding inherited technical debt

### ❌ Less Suitable Scenarios

#### 1. **Rapid Prototyping/Validation**
Quick proof-of-concept development where comprehensive specification overhead exceeds benefits.

#### 2. **Highly Exploratory/Innovative Projects**
When requirements are unclear and need extensive experimentation, standardized workflows may constrain necessary creative exploration.

#### 3. **Simple Personal Tools**
Individual small-scale utility projects where process overhead outweighs development benefits.

## Key Benefits of Specification-Driven Development

- **🎯 Predictable Outcomes**: Transform vague requirements into executable specifications
- **⚡ Dramatic Time Savings**: 15 minutes vs. 12+ hours for comprehensive project setup
- **🔧 AI-Native Design**: Built specifically for AI-assisted development workflows
- **🏗️ Technology Agnostic**: Works with any tech stack or development environment
- **📈 Scalable Quality**: Consistent quality standards across teams and projects
- **🔄 Iterative Enhancement**: Supports both greenfield and brownfield development
- **📚 Living Documentation**: Specifications serve as always-current project documentation
- **🤝 Cross-AI Compatibility**: Same workflow across Claude, Copilot, Cursor, and other AI assistants

## Testing Spec-Kit

This directory contains test scripts for verifying Spec-Kit functionality with different AI coding assistants on Ubuntu. The test scripts **automatically install all prerequisites** when needed.

### Test Scripts

#### Individual Test Scripts

- **`test-claude.sh`** - Tests Spec-Kit initialization and structure with Claude Code
- **`test-codex.sh`** - Tests Spec-Kit initialization and structure with Codex CLI
- **`test-qwen.sh`** - Tests Spec-Kit initialization and structure with Qwen Code

### Automatic Installation

The test scripts automatically handle installation of all prerequisites:

- ✅ **Python 3.11+** - Checks version and exits if not met (manual installation required)
- ✅ **uv** package manager - Automatically installs if not found
- ✅ **pip** - Automatically installs if not found
- ✅ **Git** - Checks availability (manual installation required if not found)
- ✅ **specify-cli** - Automatically installs from PyPI or GitHub
- ✅ **AI Assistant** - Automatically installs the corresponding AI assistant:
  - `test-claude.sh` attempts to install Claude Code (via PyPI, npm, or GitHub)
  - `test-codex.sh` attempts to install Codex CLI (via PyPI, npm, or GitHub)
  - `test-qwen.sh` attempts to install Qwen Code (via PyPI, npm, or GitHub)
- ✅ **PATH configuration** - Automatically sets up PATH for installed tools

### Running Tests

```bash
# Test with Claude Code
./test-claude.sh

# Test with Codex CLI
./test-codex.sh

# Test with Qwen Code
./test-qwen.sh
```

### Test Projects

Test projects are created in a `test-projects/` directory relative to where the scripts are run. These projects are automatically cleaned up after each test.

### Exit Codes

- **0** - All tests passed
- **1** - Test failed or prerequisites not met

### Test Troubleshooting

#### "Python 3.11+ required"
The test scripts **cannot** automatically install Python. You must install it manually:
```bash
sudo apt update
sudo apt install python3.11 python3.11-venv python3.11-dev
```

#### "uv not found"
**Note:** The test scripts automatically install `uv` if not found. If you see this error, it means the automatic installation failed. Install manually:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.cargo/bin:$PATH"
```

#### "pip not found"
**Note:** The test scripts automatically install `pip` if not found. If you see this error, it means the automatic installation failed. Install manually:
```bash
sudo apt update
sudo apt install python3-pip
```

#### "git not found"
The test scripts **cannot** automatically install Git. You must install it manually:
```bash
sudo apt update
sudo apt install git
```

#### "Spec-Kit installation failed"
If automatic installation fails, try manual installation:
```bash
pip install specify-cli
# or
uv pip install specify-cli
```

#### "AI Assistant installation failed"
If the AI assistant (Claude Code, Codex CLI, or Qwen Code) installation fails, this is usually not critical:
- Many AI assistants work through editor integrations (VS Code, Cursor) rather than CLI tools
- Spec-Kit can work with AI assistants even if a CLI tool is not installed
- The test will proceed and verify Spec-Kit functionality
- For manual installation:
  - **Claude Code**: Install via Cursor editor (https://cursor.sh) or VS Code extension
  - **Codex CLI**: Install OpenAI CLI: `pip install openai`
  - **Qwen Code**: Check Qwen documentation: https://github.com/QwenLM

#### Permission Denied
Make scripts executable:
```bash
chmod +x test-claude.sh test-codex.sh test-qwen.sh
```

#### PATH Issues
If `specify` command is not found after installation, ensure your PATH includes:
```bash
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
# Add to ~/.bashrc or ~/.zshrc for persistence
```

## Getting Help

- **Check system requirements**: `specify check`
- **Project Documentation**: [Spec-Kit GitHub](https://github.com/github/spec-kit) (43.7k+ stars)
- **Report issues**: [GitHub Issues](https://github.com/github/spec-kit/issues)
- **Methodology deep-dive**: [Spec-Driven Development Guide](https://github.com/github/spec-kit/blob/main/spec-driven.md)
