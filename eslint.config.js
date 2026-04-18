import config from '@hdnax/nuclint';

export default [
  {
    ignores: [
      'dist/',
      'dist/**',
      'node_modules/',
      'node_modules/**',
      '.content-collections/',
      '.content-collections/**',
      '*.config.js',
      '*.config.ts',
      'content-collections.ts',
      'dev/core/__generated__',
    ],
  },
  ...config,
  {
    rules: {
      'import/named': 'off',
      '@typescript-eslint/no-explicit-any': 'warn',
    },
  },
];
