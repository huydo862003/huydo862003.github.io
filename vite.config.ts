import {
  fileURLToPath, URL,
} from 'node:url';
import {
  createRequire,
} from 'node:module';
import path from 'node:path';
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';
import sitemap from 'vite-plugin-sitemap';
import contentCollections from '@content-collections/vite';
import { generateRoutes } from './src/utils/staticRoutes';
import { editorPlugin } from './dev/vite-plugin/editor.vite-plugin';

const require = createRequire(import.meta.url);
const genuixRoot = path.dirname(require.resolve('@hdnax/genuix'));

const routes = generateRoutes();

export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
    contentCollections(),
    sitemap({
     hostname: 'https://huydo862003.github.io',
     dynamicRoutes: routes,
    }),
    editorPlugin(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      '@dev': fileURLToPath(new URL('./dev', import.meta.url)),
    },
  },
  server: {
    fs: {
      allow: [
        '.',
        genuixRoot,
      ],
    },
  },
  assetsInclude: ['**/*.md'],
  ssgOptions: {
    includedRoutes () {
      return routes;
    },
  },
});
