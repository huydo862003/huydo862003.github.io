import {
  computed, type Ref,
} from 'vue';
import { useHead } from '@unhead/vue';

const SITE = 'Scrambled Kitchen';
const BASE = 'https://huydo862003.github.io';

interface SeoOptions {
  title: Ref<string | undefined>;
  description?: Ref<string | undefined>;
  path?: Ref<string>;
  type?: string;
}

export function useSeo ({
  title, description, path, type = 'article',
}: SeoOptions) {
  const fullTitle = computed(() => {
    const t = title.value;
    return t ? `${t} | ${SITE}` : SITE;
  });

  const desc = computed(() => description?.value || '');
  const url = computed(() => path?.value ? `${BASE}${path.value}` : BASE);

  useHead({
    title: fullTitle,
    meta: computed(() => {
      const m: { name?: string;
        property?: string;
        content: string; }[] = [];
      if (desc.value) {
        m.push({
          name: 'description',
          content: desc.value,
        });
        m.push({
          property: 'og:description',
          content: desc.value,
        });
      }
      m.push({
        property: 'og:title',
        content: fullTitle.value,
      });
      m.push({
        property: 'og:url',
        content: url.value,
      });
      m.push({
        property: 'og:type',
        content: type,
      });
      return m;
    }),
  });
}
