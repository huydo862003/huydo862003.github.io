import type { RouteRecordRaw } from 'vue-router';

export const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'home',
    component: () => import('@/pages/HomePage.vue'),
  },
  {
    path: '/thoughts',
    name: 'thoughts',
    component: () => import('@/pages/thoughts/ListPage.vue'),
  },
  {
    path: '/thoughts/:slug',
    name: 'thought-post',
    component: () => import('@/pages/thoughts/PostPage.vue'),
  },
  {
    path: '/archived',
    name: 'archived',
    component: () => import('@/pages/thoughts/ArchivedPage.vue'),
  },
  {
    path: '/journeys',
    name: 'journeys',
    component: () => import('@/pages/journeys/ListPage.vue'),
  },
  {
    path: '/journeys/:slug',
    name: 'journey-detail',
    component: () => import('@/pages/journeys/DetailPage.vue'),
  },
  {
    path: '/journeys/:slug/concepts',
    name: 'concepts',
    component: () => import('@/pages/journeys/concepts/ListPage.vue'),
  },
  {
    path: '/journeys/:slug/concepts/:conceptSlug',
    name: 'concept-detail',
    component: () => import('@/pages/journeys/concepts/DetailPage.vue'),
  },
  {
    path: '/journeys/:slug/flashcards',
    name: 'flashcards',
    component: () => import('@/pages/journeys/flashcards/ListPage.vue'),
  },
  {
    path: '/journeys/:slug/flashcards/:cardSlug',
    name: 'flashcard-detail',
    component: () => import('@/pages/journeys/flashcards/DetailPage.vue'),
  },
  {
    path: '/journeys/:slug/phases',
    name: 'phases',
    component: () => import('@/pages/journeys/phases/ListPage.vue'),
  },
  {
    path: '/journeys/:slug/phases/:phaseSlug',
    name: 'phase-detail',
    component: () => import('@/pages/journeys/phases/DetailPage.vue'),
  },
  {
    path: '/journeys/:slug/books',
    name: 'books',
    component: () => import('@/pages/journeys/books/ListPage.vue'),
  },
  {
    path: '/journeys/:slug/blogs',
    name: 'blogs',
    component: () => import('@/pages/journeys/books/BlogsPage.vue'),
  },
  {
    path: '/journeys/:slug/papers',
    name: 'papers',
    component: () => import('@/pages/journeys/papers/ListPage.vue'),
  },
  {
    path: '/journeys/:slug/papers/:paperSlug',
    name: 'paper-detail',
    component: () => import('@/pages/journeys/papers/DetailPage.vue'),
  },
  {
    path: '/journeys/:slug/books/:bookSlug',
    name: 'book-detail',
    component: () => import('@/pages/journeys/books/DetailPage.vue'),
  },
  {
    path: '/reads',
    name: 'reads',
    component: () => import('@/pages/ReadsPage.vue'),
  },
  {
    path: '/graph',
    name: 'graph',
    component: () => import('@/pages/graph/KnowledgeGraphPage.vue'),
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: () => import('@/pages/NotFoundPage.vue'),
  },
];
