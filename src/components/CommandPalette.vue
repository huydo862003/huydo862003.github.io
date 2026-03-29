<template>
  <Transition name="fade">
    <div
      v-if="open"
      class="overlay"
      @click.self="close"
    >
      <div class="palette">
        <div class="search-row">
          <PhMagnifyingGlass
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
              <component
                :is="item.icon"
                v-if="item.icon"
                :size="14"
                class="result-icon"
              />
              <span class="result-label">{{ item.label }}</span>
              <SKbdShortcut
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
            <SKbdShortcut :keys="['↑', '↓']" /> navigate
          </span>
          <span class="hint">
            <SKbdShortcut :keys="['↵']" /> open
          </span>
          <span class="hint">
            <SKbdShortcut :keys="['Esc']" /> close
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
import { useRouter } from 'vue-router';
import {
  PhHouse, PhFlag, PhArticle,
  PhMagnifyingGlass,
} from '@phosphor-icons/vue';
import { useConceptStore } from '@/stores/concepts';
import { useFlashcardStore } from '@/stores/flashcards';
import { useBookStore } from '@/stores/books';
import { usePhaseStore } from '@/stores/phases';
import { useBlogs } from '@/stores/blogs';
import { useJourneyStore } from '@/stores/journeys';
import SKbdShortcut from '@/components/common/SKbdShortcut.vue';

interface PaletteItem {
  label: string;
  to: string;
  type?: string;
  icon?: object;
  shortcutKeys?: string[];
}

const open = ref(false);
const query = ref('');
const activeIndex = ref(0);
const inputEl = ref<HTMLInputElement>();
const router = useRouter();

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
    icon: PhHouse,
    shortcutKeys: ['Alt', 'H'],
  },
  {
    label: 'Thoughts',
    to: '/thoughts',
    icon: PhArticle,
    shortcutKeys: ['Alt', 'T'],
  },
  {
    label: 'Journeys',
    to: '/journeys',
    icon: PhFlag,
    shortcutKeys: ['Alt', 'J'],
  },
  ...journeyStore.journeys.map((j) => ({
    label: j.title,
    to: `/journeys/${j.slug}`,
    icon: PhFlag,
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

  for (const b of blogStore.blogs) {
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
  const q = query.value.toLowerCase();
  return searchItems.value
    .filter((item) => item.label.toLowerCase().includes(q))
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
  router.push(item.to);
  close();
}

defineExpose({
  show,
  close,
  open,
});
</script>

<style scoped>
@reference "../style.css";
@reference "../style.css";
.palette {
  @apply bg-bg border border-border rounded-sm shadow-2xl
         w-[90vw] max-w-xl h-[70vh] flex flex-col overflow-hidden
         mt-[5vh];
}
.search-row {
  @apply flex items-center gap-2 px-4 py-3 border-b border-border;
}
.search-icon {
  @apply text-fg-faint shrink-0;
}
.search-input {
  @apply flex-1 bg-transparent text-sm text-fg outline-none
         placeholder:text-fg-faint/40;
}
.results {
  @apply flex-1 overflow-y-auto py-2;
}
.group {
  @apply px-2;
}
.group-label {
  @apply text-xs text-fg-faint px-2 py-1;
}
.result {
  @apply flex items-center gap-2 w-full px-2 py-1.5 rounded-sm
         text-left text-sm text-fg-muted cursor-pointer transition-colors;
}
.result.active {
  @apply bg-bg-subtle text-fg;
}
.result-icon {
  @apply text-fg-faint shrink-0;
}
.result-type {
  @apply text-xs text-fg-faint bg-bg-subtle px-1 py-px rounded-sm shrink-0 w-16 text-center;
}
.result-label {
  @apply truncate;
}
.empty {
  @apply text-sm text-fg-faint text-center py-8;
}
.footer {
  @apply flex items-center gap-4 px-4 py-2 border-t border-border;
}
.hint {
  @apply flex items-center gap-1 text-xs text-fg-faint;
}
</style>
