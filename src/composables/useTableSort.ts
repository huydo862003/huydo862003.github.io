import {
  ref,
} from 'vue';

export function useTableSort (initial = '') {
  const sortKey = ref(initial);
  const sortAsc = ref(true);

  function toggleSort (key: string) {
    if (sortKey.value !== key) {
      sortKey.value = key;
      sortAsc.value = true;
    } else if (sortAsc.value) {
      sortAsc.value = false;
    } else {
      sortKey.value = '';
    }
  }

  function sortIcon (key: string): string {
    if (sortKey.value !== key) return '';
    return sortAsc.value ? '↑' : '↓';
  }

  return {
    sortKey,
    sortAsc,
    toggleSort,
    sortIcon,
  };
}
