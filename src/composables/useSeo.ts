import {
  computed, type Ref,
} from 'vue';
import {
  useHead,
} from '@unhead/vue';

const SITE = 'Scrambled Kitchen';
const BASE = 'https://huydo862003.github.io';
const DEFAULT_IMAGE = `${BASE}/og.png`;

interface SeoOptions {
  title: Ref<string | undefined>;
  description?: Ref<string | undefined>;
  path?: Ref<string>;
  type?: string;
  image?: Ref<string | undefined>;
  publishedTime?: Ref<string | undefined>;
  modifiedTime?: Ref<string | undefined>;
  tags?: Ref<string[] | undefined>;
  author?: Ref<string | undefined>;
}

export function useSeo ({
  title, description, path, type = 'article', image, publishedTime, modifiedTime, tags, author,
}: SeoOptions) {
  const fullTitle = computed(() => {
    const t = title.value;
    return t ? `${t} | ${SITE}` : SITE;
  });

  const desc = computed(() => description?.value || '');
  const url = computed(() => path?.value ? `${BASE}${path.value}` : BASE);
  const img = computed(() => image?.value || DEFAULT_IMAGE);

  useHead({
    title: fullTitle,
    meta: computed(() => {
      const m: {name?: string;
        property?: string;
        content: string;}[] = [
      ];

      if (desc.value) {
        m.push({
          name: 'description',
          content: desc.value,
        });
      }

      if (tags?.value?.length) {
        m.push({
          name: 'keywords',
          content: tags.value.join(', '),
        });
      }

      if (author?.value) {
        m.push({
          name: 'author',
          content: author.value,
        });
      }

      // Open Graph
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
      m.push({
        property: 'og:image',
        content: img.value,
      });
      if (desc.value) {
        m.push({
          property: 'og:description',
          content: desc.value,
        });
      }

      // Article metadata
      if (type === 'article') {
        if (publishedTime?.value) {
          m.push({
            property: 'article:published_time',
            content: publishedTime.value,
          });
        }
        if (modifiedTime?.value) {
          m.push({
            property: 'article:modified_time',
            content: modifiedTime.value,
          });
        }
        if (tags?.value?.length) {
          for (const tag of tags.value) {
            m.push({
              property: 'article:tag',
              content: tag,
            });
          }
        }
      }

      // Twitter Card
      m.push({
        name: 'twitter:card',
        content: 'summary_large_image',
      });
      m.push({
        name: 'twitter:title',
        content: fullTitle.value,
      });
      m.push({
        name: 'twitter:image',
        content: img.value,
      });
      if (desc.value) {
        m.push({
          name: 'twitter:description',
          content: desc.value,
        });
      }

      return m;
    }),
    link: computed(() => [
      {
        rel: 'canonical',
        href: url.value,
      },
    ]),
  });
}
