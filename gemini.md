# Gemini - Project Constitution

## Project Identity
**Project Name:** Selenium Java to Playwright TS/JS Converter
**Goal:** A web-based converter that transforms TestNG Selenium Java tests into modern Playwright JS/TS scripts, prioritizing readability and modern automation practices.

## Data Schemas
`ConversionRequest`:
```json
{
  "sourceCode": "string (Java/TestNG code)",
  "targetLanguage": "javascript | typescript",
  "options": {
    "usePageObjectModel": "boolean",
    "generateSetup": "boolean"
  }
}
```

`ConversionResponse`:
```json
{
  "convertedCode": "string (Playwright code)",
  "metadata": {
    "detectedFramework": "TestNG",
    "conversionSuccess": "boolean",
    "warnings": ["string"]
  }
}
```

## Behavioral Rules
1. **Deterministic & AI-Assisted Mapping:** Use structured mapping for common Selenium/TestNG patterns, supplemented by AI for complex logic.
2. **Prioritize Readability:** Output should look like "hand-written" Playwright code (e.g., using `locator` vs `findElement`).
3. **Async Everything:** All Playwright actions must be correctly `await`-ed.
4. **UI-Driven:** The primary interface is a polished web UI.
5. **Persistence:** Save every conversion to a local `converted/` directory for historical tracking.

## Architectural Invariants
- Layered approach: `architecture/` for SOPs, `tools/` for scripts.
- No direct logic in the main agent flow; delegate to specific tools.

## Maintenance Log
- **2026-02-05**: Initial Release (v1.0.0). Built on BLAST-ANT protocol. Universal converter with 32-bit line tracking and strict syntax validation.
