#!/usr/bin/env bash
# Project Pilot - Lightweight project type detection for SessionStart hook
# Outputs a one-line project profile string for ambient context

set -euo pipefail

PROJECT_TYPE=""
PKG_MANAGER=""
FRAMEWORK=""
TEST_FRAMEWORK=""
CI=""

if [ -f "package.json" ]; then
  PROJECT_TYPE="Node.js"
  if [ -f "yarn.lock" ]; then PKG_MANAGER="yarn"
  elif [ -f "pnpm-lock.yaml" ]; then PKG_MANAGER="pnpm"
  elif [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then PKG_MANAGER="bun"
  else PKG_MANAGER="npm"
  fi
  if [ -f "tsconfig.json" ]; then PROJECT_TYPE="Node.js/TypeScript"; fi
  if grep -q '"next"' package.json 2>/dev/null; then FRAMEWORK="Next.js"
  elif grep -q '"react"' package.json 2>/dev/null; then FRAMEWORK="React"
  elif grep -q '"vue"' package.json 2>/dev/null; then FRAMEWORK="Vue"
  elif grep -q '"angular"' package.json 2>/dev/null; then FRAMEWORK="Angular"
  elif grep -q '"express"' package.json 2>/dev/null; then FRAMEWORK="Express"
  fi
  if grep -q '"vitest"' package.json 2>/dev/null; then TEST_FRAMEWORK="Vitest"
  elif grep -q '"jest"' package.json 2>/dev/null; then TEST_FRAMEWORK="Jest"
  fi
elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  PROJECT_TYPE="Python"
  if [ -f "poetry.lock" ]; then PKG_MANAGER="poetry"
  elif [ -f "uv.lock" ]; then PKG_MANAGER="uv"
  else PKG_MANAGER="pip"
  fi
elif [ -f "go.mod" ]; then
  PROJECT_TYPE="Go"; PKG_MANAGER="go modules"
elif [ -f "Cargo.toml" ]; then
  PROJECT_TYPE="Rust"; PKG_MANAGER="cargo"
elif [ -f "pom.xml" ] || [ -f "build.gradle" ]; then
  PROJECT_TYPE="Java/Kotlin"
fi

if [ -d ".github/workflows" ]; then CI="GitHub Actions"
elif [ -f ".gitlab-ci.yml" ]; then CI="GitLab CI"
fi

if [ -z "$PROJECT_TYPE" ]; then
  echo "Project Pilot: Unknown project type"
  exit 0
fi

OUTPUT="Project Pilot: ${PROJECT_TYPE}"
[ -n "$PKG_MANAGER" ] && OUTPUT="${OUTPUT} | PM: ${PKG_MANAGER}"
[ -n "$FRAMEWORK" ] && OUTPUT="${OUTPUT} | Framework: ${FRAMEWORK}"
[ -n "$TEST_FRAMEWORK" ] && OUTPUT="${OUTPUT} | Test: ${TEST_FRAMEWORK}"
[ -n "$CI" ] && OUTPUT="${OUTPUT} | CI: ${CI}"

echo "$OUTPUT"
