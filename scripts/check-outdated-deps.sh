#!/usr/bin/env bash
# Project Pilot - Cross-platform outdated dependency checker
# Detects package manager and runs appropriate outdated check

set -euo pipefail

echo "=== Dependency Health Check ==="

FOUND_PM=false

# Node.js
if [ -f "package.json" ]; then
  FOUND_PM=true
  echo ""
  echo "## Node.js Dependencies"
  if [ -f "yarn.lock" ]; then
    echo "Package Manager: yarn"
    yarn outdated 2>/dev/null || echo "(yarn outdated not available or no outdated packages)"
  elif [ -f "pnpm-lock.yaml" ]; then
    echo "Package Manager: pnpm"
    pnpm outdated 2>/dev/null || echo "(pnpm outdated not available or no outdated packages)"
  else
    echo "Package Manager: npm"
    npm outdated 2>/dev/null || echo "(npm outdated not available or no outdated packages)"
  fi
  echo ""
  echo "## Security Audit"
  npm audit --omit=dev 2>/dev/null | tail -20 || echo "(npm audit not available)"
fi

# Python
if [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
  FOUND_PM=true
  echo ""
  echo "## Python Dependencies"
  if command -v pip &>/dev/null; then
    echo "Package Manager: pip"
    pip list --outdated --format=columns 2>/dev/null | head -30 || echo "(pip list --outdated not available)"
  fi
  if command -v pip-audit &>/dev/null; then
    echo ""
    echo "## Security Audit"
    pip-audit 2>/dev/null | head -30 || echo "(pip-audit not available)"
  fi
fi

# Go
if [ -f "go.mod" ]; then
  FOUND_PM=true
  echo ""
  echo "## Go Dependencies"
  echo "Package Manager: go modules"
  # List direct dependencies and check for updates
  go list -m -u all 2>/dev/null | grep '\[' | head -20 || echo "(go list not available or no updates)"
fi

# Rust
if [ -f "Cargo.toml" ]; then
  FOUND_PM=true
  echo ""
  echo "## Rust Dependencies"
  echo "Package Manager: cargo"
  if command -v cargo-outdated &>/dev/null; then
    cargo outdated 2>/dev/null | head -20 || echo "(cargo-outdated not available)"
  else
    echo "(Install cargo-outdated: cargo install cargo-outdated)"
  fi
  if command -v cargo-audit &>/dev/null; then
    echo ""
    echo "## Security Audit"
    cargo audit 2>/dev/null | head -30 || echo "(cargo-audit not available)"
  fi
fi

# Ruby
if [ -f "Gemfile" ]; then
  FOUND_PM=true
  echo ""
  echo "## Ruby Dependencies"
  echo "Package Manager: bundler"
  bundle outdated 2>/dev/null | head -20 || echo "(bundle outdated not available)"
fi

# PHP
if [ -f "composer.json" ]; then
  FOUND_PM=true
  echo ""
  echo "## PHP Dependencies"
  echo "Package Manager: composer"
  composer outdated --direct 2>/dev/null | head -20 || echo "(composer outdated not available)"
fi

# Java/Kotlin
if [ -f "pom.xml" ]; then
  FOUND_PM=true
  echo ""
  echo "## Java/Kotlin Dependencies (Maven)"
  echo "(Run manually: mvn versions:display-dependency-updates)"
elif [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
  FOUND_PM=true
  echo ""
  echo "## Java/Kotlin Dependencies (Gradle)"
  echo "(Run manually: gradle dependencyUpdates)"
fi

if [ "$FOUND_PM" = false ]; then
  echo "No recognized package manager found."
  exit 0
fi

echo ""
echo "=== Check Complete ==="