import { defineStore } from 'pinia';
import { ref } from 'vue';
import type { JourneyTree } from '../services/tree.service';
import type { ContentSchema } from '../services/schema.service';
import * as treeService from '../services/tree.service';
import * as schemaService from '../services/schema.service';

export const useTreeStore = defineStore('tree', () => {
  const journeyTree = ref<JourneyTree>({ journeys: [], standalone: {} });
  const treeLoading = ref(false);
  const schemas = ref<Record<string, ContentSchema>>({});

  async function loadJourneyTree () {
    treeLoading.value = true;
    try {
      journeyTree.value = await treeService.loadJourneyTree();
    } finally {
      treeLoading.value = false;
    }
  }

  async function loadSchemas () {
    schemas.value = await schemaService.loadSchemas();
  }

  function schemaFor (contentType: string): ContentSchema | undefined {
    return schemas.value[contentType] ?? undefined;
  }

  return {
    journeyTree,
    treeLoading,
    schemas,
    loadJourneyTree,
    loadSchemas,
    schemaFor,
  };
});
