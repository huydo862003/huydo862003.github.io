<template>
  <Transition name="fade">
    <div
      v-if="open"
      class="overlay"
      @click.self="close"
    >
      <div class="palette">
        <div class="search-row">
          <GIcon
            :name="GIconName.Search"
            :size="16"
            class="search-icon"
          />
          <input
            ref="inputEl"
            v-model="query"
            type="text"
            placeholder="Search pages, concepts, flashcards..."
            class="search-input"
            @keydown.escape="close"
            @keydown.enter="go(filtered[activeIndex])"
            @keydown.down.prevent="activeIndex = Math.min(activeIndex + 1, filtered.length - 1)"
            @keydown.up.prevent="activeIndex = Math.max(activeIndex - 1, 0)"
          >
        </div>

        <div class="results">
          <div
            v-if="!query"
            class="group"
          >
            <div class="group-label">
              Navigation
            </div>
            <button
              v-for="(item, i) in navItems"
              :key="item.to"
              class="result"
              :class="{ active: i === activeIndex }"
              @click="go(item)"
              @mouseenter="activeIndex = i"
            >
              <GIcon
                v-if="item.icon"
                :name="item.icon"
                :size="14"
                class="result-icon"
              />
              <span class="result-label">{{ item.label }}</span>
              <GKbdShortcut
                v-if="item.shortcutKeys"
                :keys="item.shortcutKeys"
                class="ml-auto"
              />
            </button>
          </div>

          <div
            v-if="query && filtered.length"
            class="group"
          >
            <button
              v-for="(item, i) in filtered"
              :key="item.to"
              class="result"
              :class="{ active: i === activeIndex }"
              @click="go(item)"
              @mouseenter="activeIndex = i"
            >
              <span class="result-type">{{ item.type }}</span>
              <span class="result-label">{{ item.label }}</span>
            </button>
          </div>

          <div
            v-if="query && !filtered.length"
            class="empty"
          >
            No results for "{{ query }}"
          </div>
        </div>

        <div class="footer">
          <span class="hint">
            <GKbdShortcut :keys="[GKbdKeyName.ArrowUp, GKbdKeyName.ArrowDown]" /> navigate
          </span>
          <span class="hint">
            <GKbdShortcut :keys="[GKbdKeyName.Enter]" /> open
          </span>
          <span class="hint">
            <GKbdShortcut :keys="[GKbdKeyName.Escape]" /> close
          </span>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup lang="ts">
import {
  ref, computed, watch, nextTick,
} from 'vue';
import {
  useRouter,
} from 'vue-router';
import {
  GIcon, GIconName,
  GKbdShortcut, GKbdKeyName,
} from '@hdnax/genuix';
import {
  useConceptStore,
} from '@/stores/concepts';
import {
  useFlashcardStore,
} from '@/stores/flashcards';
import {
  useBookStore,
} from '@/stores/books';
import {
  usePhaseStore,
} from '@/stores/phases';
import {
  useBlogs,
} from '@/stores/blogs';
import {
  useJourneyStore,
} from '@/stores/journeys';

interface PaletteItem {
  label: string;
  to?: string;
  action?: () => void;
  type?: string;
  icon?: GIconName;
  shortcutKeys?: GKbdKeyName[];
}

const open = ref(false);
const query = ref('');
const activeIndex = ref(0);
const inputEl = ref<HTMLInputElement>();
const router = useRouter();

const emit = defineEmits<{ (e: 'open-graph-side'): void }>();

const conceptStore = useConceptStore();
const flashcardStore = useFlashcardStore();
const bookStore = useBookStore();
const phaseStore = usePhaseStore();
const blogStore = useBlogs();
const journeyStore = useJourneyStore();

const navItems = computed<PaletteItem[]>(() => [
  {
    label: 'Home',
    to: '/',
    icon: GIconName.Home,
    shortcutKeys: [
      GKbdKeyName.Alt,
      GKbdKeyName.h,
    ],
  },
  {
    label: 'Thoughts',
    to: '/thoughts',
    icon: GIconName.Article,
    shortcutKeys: [
      GKbdKeyName.Alt,
      GKbdKeyName.t,
    ],
  },
  {
    label: 'Journeys',
    to: '/journeys',
    icon: GIconName.Flag,
    shortcutKeys: [
      GKbdKeyName.Alt,
      GKbdKeyName.j,
    ],
  },
  {
    label: 'Open Graph (Side)',
    action: () => emit('open-graph-side'),
    icon: GIconName.Graph,
    shortcutKeys: [
      GKbdKeyName.Alt,
      GKbdKeyName.g,
    ],
  },
  ...journeyStore.journeys.map((j) => ({
    label: j.title,
    to: `/journeys/${j.slug}`,
    icon: GIconName.Flag,
  })),
]);

const searchItems = computed<PaletteItem[]>(() => {
  const items: PaletteItem[] = [];

  for (const c of conceptStore.concepts) {
    items.push({
      label: c.title,
      to: `/journeys/${c.journey}/concepts/${c.slug}`,
      type: 'concept',
    });
  }

  for (const f of flashcardStore.cards.slice(0, 200)) {
    const concept = f.concepts[0] ? conceptStore.getBySlug(f.concepts[0]) : undefined;
    const journey = concept?.journey || 'plt';
    items.push({
      label: f.question,
      to: `/journeys/${journey}/flashcards/${f.slug}`,
      type: 'flashcard',
    });
  }

  for (const b of bookStore.books) {
    items.push({
      label: b.title,
      to: `/journeys/${b.journey}/books/${b.slug}`,
      type: 'book',
    });
  }

  for (const p of phaseStore.phases) {
    items.push({
      label: p.title,
      to: `/journeys/${p.journey}/phases/${p.slug}`,
      type: 'phase',
    });
  }

  for (const b of blogStore.posts) {
    items.push({
      label: b.title,
      to: `/journeys/${b.journey}/blogs`,
      type: 'blog',
    });
  }

  items.push({
    label: 'Knowledge Graph',
    to: '/graph',
    type: 'page',
  });

  return items;
});

const filtered = computed(() => {
  if (!query.value) return navItems.value;
  const searchQuery = query.value.toLowerCase();
  return searchItems.value
    .filter((item) => item.label.toLowerCase().includes(searchQuery))
    .slice(0, 20);
});

watch(query, () => {
  activeIndex.value = 0;
});

function show () {
  open.value = true;
  query.value = '';
  activeIndex.value = 0;
  nextTick(() => inputEl.value?.focus());
}

function close () {
  open.value = false;
}

function go (item: PaletteItem | undefined) {
  if (!item) return;
  close();
  if (item.action) {
    item.action();
  } else if (item.to) {
    router.push(item.to);
  }
}

defineExpose({
  show,
  close,
  open,
});
</script>

<style scoped>
@reference "@/style.css";
.palette {
  @apply rounded-sm shadow-2xl w-[90vw] max-w-xl h-[70vh] flex flex-col overflow-hidden mt-[5vh] border;
  background-color: var(--gui-neutral-bg);
  border-color: var(--gui-neutral-border);
}
.search-row {
  @apply flex items-center gap-2 px-4 py-3 border-b;
  border-color: var(--gui-neutral-border);
}
.search-icon {
  @apply shrink-0;
  color: var(--gui-neutral-solid);
}
.search-input {
  @apply flex-1 bg-transparent text-sm outline-none;
  color: var(--gui-neutral-fg);
  &::placeholder { color: color-mix(in oklch, var(--gui-neutral-solid) 40%, transparent); }
}
.results {
  @apply flex-1 overflow-y-auto py-2;
}
.group {
  @apply px-2;
}
.group-label {
  @apply text-xs px-2 py-1;
  color: var(--gui-neutral-solid);
}
.result {
  @apply flex items-center gap-2 w-full px-2 py-1.5 rounded-sm
         text-left text-sm cursor-pointer transition-colors;
  color: var(--gui-neutral-fg-muted);
}
.result.active {
  background-color: var(--gui-neutral-bg-subtle);
  color: var(--gui-neutral-fg);
}
.result-icon {
  @apply shrink-0;
  color: var(--gui-neutral-solid);
}
.result-type {
  @apply text-xs px-1 py-px rounded-sm shrink-0 min-w-16 text-center;
  color: var(--gui-neutral-solid);
  background-color: var(--gui-neutral-bg-subtle);
}
.result-label {
  @apply truncate;
}
.empty {
  @apply text-sm text-center py-8;
  color: var(--gui-neutral-solid);
}
.footer {
  @apply flex items-center gap-4 px-4 py-2 border-t;
  border-color: var(--gui-neutral-border);
}
.hint {
  @apply flex items-center gap-1 text-xs;
  color: var(--gui-neutral-solid);
}
</style>
