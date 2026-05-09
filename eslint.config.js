import { vueConfig, baseConfig } from '@hdnax/nuclint';

export default [
  ...baseConfig,
  ...vueConfig,
  {
    rules: {
      'vue/no-undef-components': ['error', {
        ignorePatterns: [
          'RouterLink',
          'RouterView',
          'VTooltip',
        ],
      }],
      'vue/no-undef-directives': ['error', {
        ignore: ['tooltip'],
      }],
    },
  },
];
