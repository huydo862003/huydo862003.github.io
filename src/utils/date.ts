import {
  format, addDays,
} from 'date-fns';

const DATE_FORMAT = 'yyyy-MM-dd';

export function todayISO (): string {
  return format(new Date(), DATE_FORMAT);
}

export function addDaysISO (days: number): string {
  return format(addDays(new Date(), days), DATE_FORMAT);
}
