<template>
  <div class="td-checklist">
    <p v-if="label" class="td-checklist__label-heading">{{ label }}</p>
    <div ref="slotElement" class="td-checklist__source">
      <slot />
    </div>
    <ul v-if="items.length" class="td-checklist__list">
      <li
        v-for="(item, index) in items"
        :key="index"
        class="td-checklist__item"
        :class="{ 'td-checklist__item--checked': state[index] }"
      >
        <label class="td-checklist__label">
          <input
            type="checkbox"
            class="td-checklist__checkbox"
            :checked="state[index]"
            @change="toggle(index)"
          />
          <span class="td-checklist__text">{{ item }}</span>
        </label>
      </li>
    </ul>
    <p v-if="items.length" class="td-checklist__meta">
      {{ checkedCount }} / {{ items.length }} - resets
      {{ reset === "weekly" ? "every week" : "every month" }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from "vue";

const { storageKey, reset, label } = defineProps<{
  /** localStorage namespace key */
  storageKey: string;
  /** Auto-reset period */
  reset: "weekly" | "monthly";
  /** Optional heading label */
  label?: string;
}>();

const slotElement = ref<HTMLElement | null>(null);
const items = ref<string[]>([]);
const state = reactive<Record<number, boolean>>({});

const checkedCount = computed(
  () => Object.values(state).filter(Boolean).length,
);

function stateKey() {
  return `td-checklist:${storageKey}:state`;
}

function periodKey() {
  return `td-checklist:${storageKey}:period`;
}

function currentPeriod(): string {
  const now = new Date();
  if (reset === "weekly") {
    const d = new Date(
      Date.UTC(now.getFullYear(), now.getMonth(), now.getDate()),
    );
    const day = d.getUTCDay() || 7;
    d.setUTCDate(d.getUTCDate() + 4 - day);
    const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
    const week = Math.ceil(
      ((d.valueOf() - yearStart.valueOf()) / 86400000 + 1) / 7,
    );
    return `${d.getUTCFullYear()}-W${week}`;
  }
  return `${now.getFullYear()}-${now.getMonth() + 1}`;
}

function load() {
  try {
    const period = currentPeriod();
    const lastPeriod = localStorage.getItem(periodKey());
    if (lastPeriod !== period) {
      localStorage.removeItem(stateKey());
      localStorage.setItem(periodKey(), period);
    }
    const saved = localStorage.getItem(stateKey());
    if (saved) {
      const parsed = JSON.parse(saved) as Record<number, boolean>;
      for (const [key, value] of Object.entries(parsed)) {
        state[Number(key)] = value;
      }
    }
  } catch {}
}

function save() {
  try {
    localStorage.setItem(stateKey(), JSON.stringify({ ...state }));
  } catch {}
}

function toggle(i: number) {
  state[i] = !state[i];
  save();
}

onMounted(() => {
  if (!slotElement.value) return;
  const lis = slotElement.value.querySelectorAll("li");
  items.value = Array.from(lis)
    .map((li) => li.textContent?.trim() ?? "")
    .filter(Boolean);
  slotElement.value.style.display = "none";
  load();
});
</script>

<style scoped>
.td-checklist {
  border: 1px solid var(--vp-c-divider, #e2e8f0);
  border-radius: 8px;
  padding: 1rem 1.25rem;
  margin: 1rem 0;
}

.td-checklist__list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.td-checklist__item {
  margin: 0.35rem 0;
}

.td-checklist__label {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  cursor: pointer;
  user-select: none;
}

.td-checklist__checkbox {
  width: 1rem;
  height: 1rem;
  flex-shrink: 0;
  cursor: pointer;
}

.td-checklist__text {
  font-size: 0.95rem;
  transition: opacity 0.15s;
}

.td-checklist__item--checked .td-checklist__text {
  opacity: 0.45;
  text-decoration: line-through;
}

.td-checklist__label-heading {
  margin: 0 0 0.6rem;
  font-size: 0.85rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--vp-c-text-2, #94a3b8);
}

.td-checklist__meta {
  margin: 0.75rem 0 0;
  font-size: 0.8rem;
  color: var(--vp-c-text-2, #94a3b8);
}
</style>
