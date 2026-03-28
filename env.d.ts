/// <reference types="vite/client" />

declare module '*.vue' {
  import type { DefineComponent } from 'vue';

  const component: DefineComponent<object, object, unknown>;
  export default component;
}

declare module 'markdown-it-texmath';
declare module 'markdown-it-container';

declare module '*.md' {
  const content: string;
  export default content;
}
