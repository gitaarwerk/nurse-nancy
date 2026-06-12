#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const projectRoot = path.join(__dirname, '..');
const features = [
  'Compliment',
  'Flirt',
  'DanceWithMe',
  'GivePresent',
  'Joke',
  'RandomPhrases',
  'Rude',
  'Seduce',
];

/**
 * Count the number of message entries in a feature file.
 * This counts:
 * 1. String entries in the main *Lines table
 * 2. table.insert() calls that add to that table
 */
function countFeatureLines(featureName) {
  const filePath = path.join(
    projectRoot,
    'public',
    'Src',
    'ConversationButtons',
    featureName,
    `${featureName}.lua`
  );

  if (!fs.existsSync(filePath)) {
    console.warn(`⚠️  File not found: ${filePath}`);
    return 0;
  }

  const content = fs.readFileSync(filePath, 'utf8');

  // Find the main table (e.g., ComplimentLines, FlirtLines, etc.)
  const tablePattern = new RegExp(
    `local ${featureName}Lines\\s*=\\s*\\{([^}]+)\\}`,
    's'
  );
  const tableMatch = content.match(tablePattern);

  let count = 0;

  // Count entries in the main table
  if (tableMatch) {
    const tableContent = tableMatch[1];
    // Count quoted strings (lines with actual messages)
    const stringMatches = tableContent.match(/["'`][^"'`]*["'`]/g) || [];
    count += stringMatches.length;
  }

  // Count table.insert calls for this feature
  const insertPattern = new RegExp(
    `table\\.insert\\(${featureName}Lines,\\s*["'`]`,
    'g'
  );
  const insertMatches = content.match(insertPattern) || [];
  count += insertMatches.length;

  return count;
}

/**
 * Generate markdown for release notes
 */
function generateReleaseNotes() {
  console.log('📊 Content Statistics:\n');

  const stats = {};
  let totalLines = 0;

  for (const feature of features) {
    const count = countFeatureLines(feature);
    stats[feature] = count;
    totalLines += count;

    const bar = '█'.repeat(Math.ceil(count / 10));
    console.log(`${feature.padEnd(16)} ${count.toString().padStart(3)} lines  ${bar}`);
  }

  console.log('\n' + '─'.repeat(50));
  console.log(`${'TOTAL'.padEnd(16)} ${totalLines.toString().padStart(3)} lines`);
  console.log('─'.repeat(50) + '\n');

  // Generate markdown
  const markdown = `## 📊 Content Statistics

| Feature | Line Count |
|---------|-----------|
${features.map((f) => `| ${f} | ${stats[f]} |`).join('\n')}
| **TOTAL** | **${totalLines}** |

---
Generated on: ${new Date().toISOString()}
`;

  return { markdown, stats, totalLines };
}

/**
 * Write statistics to a file
 */
function writeStats() {
  const { markdown, stats, totalLines } = generateReleaseNotes();

  const outputFile = path.join(projectRoot, '.release-stats.md');
  fs.writeFileSync(outputFile, markdown);

  // Also write as JSON for easier parsing in GitHub Actions
  const jsonFile = path.join(projectRoot, '.release-stats.json');
  fs.writeFileSync(
    jsonFile,
    JSON.stringify({ features: stats, total: totalLines, generated: new Date().toISOString() }, null, 2)
  );

  console.log(`✅ Statistics written to ${outputFile}`);
  console.log(`✅ JSON stats written to ${jsonFile}`);
}

// Run
try {
  writeStats();
  process.exit(0);
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
}
