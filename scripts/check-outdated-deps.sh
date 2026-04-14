#!/usr/bin/env bash
# Project Pilot - Cross-platform outdated dependency checker
set -euo pipefail

echo "=== Dependency Health Check ==="
FOUND_PM=false

if [ -f "package.json" ]; then
  FOUND_PM=true
  echo "## Node.js Dependencies"
  npm outdated 2>/dev/null || echo "(no outdated packages)"
  echo "## Security Audit"
  npm audit --omit=dev 2>/dev/null | tail -20 || echo "(npm audit not available)"
fi

if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  FOUND_PM=true
  echo "## Python Dependencies"
  pip list --outdated --format=columns 2>/dev/null | head -30 || echo "(not available)"
fi

if [ -f "go.mod" ]; then
  FOUND_PM=true
  echo "## Go Dependencies"
  go list -m -u all 2>/dev/null | grep '\[' | head -20 || echo "(not available)"
fi

if [ -f "Cargo.toml" ]; then
  FOUND_PM=true
  echo "## Rust Dependencies"
  cargo outdated 2>/dev/null | head -20 || echo "(cargo-outdated not installed)"
fi

if [ "$FOUND_PM" = false ]; then
  echo "No recognized package manager found."
fi

echo "=== Check Complete ==="
