export function convertDateToISOString(dateString: string): string {
  const [day, month, year] = dateString.split('.');

  return `${year}-${month}-${day}T00:00:01.000Z`;
}
