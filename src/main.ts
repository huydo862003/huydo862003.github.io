import { ViteSSG } from 'vite-ssg';
import { createPinia } from 'pinia';
import FloatingVue from 'floating-vue';
import 'floating-vue/dist/style.css';
import './style.css';
import App from './App.vue';
import { routes } from './router';

export const createApp = ViteSSG(
  App,
  {
    routes,
    base: '/',
    scrollBehavior () {
      return { top: 0 };
    },
  },
  ({
    app, head,
  }) => {
    app.use(createPinia());
    app.use(FloatingVue);

    head?.push({
      title: 'Scrambled Kitchen',
      meta: [
        {
          name: 'description',
          content: 'A personal knowledge site for programming language theory and design - flashcards, concepts, books, and learning journeys.',
        },
        {
          property: 'og:type',
          content: 'website',
        },
        {
          property: 'og:site_name',
          content: 'Scrambled Kitchen',
        },
        {
          property: 'og:title',
          content: 'Scrambled Kitchen',
        },
        {
          property: 'og:description',
          content: 'A personal knowledge site for programming language theory and design - flashcards, concepts, books, and learning journeys.',
        },
        {
          property: 'og:url',
          content: 'https://huydo862003.github.io',
        },
        {
          property: 'og:image',
          content: 'https://huydo862003.github.io/og.png',
        },
        {
          name: 'twitter:card',
          content: 'summary_large_image',
        },
        {
          name: 'twitter:title',
          content: 'Scrambled Kitchen',
        },
        {
          name: 'twitter:description',
          content: 'A personal knowledge site for programming language theory and design - flashcards, concepts, books, and learning journeys.',
        },
        {
          name: 'twitter:image',
          content: 'https://huydo862003.github.io/og.png',
        },
      ],
      link: [
        {
          rel: 'canonical',
          href: 'https://huydo862003.github.io',
        },
      ],
    });
  },
);
