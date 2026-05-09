import {
  computed, type Ref,
} from 'vue';
import {
  useHead,
} from '@unhead/vue';

const SITE = 'Scrambled Kitchen';
const BASE = 'https://huydo862003.github.io';
const DEFAULT_IMAGE = `${BASE}/og.png`;

export function useSeo ({
  title, description, path, type = 'article', image, publishedTime, modifiedTime, tags, author,
}: SeoOptions) {
  const fullTitle = computed(() => {
    const pageTitle = title.value;

    return pageTitle ? `${pageTitle} | ${SITE}` : SITE;
  });

  const desc = computed(() => description?.value || '');
  const url = computed(() => path?.value ? `${BASE}${path.value}` : BASE);
  const image_ = computed(() => image?.value || DEFAULT_IMAGE);

  useHead({
    title: fullTitle,
    meta: computed(() => {
      const metaTags: {
        name?: string;
        property?: string;
        content: string;
      }[] = [];

      if (desc.value) {
        metaTags.push({
          name: 'description',
          content: desc.value,
        });
      }

      if (tags?.value?.length) {
        metaTags.push({
          name: 'keywords',
          content: tags.value.join(', '),
        });
      }

      if (author?.value) {
        metaTags.push({
          name: 'author',
          content: author.value,
        });
      }

      metaTags.push({
        property: 'og:title',
        content: fullTitle.value,
      });
      metaTags.push({
        property: 'og:url',
        content: url.value,
      });
      metaTags.push({
        property: 'og:type',
        content: type,
      });
      metaTags.push({
        property: 'og:image',
        content: image_.value,
      });
      if (desc.value) {
        metaTags.push({
          property: 'og:description',
          content: desc.value,
        });
      }

      if (type === 'article') {
        if (publishedTime?.value) {
          metaTags.push({
            property: 'article:published_time',
            content: publishedTime.value,
          });
        }
        if (modifiedTime?.value) {
          metaTags.push({
            property: 'article:modified_time',
            content: modifiedTime.value,
          });
        }
        if (tags?.value?.length) {
          for (const tag of tags.value) {
            metaTags.push({
              property: 'article:tag',
              content: tag,
            });
          }
        }
      }

      metaTags.push({
        name: 'twitter:card',
        content: 'summary_large_image',
      });
      metaTags.push({
        name: 'twitter:title',
        content: fullTitle.value,
      });
      metaTags.push({
        name: 'twitter:image',
        content: image_.value,
      });
      if (desc.value) {
        metaTags.push({
          name: 'twitter:description',
          content: desc.value,
        });
      }

      return metaTags;
    }),
    link: computed(() => [
      {
        rel: 'canonical',
        href: url.value,
      },
    ]),
  });
}

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
