import * as dayjs from 'dayjs';

export function getMaxBirthYear(yearOffset: number) {
  const currentYear = dayjs().year();
  const year = currentYear - yearOffset;
  return new Date(`${year}-12-31 23:59:59.000`);
}
