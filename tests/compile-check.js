#!/usr/bin/env node

const fs = require("fs");
const path = require("path");
const parse = require("luaparse").parse;

const projectRoot = path.join(__dirname, "..");
let errorCount = 0;

console.log("🧪 Nurse Nancy - Addon Compilation Check\n");

// Helper function to find files recursively
function findFiles(dir, extension) {
  let files = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });

  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);

    if (entry.isDirectory()) {
      if (!entry.name.startsWith(".")) {
        files = files.concat(findFiles(fullPath, extension));
      }
    } else if (entry.name.endsWith(extension)) {
      files.push(fullPath);
    }
  }

  return files;
}

// Check Lua syntax
function checkLuaSyntax() {
  console.log("📋 Checking Lua files for syntax errors...");
  const luaFiles = findFiles(path.join(projectRoot, "public"), ".lua");

  if (luaFiles.length === 0) {
    console.log("⚠️  No Lua files found\n");
    return;
  }

  let luaErrors = 0;

  for (const file of luaFiles) {
    try {
      const content = fs.readFileSync(file, "utf8");
      parse(content, { luaVersion: "5.1" });
      console.log(`✅ ${path.relative(projectRoot, file)}`);
    } catch (error) {
      errorCount++;
      luaErrors++;
      const relPath = path.relative(projectRoot, file);
      console.log(`❌ ${relPath}`);
      console.log(`   Error: ${error.message}`);
    }
  }

  console.log(
    `\nLua syntax check: ${luaFiles.length - luaErrors}/${luaFiles.length} files valid\n`
  );
}

// Check .toc files
function checkTocFiles() {
  console.log("📋 Checking .toc files...");
  const tocFiles = findFiles(path.join(projectRoot, "public"), ".toc");

  if (tocFiles.length === 0) {
    console.log("⚠️  No .toc files found\n");
    return;
  }

  let tocErrors = 0;

  for (const file of tocFiles) {
    try {
      const content = fs.readFileSync(file, "utf8");

      // Check for common issues
      const issues = [];

      // Check for empty title
      if (!content.includes("## Title:")) {
        issues.push("Missing ## Title field");
      }

      // Check for interface version
      if (!content.includes("## Interface:")) {
        issues.push("Missing ## Interface field");
      }

      // Check for duplicated lines (common error)
      const lines = content.split("\n");
      const lineMap = new Map();
      for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        if (line && !line.startsWith("##")) {
          if (lineMap.has(line)) {
            issues.push(
              `Duplicate file reference on lines ${lineMap.get(line) + 1} and ${i + 1}: ${line}`
            );
          } else {
            lineMap.set(line, i);
          }
        }
      }

      if (issues.length > 0) {
        errorCount++;
        tocErrors++;
        console.log(`❌ ${path.relative(projectRoot, file)}`);
        issues.forEach((issue) => console.log(`   - ${issue}`));
      } else {
        console.log(`✅ ${path.relative(projectRoot, file)}`);
      }
    } catch (error) {
      errorCount++;
      tocErrors++;
      const relPath = path.relative(projectRoot, file);
      console.log(`❌ ${relPath}`);
      console.log(`   Error: ${error.message}`);
    }
  }

  console.log(
    `\n.toc files check: ${tocFiles.length - tocErrors}/${tocFiles.length} files valid\n`
  );
}

// Check for common text file errors
function checkTextFiles() {
  console.log("📋 Checking text files for common errors...");
  const extensions = [".lua", ".toc", ".xml"];
  let textFiles = [];

  for (const ext of extensions) {
    textFiles = textFiles.concat(findFiles(path.join(projectRoot, "public"), ext));
  }

  if (textFiles.length === 0) {
    console.log("⚠️  No text files found\n");
    return;
  }

  let textErrors = 0;

  for (const file of textFiles) {
    try {
      const content = fs.readFileSync(file, "utf8");
      const issues = [];

      // Check for common encoding issues (null bytes)
      if (content.includes("\0")) {
        issues.push("Contains null bytes");
      }

      // Check for mixed line endings
      const hasWindowsEndings = content.includes("\r\n");
      const hasUnixEndings = content.includes("\n") && !hasWindowsEndings;
      if (hasWindowsEndings && hasUnixEndings) {
        issues.push("Mixed line endings (CRLF and LF)");
      }

      // Check for tabs vs spaces (warning only)
      const lines = content.split("\n");
      for (let i = 0; i < lines.length; i++) {
        if (lines[i].startsWith("\t")) {
          issues.push(`Line ${i + 1}: Uses tabs for indentation`);
          break; // Only report first occurrence
        }
      }

      if (issues.length > 0) {
        errorCount++;
        textErrors++;
        console.log(`❌ ${path.relative(projectRoot, file)}`);
        issues.forEach((issue) => console.log(`   - ${issue}`));
      }
    } catch (error) {
      errorCount++;
      textErrors++;
      const relPath = path.relative(projectRoot, file);
      console.log(`❌ ${relPath}`);
      console.log(`   Error: ${error.message}`);
    }
  }

  console.log(
    `\nText files check: ${textFiles.length - textErrors}/${textFiles.length} files valid\n`
  );
}

// Run all checks
try {
  checkLuaSyntax();
  checkTocFiles();
  checkTextFiles();

  // Final summary
  console.log("═".repeat(50));
  if (errorCount === 0) {
    console.log("✅ All checks passed!");
    process.exit(0);
  } else {
    console.log(`❌ Found ${errorCount} error(s)`);
    process.exit(1);
  }
} catch (error) {
  console.error("Fatal error:", error.message);
  process.exit(1);
}
