/**
 * Turn a title into a URL slug
 *
 * Lowercases, strips accents, and joins words with single hyphens. Returns an empty string when nothing is left.
 *
 * @example slugify("Héllo, World!") // "hello-world"
 */
export function slugify(title: string): string {
  return title
    .normalize("NFKD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
