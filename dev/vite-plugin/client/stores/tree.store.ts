import {
  defineStore,
} from 'pinia';
import {
  ref,
} from 'vue';
import type {
  TreeNode,
} from '../services/tree.service';
import type {
  ContentSchema,
} from '../services/schema.service';
import * as treeService from '../services/tree.service';
import * as schemaService from '../services/schema.service';

export const useTreeStore = defineStore('tree', () => {
  const tree = ref<TreeNode[]>([]);
  const treeLoading = ref(false);
  const schemas = ref<Record<string, ContentSchema>>({});

  async function loadTree () {
    treeLoading.value = true;
    try {
      tree.value = await treeService.loadTree();
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
    tree,
    treeLoading,
    schemas,
    loadTree,
    loadSchemas,
    schemaFor,
  };
});
