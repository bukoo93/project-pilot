#!/usr/bin/env bash
# Project Pilot - Lightweight project type detection for SessionStart hook
# Outputs a one-line project profile string for ambient context

set -euo pipefail

PROJECT_TYPE=""
PKG_MANAGER=""
FRAMEWORK=""
TEST_FRAMEWORK=""
CI=""

# Detect language/runtime from manifest files
if [ -f "package.json" ]; then
  PROJECT_TYPE="Node.js"
  if [ -f "yarn.lock" ]; then PKG_MANAGER="yarn"
  elif [ -f "pnpm-lock.yaml" ]; then PKG_MANAGER="pnpm"
  elif [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then PKG_MANAGER="bun"
  else PKG_MANAGER="npm"
  fi
  # Detect TypeScript
  if [ -f "tsconfig.json" ]; then PROJECT_TYPE="Node.js/TypeScript"; fi
  # Detect framework from package.json
  if grep -q '"next"' package.json 2>/dev/null; then FRAMEWORK="Next.js"
  elif grep -q '"nuxt"' package.json 2>/dev/null; then FRAMEWORK="Nuxt"
  elif grep -q '"react"' package.json 2>/dev/null; then FRAMEWORK="React"
  elif grep -q '"vue"' package.json 2>/dev/null; then FRAMEWORK="Vue"
  elif grep -q '"angular"' package.json 2>/dev/null; then FRAMEWORK="Angular"
  elif grep -q '"svelte"' package.json 2>/dev/null; then FRAMEWORK="Svelte"
  elif grep -q '"express"' package.json 2>/dev/null; then FRAMEWORK="Express"
  elif grep -q '"fastify"' package.json 2>/dev/null; then FRAMEWORK="Fastify"
  elif grep -q '"nest"' package.json 2>/dev/null; then FRAMEWORK="NestJS"
  fi
  # Detect test framework
  if grep -q '"vitest"' package.json 2>/dev/null; then TEST_FRAMEWORK="Vitest"
  elif grep -q '"jest"' package.json 2>/dev/null; then TEST_FRAMEWORK="Jest"
  elif grep -q '"mocha"' package.json 2>/dev/null; then TEST_FRAMEWORK="Mocha"
  elif grep -q '"playwright"' package.json 2>/dev/null; then TEST_FRAMEWORK="Playwright"
  fi
elif [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
  PROJECT_TYPE="Python"
  if [ -f "poetry.lock" ]; then PKG_MANAGER="poetry"
  elif [ -f "Pipfile.lock" ]; then PKG_MANAGER="pipenv"
  elif [ -f "uv.lock" ]; then PKG_MANAGER="uv"
  else PKG_MANAGER="pip"
  fi
  if [ -f "pyproject.toml" ]; then
    if grep -q 'django' pyproject.toml 2>/dev/null; then FRAMEWORK="Django"
    elif grep -q 'fastapi' pyproject.toml 2>/dev/null; then FRAMEWORK="FastAPI"
    elif grep -q 'flask' pyproject.toml 2>/dev/null; then FRAMEWORK="Flask"
    fi
    if grep -q 'pytest' pyproject.toml 2>/dev/null; then TEST_FRAMEWORK="pytest"; fi
  fi
elif [ -f "go.mod" ]; then
  PROJECT_TYPE="Go"
  PKG_MANAGER="go modules"
  if grep -q 'gin-gonic' go.mod 2>/dev/null; then FRAMEWORK="Gin"
  elif grep -q 'echo' go.mod 2>/dev/null; then FRAMEWORK="Echo"
  elif grep -q 'fiber' go.mod 2>/dev/null; then FRAMEWORK="Fiber"
  fi
elif [ -f "Cargo.toml" ]; then
  PROJECT_TYPE="Rust"
  PKG_MANAGER="cargo"
  if grep -q 'actix' Cargo.toml 2>/dev/null; then FRAMEWORK="Actix"
  elif grep -q 'axum' Cargo.toml 2>/dev/null; then FRAMEWORK="Axum"
  elif grep -q 'rocket' Cargo.toml 2>/dev/null; then FRAMEWORK="Rocket"
  fi
elif [ -f "pom.xml" ] || [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
  PROJECT_TYPE="Java/Kotlin"
  if [ -f "pom.xml" ]; then PKG_MANAGER="Maven"
  else PKG_MANAGER="Gradle"
  fi
  if grep -q 'spring' pom.xml 2>/dev/null || grep -q 'spring' build.gradle 2>/dev/null || grep -q 'spring' build.gradle.kts 2>/dev/null; then
    FRAMEWORK="Spring Boot"
  fi
elif [ -f "Gemfile" ]; then
  PROJECT_TYPE="Ruby"
  PKG_MANAGER="bundler"
  if grep -q 'rails' Gemfile 2>/dev/null; then FRAMEWORK="Rails"; fi
elif [ -f "composer.json" ]; then
  PROJECT_TYPE="PHP"
  PKG_MANAGER="composer"
  if grep -q 'laravel' composer.json 2>/dev/null; then FRAMEWORK="Laravel"; fi
elif ls *.sln 2>/dev/null 1>&2 || ls *.csproj 2>/dev/null 1>&2; then
  PROJECT_TYPE="C#/.NET"
  PKG_MANAGER="NuGet"
fi

# Detect CI/CD
if [ -d ".github/workflows" ]; then CI="GitHub Actions"
elif [ -f ".gitlab-ci.yml" ]; then CI="GitLab CI"
elif [ -f "Jenkinsfile" ]; then CI="Jenkins"
elif [ -f ".circleci/config.yml" ]; then CI="CircleCI"
fi

# Build output string
if [ -z "$PROJECT_TYPE" ]; then
  echo "Project Pilot: Unknown project type (no recognized manifest files found)"
  exit 0
fi

OUTPUT="Project Pilot: ${PROJECT_TYPE}"
[ -n "$PKG_MANAGER" ] && OUTPUT="${OUTPUT} | PM: ${PKG_MANAGER}"
[ -n "$FRAMEWORK" ] && OUTPUT="${OUTPUT} | Framework: ${FRAMEWORK}"
[ -n "$TEST_FRAMEWORK" ] && OUTPUT="${OUTPUT} | Test: ${TEST_FRAMEWORK}"
[ -n "$CI" ] && OUTPUT="${OUTPUT} | CI: ${CI}"

echo "$OUTPUT"