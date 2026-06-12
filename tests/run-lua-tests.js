#!/usr/bin/env node

const { execFileSync } = require("child_process");
const path = require("path");
const fs = require("fs");

const testDir = path.join(__dirname, "lua");
const luaFiles = fs
  .readdirSync(testDir)
  .filter((f) => f.startsWith("test_") && f.endsWith(".lua"))
  .sort()
  .map((f) => path.join(testDir, f));

let failed = 0;

console.log("🧪 Nurse Nancy - Lua Unit Tests\n");

for (const file of luaFiles) {
  const label = path.basename(file);
  try {
    const output = execFileSync("lua", [file], { encoding: "utf8" });
    process.stdout.write(output);
    if (!/^OK /m.test(output)) failed++;
  } catch (err) {
    failed++;
    console.log(`❌ ${label}`);
    if (err.stdout) process.stdout.write(err.stdout);
    if (err.stderr) process.stderr.write(err.stderr);
  }
}

console.log("\n" + "═".repeat(50));
if (failed === 0) {
  console.log("✅ All Lua test suites passed");
  process.exit(0);
} else {
  console.log(`❌ ${failed} Lua test suite(s) failed`);
  process.exit(1);
}
