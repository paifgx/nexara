#!/bin/bash

# Check Flutter test coverage
# Exits with 1 if coverage is below threshold

THRESHOLD=80
LCOV_FILE="coverage/lcov.info"

echo "Running Flutter tests with coverage..."
flutter test --coverage

if [ ! -f "$LCOV_FILE" ]; then
    echo "Error: Coverage file not found at $LCOV_FILE"
    exit 1
fi

# Extract coverage percentage from lcov.info
# This calculates the line coverage percentage
TOTAL_LINES=$(grep -E "^LF:" "$LCOV_FILE" | awk -F: '{sum += $2} END {print sum}')
COVERED_LINES=$(grep -E "^LH:" "$LCOV_FILE" | awk -F: '{sum += $2} END {print sum}')

if [ "$TOTAL_LINES" -eq 0 ]; then
    echo "Warning: No lines found to calculate coverage"
    exit 0
fi

COVERAGE=$(awk "BEGIN {printf \"%.1f\", ($COVERED_LINES / $TOTAL_LINES) * 100}")

echo "Coverage: $COVERAGE%"
echo "Threshold: $THRESHOLD%"

# Compare coverage with threshold
if (( $(echo "$COVERAGE < $THRESHOLD" | bc -l) )); then
    echo "❌ Coverage is below threshold ($COVERAGE% < $THRESHOLD%)"
    exit 1
else
    echo "✅ Coverage meets threshold ($COVERAGE% >= $THRESHOLD%)"
    exit 0
fi
