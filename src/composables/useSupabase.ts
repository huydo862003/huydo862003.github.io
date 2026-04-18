import {
  createClient,
} from '@supabase/supabase-js';
import {
  ref, computed,
} from 'vue';
import type {
  User,
} from '@supabase/supabase-js';
import {
  useRoute,
} from 'vue-router';

const SUPABASE_URL = 'https://nohbnyxvynepzdekfjzd.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_EQRjHyuiioInquIecMzZig_99rp4C6H'; // publishable key - safe to be published with RLS policy

export const supabase = createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);

const user = ref<User | undefined>();
const loading = ref(true);

supabase.auth.getSession().then(({
  data,
}) => {
  user.value = data.session?.user ?? undefined;
  loading.value = false;

  // Workaround for SPA
  // when the user was directed to github oauth then back to the old path
  // it tells Github Pages to look for a non-existent path...
  // Solution: Redirect to the root path so Github Pages would return our page first, then navigate back to the page user was on before OAuth via session storage
  if (typeof sessionStorage !== 'undefined') {
    const returnPath = sessionStorage.getItem('auth-return');
    if (returnPath && data.session) {
      sessionStorage.removeItem('auth-return');
      window.history.replaceState(null, '', returnPath);
    }
  }
});

supabase.auth.onAuthStateChange((_event, session) => {
  user.value = session?.user ?? undefined;
});

export function useAuth () {
  const isLoggedIn = computed(() => !!user.value);
  const displayName = computed(() =>
    user.value?.user_metadata?.preferred_username
    || user.value?.user_metadata?.name
    || user.value?.email
    || '');
  const avatarUrl = computed(() =>
    user.value?.user_metadata?.avatar_url || '');
  const route = useRoute();

  function redirectUrl () {
    sessionStorage.setItem('auth-return', route.fullPath);
    return window.location.origin;
  }

  async function signInWithGithub () {
    await supabase.auth.signInWithOAuth({
      provider: 'github',
      options: {
        redirectTo: redirectUrl(),
      },
    });
  }

  async function signInWithGoogle () {
    await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: redirectUrl(),
      },
    });
  }

  async function signOut () {
    await supabase.auth.signOut();
  }

  return {
    user,
    loading,
    isLoggedIn,
    displayName,
    avatarUrl,
    signInWithGithub,
    signInWithGoogle,
    signOut,
  };
}

export function useReviewSync () {
  const syncing = ref(false);
  const error = ref('');

  async function pushState (reviewState: Record<string, unknown>) {
    if (!user.value) return;
    syncing.value = true;
    error.value = '';
    try {
      const rows = Object.entries(reviewState).map(([
        slug,
        state,
      ]) => {
        const s = state as {
          easeFactor: number;
          interval: number;
          repetitions: number;
          nextReviewDate: string;
          lastReviewedAt?: string;
        };
        return {
          user_id: user.value?.id ?? '',
          slug,
          ease_factor: s.easeFactor,
          interval: s.interval,
          repetitions: s.repetitions,
          next_review_date: s.nextReviewDate,
          last_reviewed_at: s.lastReviewedAt ?? null,
        };
      });

      const {
        error: err,
      } = await supabase
        .from('review_state')
        .upsert(rows, {
          onConflict: 'user_id,slug',
        });

      if (err) error.value = err.message;
    } catch (e) {
      error.value = (e as Error).message;
    } finally {
      syncing.value = false;
    }
  }

  async function pullState (): Promise<Record<string, unknown> | undefined> {
    if (!user.value) return undefined;
    syncing.value = true;
    error.value = '';
    try {
      const {
        data, error: err,
      } = await supabase
        .from('review_state')
        .select('*')
        .eq('user_id', user.value.id);

      if (err) {
        error.value = err.message;
        return undefined;
      }

      const state: Record<string, unknown> = {};
      for (const row of data ?? []) {
        state[row.slug] = {
          easeFactor: row.ease_factor,
          interval: row.interval,
          repetitions: row.repetitions,
          nextReviewDate: row.next_review_date,
          lastReviewedAt: row.last_reviewed_at,
        };
      }
      return state;
    } catch (e) {
      error.value = (e as Error).message;
      return undefined;
    } finally {
      syncing.value = false;
    }
  }

  return {
    syncing,
    error,
    pushState,
    pullState,
  };
}
