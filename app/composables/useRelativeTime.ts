export function useRelativeTime(locale = "es") {
  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: "auto" });

  function format(date: string | Date): string {
    const d = typeof date === "string" ? new Date(date) : date;
    const now = Date.now();
    const diff = (d.getTime() - now) / 1000;

    const thresholds: [number, Intl.RelativeTimeFormatUnit][] = [
      [60, "second"],
      [3600, "minute"],
      [86400, "hour"],
      [604800, "day"],
      [2592000, "week"],
      [31536000, "month"],
    ];

    const idx = thresholds.findIndex(([limit]) => Math.abs(diff) < limit);
    if (idx !== -1) {
      const [, unit] = thresholds[idx]!;
      const divisor = thresholds[idx - 1]?.[0] ?? 1;
      return rtf.format(Math.round(diff / divisor), unit);
    }

    return rtf.format(Math.round(diff / 31536000), "year");
  }

  return { format };
}
