import * as dayjs from 'dayjs';

export function getMinBirthYear(yearOffset: number) {
  const currentYear = dayjs().year();
  const year = currentYear - yearOffset;
  return new Date(`${year}-01-01 00:00:01.000`);
}
