module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Enforce header max length of 50 characters
    'header-max-length': [2, 'always', 50],
    // Enforce body line max length of 72 characters
    'body-max-line-length': [2, 'always', 72],
    // Ensure type is in the allowed list
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'ci',
        'chore',
        'revert'
      ]
    ],
    // Ensure scope is lowercase
    'scope-case': [2, 'always', 'lower-case'],
    // Ensure subject starts with lowercase (conventional commits standard)
    'subject-case': [2, 'never', ['upper-case', 'pascal-case', 'start-case']],
    // Ensure subject doesn't end with period
    'subject-full-stop': [2, 'never', '.'],
    // Ensure subject is not empty
    'subject-empty': [2, 'never'],
    // Ensure type is not empty
    'type-empty': [2, 'never']
  }
};
