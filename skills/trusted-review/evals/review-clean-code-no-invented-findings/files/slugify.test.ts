import { strict as assert } from "node:assert";
import { test } from "node:test";
import { slugify } from "./slugify.ts";

test("slugify", () => {
  assert.equal(slugify("Héllo, World!"), "hello-world");
  assert.equal(slugify("  --a  b--  "), "a-b");
  assert.equal(slugify("!!!"), "");
});
