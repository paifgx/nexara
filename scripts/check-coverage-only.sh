#!/bin/bash

# Check Flutter test coverage from existing lcov.info
# Assumes tests have already been run with --coverage flag

THRESHOLD=80
LCOV_FILE="coverage/lcov.info"

if [ ! -f "$LCOV_FILE" ]; then
    echo "Error: Coverage file not found at $LCOV_FILE"
    echo "Please run: flutter test --coverage"
    exit 1
fi

# Extract coverage percentage from lcov.info
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
