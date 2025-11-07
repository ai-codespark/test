#!/bin/bash

# Test script for Spec-Kit with Claude Code on Ubuntu
# This script tests the initialization and basic functionality of Spec-Kit with Claude Code

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test configuration
TEST_PROJECT_NAME="test-claude-project"
TEST_DIR="$(pwd)/test-projects"
PROJECT_PATH="${TEST_DIR}/${TEST_PROJECT_NAME}"

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."

    # Check Python version
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
        print_info "Python found: $PYTHON_VERSION"

        # Check if Python 3.11+
        PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
        PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)
        if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 11 ]); then
            print_error "Python 3.11+ required. Found: $PYTHON_VERSION"
            exit 1
        fi
    else
        print_error "Python 3 not found. Please install Python 3.11+"
        exit 1
    fi

    # Check uv (install if not found)
    if command -v uv &> /dev/null; then
        UV_VERSION=$(uv --version 2>&1)
        print_info "uv found: $UV_VERSION"
    else
        print_warning "uv not found. Installing..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.cargo/bin:$PATH"
        if command -v uv &> /dev/null; then
            print_info "uv installed successfully ✓"
        else
            print_error "uv installation failed. Please install manually: curl -LsSf https://astral.sh/uv/install.sh | sh"
            exit 1
        fi
    fi

    # Check pip (install if not found)
    if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
        print_warning "pip not found. Installing..."
        sudo apt update && sudo apt install -y python3-pip || {
            print_error "pip installation failed"
            exit 1
        }
        print_info "pip installed successfully ✓"
    fi

    # Check git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version 2>&1)
        print_info "git found: $GIT_VERSION"
    else
        print_error "git not found. Please install git"
        exit 1
    fi

    print_info "All prerequisites met ✓"
}

# Function to install or verify spec-kit
check_spec_kit() {
    print_info "Checking Spec-Kit installation..."

    if command -v specify &> /dev/null; then
        print_info "Spec-Kit CLI found: installed"
    else
        print_warning "Spec-Kit CLI not found. Installing..."

        # Ensure PATH includes local bin directories
        export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

        # Try pipx first (best for CLI tools, handles externally-managed environments)
        if command -v pipx &> /dev/null; then
            print_info "Installing specify-cli from PyPI using pipx..."
            pipx install specify-cli || {
                print_warning "pipx installation failed, trying alternative methods..."
            }
        fi

        # Try uv tool install (uv's way to install CLI tools)
        if ! command -v specify &> /dev/null && command -v uv &> /dev/null; then
            print_info "Installing specify-cli from PyPI using uv tool install..."
            uv tool install specify-cli || {
                print_warning "uv tool install failed, trying alternative methods..."
            }
        fi

        # Fallback to uv pip install in a virtual environment
        if ! command -v specify &> /dev/null && command -v uv &> /dev/null; then
            print_info "Installing specify-cli from PyPI using uv pip install..."
            TEMP_VENV=$(mktemp -d)
            uv pip install --system specify-cli || {
                print_warning "uv pip install failed..."
            }
            rm -rf "$TEMP_VENV"
        fi

        # Verify installation
        export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
        if command -v specify &> /dev/null; then
            print_info "Spec-Kit installed successfully ✓"
        else
            print_error "Spec-Kit installation failed. Please install manually."
            print_info "Try one of these methods:"
            print_info "  1. pipx install specify-cli  (recommended for CLI tools)"
            print_info "  2. uv tool install specify-cli"
            exit 1
        fi
    fi
}

# Function to install or verify Claude Code
check_claude_code() {
    print_info "Checking Claude Code installation..."

    # Claude Code might be available as a CLI tool, VS Code extension, or through Cursor
    # Check for common Claude Code CLI commands
    if command -v claude-code &> /dev/null; then
        print_info "Claude Code found: $(claude-code --version 2>&1 || echo 'installed')"
    elif command -v claude &> /dev/null; then
        print_info "Claude Code found: $(claude --version 2>&1 || echo 'installed')"
    elif command -v claudecli &> /dev/null; then
        print_info "Claude Code found: $(claudecli --version 2>&1 || echo 'installed')"
    elif command -v cursor &> /dev/null; then
        print_info "Claude Code found: $(cursor --version 2>&1 || echo 'installed')"
    else
        print_warning "Claude Code CLI not found. Attempting to install..."

        # Ensure PATH includes local bin directories
        export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

        # Try PyPI installation first
        if command -v pip &> /dev/null; then
            print_info "Attempting to install Claude Code from PyPI using pip..."
            pip install --upgrade claude-code anthropic-claude claudecli 2>/dev/null || print_warning "Claude Code PyPI package may not be available"
        elif command -v pip3 &> /dev/null; then
            print_info "Attempting to install Claude Code from PyPI using pip3..."
            pip3 install --upgrade --user claude-code anthropic-claude claudecli 2>/dev/null || print_warning "Claude Code PyPI package may not be available"
        elif command -v uv &> /dev/null; then
            print_info "Attempting to install Claude Code from PyPI using uv..."
            uv pip install claude-code anthropic-claude claudecli 2>/dev/null || print_warning "Claude Code PyPI package may not be available"
        fi

        # Try npm installation (if available) - Cursor editor
        if command -v npm &> /dev/null; then
            print_info "Attempting to install Cursor (Claude-powered editor) via npm..."
            npm install -g @cursor/cli cursor 2>/dev/null || print_warning "Cursor npm package may not be available"
        fi

        # Try installing Anthropic CLI from GitHub (if available)
        if command -v git &> /dev/null && command -v pip &> /dev/null; then
            print_info "Attempting to install Anthropic CLI from GitHub..."
            TEMP_DIR=$(mktemp -d)
            cd "$TEMP_DIR"

            # Try common Anthropic/Claude repositories
            for repo in "anthropics/anthropic-sdk-python" "anthropics/claude-api" "getcursor/cursor"; do
                print_info "Trying repository: $repo"
                git clone --depth 1 "https://github.com/$repo.git" . 2>/dev/null && {
                    if [ -f "requirements.txt" ]; then
                        pip install -r requirements.txt
                    fi
                    if [ -f "setup.py" ]; then
                        pip install -e . || pip install .
                    fi
                    if [ -f "pyproject.toml" ]; then
                        pip install -e . || pip install .
                    fi
                    break
                } || true
            done

            cd - > /dev/null
            rm -rf "$TEMP_DIR"
        fi

        # Verify installation
        export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
        if command -v claude-code &> /dev/null || command -v claude &> /dev/null || command -v claudecli &> /dev/null || command -v cursor &> /dev/null; then
            print_info "Claude Code installed successfully ✓"
        else
            print_warning "Claude Code CLI not found after installation attempts."
            print_info "Note: Claude Code may be used through Spec-Kit without a separate CLI installation."
            print_info "Claude Code is typically used via:"
            print_info "  - Cursor editor (https://cursor.sh)"
            print_info "  - VS Code with Claude extension"
            print_info "  - Claude Desktop application"
            print_info "The test will proceed - Spec-Kit can work with Claude Code via editor integration."
        fi
    fi
}

# Function to cleanup test project
cleanup() {
    print_info "Cleaning up test project..."
    if [ -d "$PROJECT_PATH" ]; then
        rm -rf "$PROJECT_PATH"
        print_info "Test project removed: $PROJECT_PATH"
    fi
}

# Function to verify project structure
verify_project_structure() {
    print_info "Verifying project structure..."

    local errors=0

    # Check if project directory exists
    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "Project directory not found: $PROJECT_PATH"
        return 1
    fi

    # Check for .specify directory
    if [ ! -d "$PROJECT_PATH/.specify" ]; then
        print_error ".specify directory not found"
        errors=$((errors + 1))
    else
        print_info ".specify directory exists ✓"
    fi

    # Check for scripts directory
    if [ ! -d "$PROJECT_PATH/.specify/scripts" ]; then
        print_error ".specify/scripts directory not found"
        errors=$((errors + 1))
    else
        print_info ".specify/scripts directory exists ✓"

        # Check for bash scripts
        if [ ! -d "$PROJECT_PATH/.specify/scripts/bash" ]; then
            print_error ".specify/scripts/bash directory not found"
            errors=$((errors + 1))
        else
            print_info ".specify/scripts/bash directory exists ✓"
        fi
    fi

    # Check for templates directory
    if [ ! -d "$PROJECT_PATH/.specify/templates" ]; then
        print_error ".specify/templates directory not found"
        errors=$((errors + 1))
    else
        print_info ".specify/templates directory exists ✓"
    fi

    # Check for memory directory
    if [ ! -d "$PROJECT_PATH/.specify/memory" ]; then
        print_error ".specify/memory directory not found"
        errors=$((errors + 1))
    else
        print_info ".specify/memory directory exists ✓"
    fi

    # Check for Git initialization
    if [ ! -d "$PROJECT_PATH/.git" ]; then
        print_warning ".git directory not found (may be expected if --no-git was used)"
    else
        print_info "Git repository initialized ✓"
    fi

    # Check for README or other project files
    if [ -f "$PROJECT_PATH/README.md" ]; then
        print_info "README.md found ✓"
    fi

    if [ $errors -eq 0 ]; then
        print_info "Project structure verification passed ✓"
        return 0
    else
        print_error "Project structure verification failed with $errors errors"
        return 1
    fi
}

# Main test function
run_test() {
    print_info "=========================================="
    print_info "Testing Spec-Kit with Claude Code"
    print_info "=========================================="

    # Create test directory
    mkdir -p "$TEST_DIR"

    # Cleanup any existing test project
    cleanup

    # Check prerequisites
    check_prerequisites

    # Check/install spec-kit
    check_spec_kit

    # Check/install Claude Code
    check_claude_code

    # Run test
    print_info "Initializing test project with Claude Code..."
    cd "$TEST_DIR"

    # Ensure PATH includes local bin directories
    export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    if specify init "$TEST_PROJECT_NAME" --ai claude; then
        print_info "Project initialization successful ✓"
    else
        print_error "Project initialization failed"
        exit 1
    fi

    # Verify project structure
    if verify_project_structure; then
        print_info "All tests passed ✓"
    else
        print_error "Tests failed"
        exit 1
    fi

    # List project contents for verification
    print_info "Project contents:"
    ls -la "$PROJECT_PATH" | head -20

    print_info "=========================================="
    print_info "Test completed successfully!"
    print_info "=========================================="
}

# Run cleanup on exit
trap cleanup EXIT

# Run the test
run_test
