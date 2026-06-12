#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const projectRoot = path.join(__dirname, "..");
const filePath = path.join(projectRoot, "public", "Src", "NurseNancy", "NurseNancy.lua");

const functions = [
  { name: "speakSelfRess", tableName: "selfRessLines" },
  { name: "speakSingleRess", tableName: "singleRessLines" },
  { name: "speakCombatRess", tableName: "combatRessLines" },
  { name: "speakMassRess", tableName: "massRessLines" },
];

function extractFunctionBody(content, funcName) {
  const marker = `function NurseNancy.NurseNancy.${funcName}`;
  const start = content.indexOf(marker);
  if (start === -1) return null;

  // Find the start of the next speak function (or end of file)
  const nextMarker = content.indexOf("function NurseNancy.NurseNancy.speak", start + marker.length);
  return nextMarker === -1 ? content.slice(start) : content.slice(start, nextMarker);
}

function extractTableBlock(body, tableName) {
  // Match either `local tableName` or bare `tableName` followed by `= {`
  const pattern = new RegExp(`(?:local\\s+)?${tableName}\\s*=?\\s*\\n?\\s*\\{`);
  const match = body.match(pattern);
  if (!match) return "";

  const braceStart = body.indexOf("{", match.index + match[0].length - 1);
  let depth = 0;
  for (let i = braceStart; i < body.length; i++) {
    if (body[i] === "{") depth++;
    else if (body[i] === "}") {
      depth--;
      if (depth === 0) return body.slice(braceStart + 1, i);
    }
  }
  return "";
}

function countInlineEntries(tableContent) {
  return tableContent.split("\n").filter((line) => /^\s*["']/.test(line)).length;
}

function countInserts(body, tableName) {
  const pattern = new RegExp(`table\\.insert\\s*\\(\\s*${tableName}`, "g");
  return (body.match(pattern) || []).length;
}

function countFunction(content, funcName, tableName) {
  const body = extractFunctionBody(content, funcName);
  if (!body) return { inline: 0, inserts: 0, total: 0 };

  const tableBlock = extractTableBlock(body, tableName);
  const inline = countInlineEntries(tableBlock);
  const inserts = countInserts(body, tableName);

  return { inline, inserts, total: inline + inserts };
}

function run() {
  if (!fs.existsSync(filePath)) {
    console.error(`File not found: ${filePath}`);
    process.exit(1);
  }

  const content = fs.readFileSync(filePath, "utf8");

  console.log("Lines per resurrection type in NurseNancy.lua\n");

  const stats = {};
  let grandTotal = 0;

  for (const { name, tableName } of functions) {
    const { inline, inserts, total } = countFunction(content, name, tableName);
    stats[name] = { inline, inserts, total };
    grandTotal += total;

    const bar = "█".repeat(Math.ceil(total / 5));
    console.log(
      `${name.padEnd(18)} ${total.toString().padStart(3)} lines  (${inline} inline + ${inserts} inserts)  ${bar}`
    );
  }

  console.log("\n" + "─".repeat(60));
  console.log(`${"TOTAL".padEnd(18)} ${grandTotal.toString().padStart(3)} lines`);
  console.log("─".repeat(60) + "\n");

  const markdown = `## Lines per resurrection type

| Function | Inline | Inserts | Total |
|----------|--------|---------|-------|
${functions.map(({ name }) => `| ${name} | ${stats[name].inline} | ${stats[name].inserts} | ${stats[name].total} |`).join("\n")}
| **TOTAL** | | | **${grandTotal}** |

Generated: ${new Date().toISOString()}
`;

  const mdFile = path.join(projectRoot, ".release-stats.md");
  const jsonFile = path.join(projectRoot, ".release-stats.json");

  fs.writeFileSync(mdFile, markdown);
  fs.writeFileSync(
    jsonFile,
    JSON.stringify(
      { functions: stats, total: grandTotal, generated: new Date().toISOString() },
      null,
      2
    )
  );

  console.log(`Written: ${mdFile}`);
  console.log(`Written: ${jsonFile}`);
}

try {
  run();
  process.exit(0);
} catch (err) {
  console.error("Error:", err.message);
  process.exit(1);
}
