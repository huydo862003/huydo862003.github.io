import {
  fileURLToPath, URL,
} from 'node:url';
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';
import sitemap from 'vite-plugin-sitemap';
import contentCollections from '@content-collections/vite';
import { generateRoutes } from './src/utils/staticRoutes';

const routes = generateRoutes();

export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
    contentCollections(),
    sitemap({ dynamicRoutes: routes }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  assetsInclude: ['**/*.md'],
  ssgOptions: {
    includedRoutes () {
      return routes;
    },
  },
});
