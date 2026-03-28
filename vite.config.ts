import {
  fileURLToPath, URL,
} from 'node:url';
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';
import contentCollections from '@content-collections/vite';
import { generateRoutes } from './src/utils/static_routes';

export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
    contentCollections(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  assetsInclude: ['**/*.md'],
  ssgOptions: {
    includedRoutes () {
      return generateRoutes();
    },
  },
});
