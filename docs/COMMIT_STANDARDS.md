# Commit Standards and Git Hooks

This project enforces commit message standards and code quality checks through automated Git hooks.

## Commit Message Format

All commit messages must follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): subject

[optional body]

[optional footer(s)]
```

### Rules

- **Header line**: Maximum 50 characters
- **Body lines**: Maximum 72 characters
- **Type**: Required, must be one of:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation only changes
  - `style`: Code style changes (formatting, missing semicolons, etc.)
  - `refactor`: Code change that neither fixes a bug nor adds a feature
  - `perf`: Performance improvements
  - `test`: Adding or updating tests
  - `build`: Changes to build system or dependencies
  - `ci`: CI/CD configuration changes
  - `chore`: Other changes that don't modify src or test files
  - `revert`: Reverts a previous commit

- **Scope**: Optional, must be lowercase
- **Subject**: Required, sentence-case, no trailing period

### Examples

```bash
# Good examples
git commit -m "feat(auth): add user login functionality"
git commit -m "fix(ui): correct button alignment on mobile"
git commit -m "docs: update README with setup instructions"

# Bad examples (will be rejected)
git commit -m "Added new feature"  # Missing type
git commit -m "feat: implemented user authentication system for the application."  # Too long, has period
git commit -m "FIX: bug"  # Type must be lowercase
```

## Pre-Push Checks

Before pushing to remote, the following checks are automatically performed:

1. **All tests must pass**: `flutter test`
2. **Code coverage must be ≥80%**: Calculated from test coverage

If either check fails, the push will be aborted.

## Manual Testing

You can run the checks manually:

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage

# Check coverage only (requires existing coverage data)
bash scripts/check-coverage-only.sh

# Run full coverage check (runs tests and checks coverage)
bash scripts/check-coverage.sh
```

## Setup Requirements

The following tools are installed and configured:

- **Husky**: Git hooks management
- **Commitlint**: Commit message validation
- **Coverage scripts**: Custom scripts for coverage threshold checking

## Troubleshooting

### Commit is rejected

If your commit is rejected, check the error message. Common issues:

1. **Type not recognized**: Use one of the allowed types
2. **Header too long**: Keep it under 50 characters
3. **Subject has period**: Remove the trailing period
4. **Subject wrong case**: Use sentence-case (starts with lowercase)

### Push is rejected

If your push is rejected:

1. **Tests failing**: Fix the failing tests
2. **Coverage too low**: Add more tests to increase coverage above 80%

You can check current coverage with:
```bash
flutter test --coverage
bash scripts/check-coverage-only.sh
```

## Bypassing Hooks (Emergency Only)

In exceptional cases, you can bypass hooks:

```bash
# Bypass commit-msg hook
git commit -m "your message" --no-verify

# Bypass pre-push hook
git push --no-verify
```

⚠️ **Warning**: Only use this in emergencies. All commits should follow standards.
