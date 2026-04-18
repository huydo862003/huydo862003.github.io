<template>
  <div class="h-full overflow-y-auto text-sm p-2">
    <div class="flex items-center justify-between px-1 pb-2 mb-2 border-b border-gray-200">
      <span class="font-semibold text-gray-700">Explorer</span>
      <div class="flex items-center gap-0.5">
        <button
          class="p-1 rounded hover:bg-gray-100 text-gray-400"
          title="Refresh"
          @click="store.loadJourneyTree()"
        >
          <PhArrowClockwise :size="14" />
        </button>
        <button
          class="p-1 rounded hover:bg-gray-100 text-gray-400"
          title="Hide sidebar"
          @click="emit('hide')"
        >
          <PhSidebarSimple :size="14" />
        </button>
      </div>
    </div>

    <div
      v-if="store.treeLoading"
      class="p-4 text-gray-400 text-center"
    >
      Loading...
    </div>

    <template v-else>
      <!-- Journeys -->
      <div
        v-for="journey in store.journeyTree.journeys"
        :key="journey.slug"
        class="mb-3"
      >
        <div
          class="flex items-center gap-1.5 px-1 py-1 rounded cursor-pointer hover:bg-gray-100 font-medium text-gray-700"
          @click="toggleJourney(journey.slug)"
        >
          <PhCaretRight
            :size="10"
            class="shrink-0 text-gray-400 transition-transform duration-150"
            :class="{ 'rotate-90': openJourneys.has(journey.slug) }"
          />
          <PhCompass
            :size="14"
            class="shrink-0 text-blue-500"
          />
          <span class="truncate">{{ journey.title }}</span>
        </div>

        <div
          v-if="openJourneys.has(journey.slug)"
          class="ml-3 mt-0.5"
        >
          <template
            v-for="(items, type) in journey.resources"
            :key="type"
          >
            <div
              class="flex items-center gap-1.5 px-1 py-0.5 rounded cursor-pointer hover:bg-gray-50 text-gray-500 mt-1"
              @click="toggleSection(`${journey.slug}/${type}`)"
            >
              <PhCaretRight
                :size="9"
                class="shrink-0 text-gray-300 transition-transform duration-150"
                :class="{ 'rotate-90': openSections.has(`${journey.slug}/${type}`) }"
              />
              <component
                :is="TYPE_CONFIG[type]?.icon ?? PhFile"
                :size="13"
                class="shrink-0"
                :class="TYPE_CONFIG[type]?.color ?? 'text-gray-400'"
              />
              <span class="truncate capitalize">{{ TYPE_CONFIG[type]?.label ?? type }}</span>
              <span class="ml-auto text-xs text-gray-300">{{ items.length }}</span>
            </div>

            <div
              v-if="openSections.has(`${journey.slug}/${type}`)"
              class="ml-4"
            >
              <div
                v-for="item in items"
                :key="item.path"
                class="flex items-center gap-1.5 px-1 py-0.5 rounded cursor-pointer hover:bg-gray-50 text-gray-600"
                :class="{ 'bg-blue-50 text-blue-700 font-medium': fileStore.currentPath === item.path }"
                @click="emit('select', item.path)"
              >
                <PhFileText
                  :size="12"
                  class="shrink-0 text-gray-300"
                />
                <span class="truncate">{{ item.title }}</span>
              </div>
            </div>
          </template>
        </div>
      </div>

      <!-- Standalone sections -->
      <template
        v-for="(items, type) in store.journeyTree.standalone"
        :key="type"
      >
        <div class="mb-3">
          <div
            class="flex items-center gap-1.5 px-1 py-1 rounded cursor-pointer hover:bg-gray-100 font-medium text-gray-700"
            @click="toggleSection(String(type))"
          >
            <PhCaretRight
              :size="10"
              class="shrink-0 text-gray-400 transition-transform duration-150"
              :class="{ 'rotate-90': openSections.has(String(type)) }"
            />
            <component
              :is="TYPE_CONFIG[type]?.icon ?? PhFile"
              :size="14"
              class="shrink-0"
              :class="TYPE_CONFIG[type]?.color ?? 'text-gray-400'"
            />
            <span class="truncate capitalize">{{ TYPE_CONFIG[type]?.label ?? type }}</span>
            <span class="ml-auto text-xs text-gray-300">{{ items.length }}</span>
          </div>

          <div
            v-if="openSections.has(String(type))"
            class="ml-4"
          >
            <div
              v-for="item in items"
              :key="item.path"
              class="flex items-center gap-1.5 px-1 py-0.5 rounded cursor-pointer hover:bg-gray-50 text-gray-600"
              :class="{ 'bg-blue-50 text-blue-700 font-medium': fileStore.currentPath === item.path }"
              @click="emit('select', item.path)"
            >
              <PhFileText
                :size="12"
                class="shrink-0 text-gray-300"
              />
              <span class="truncate">{{ item.title }}</span>
            </div>
          </div>
        </div>
      </template>
    </template>
  </div>
</template>

<script setup lang="ts">
import { onMounted, reactive } from 'vue';
import {
  PhArrowClockwise, PhCaretRight, PhCompass, PhFileText, PhFile,
  PhBooks, PhLightbulb, PhFlashlight, PhMapTrifold, PhArticle, PhNewspaper,
  PhNotebook, PhUser, PhSidebarSimple,
} from '@phosphor-icons/vue';
import { useTreeStore } from '../stores/tree.store';
import { useFileStore } from '../stores/file.store';

const store = useTreeStore();
const fileStore = useFileStore();
const emit = defineEmits<{ select: [path: string]; hide: [] }>();

const openJourneys = reactive(new Set<string>());
const openSections = reactive(new Set<string>());

const TYPE_CONFIG: Record<string, { icon: unknown; color: string; label: string }> = {
  books: { icon: PhBooks, color: 'text-amber-500', label: 'Books & Chapters' },
  concepts: { icon: PhLightbulb, color: 'text-emerald-500', label: 'Concepts' },
  flashcards: { icon: PhFlashlight, color: 'text-violet-500', label: 'Flashcards' },
  phases: { icon: PhMapTrifold, color: 'text-blue-500', label: 'Phases' },
  blogs: { icon: PhArticle, color: 'text-rose-500', label: 'Blogs' },
  papers: { icon: PhNewspaper, color: 'text-cyan-500', label: 'Papers' },
  thoughts: { icon: PhNotebook, color: 'text-gray-500', label: 'Thoughts' },
  authors: { icon: PhUser, color: 'text-gray-500', label: 'Authors' },
};

function toggleJourney (slug: string) {
  if (openJourneys.has(slug)) openJourneys.delete(slug);
  else openJourneys.add(slug);
}

function toggleSection (key: string) {
  if (openSections.has(key)) openSections.delete(key);
  else openSections.add(key);
}

onMounted(() => {
  if (!store.journeyTree.journeys.length) store.loadJourneyTree();
  // auto-expand first journey
  if (store.journeyTree.journeys.length) {
    openJourneys.add(store.journeyTree.journeys[0].slug);
  }
});
</script>
