# Commit Linting and Pre-Push Checks Setup Summary

## ✅ What Has Been Configured

### 1. **Commit Message Linting**
- **Tool**: Commitlint with Conventional Commits
- **Hook**: `commit-msg` (runs on every commit)
- **Rules**:
  - Header max 50 characters
  - Body lines max 72 characters
  - Must follow format: `type(scope): subject`
  - Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
  - Subject must start with lowercase, no trailing period

### 2. **Pre-Push Quality Checks**
- **Hook**: `pre-push` (runs before pushing to remote)
- **Checks**:
  1. All Flutter tests must pass
  2. Code coverage must be ≥80%

### 3. **Files Created**
```
nexara/
├── package.json                    # Node dependencies for commitlint & husky
├── commitlint.config.js           # Commitlint rules configuration
├── .husky/
│   ├── commit-msg                 # Git hook for commit message validation
│   └── pre-push                   # Git hook for test & coverage checks
├── scripts/
│   ├── check-coverage.sh          # Run tests and check coverage
│   ├── check-coverage-only.sh    # Check coverage from existing data
│   └── coverage-config.sh        # Coverage threshold configuration
└── docs/
    └── COMMIT_STANDARDS.md        # Documentation for commit standards
```

## 🚀 How to Use

### Making Commits
```bash
# Good commits (will pass)
git commit -m "feat: add user authentication"
git commit -m "fix(auth): resolve login timeout issue"
git commit -m "docs: update API documentation"

# Bad commits (will be rejected)
git commit -m "Added feature"                    # Missing type
git commit -m "feat: Add authentication."        # Capital A, has period
git commit -m "feat: this is a very long commit message that exceeds fifty characters"  # Too long
```

### Running Tests and Coverage
```bash
# Run tests only
flutter test

# Run tests with coverage
flutter test --coverage

# Check coverage against threshold
bash scripts/check-coverage-only.sh

# Run tests and check coverage
bash scripts/check-coverage.sh
```

## ⚠️ Current Status

- **Current test coverage**: 37.0% (below 80% threshold)
- **Pre-push hook will block pushes** until coverage is improved

## 🔧 Configuring Coverage Threshold

Edit `scripts/coverage-config.sh`:
- `COVERAGE_THRESHOLD`: Set the minimum coverage percentage (default: 80)
- `SKIP_COVERAGE_CHECK`: Set to "true" to temporarily disable coverage checks during development

## 📝 Next Steps

1. **Add more tests** to increase coverage above 80%
2. **Use conventional commits** for all future commits
3. **Run tests before pushing** to catch issues early

## 🆘 Troubleshooting

### If commits are rejected:
- Check the error message for specific issues
- Ensure commit message follows the format
- Use `git commit --no-verify` to bypass (emergency only)

### If pushes are blocked:
- Run `flutter test` to see failing tests
- Run `bash scripts/check-coverage-only.sh` to see coverage
- Add more tests or temporarily adjust threshold in `scripts/coverage-config.sh`

### To bypass hooks (emergency only):
```bash
git commit --no-verify -m "your message"
git push --no-verify
```

## 📚 Resources

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Commitlint Documentation](https://commitlint.js.org/)
- [Husky Documentation](https://typicode.github.io/husky/)
