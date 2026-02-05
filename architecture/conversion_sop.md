# SOP: Selenium Java to Playwright Conversion

## Goal
Accurately convert TestNG-based Selenium Java code into readable Playwright JavaScript/TypeScript code.

## Inputs
- `sourceCode`: Raw Java code.
- `targetLanguage`: `javascript` or `typescript`.

## Process
1. **Preamble**: Identify the main test class and its imports.
2. **Hook Mapping**:
    - `@BeforeSuite`, `@BeforeClass` -> `test.beforeAll()`
    - `@BeforeMethod` -> `test.beforeEach()`
    - `@Test` -> `test('Name', async ({ page }) => { ... })`
3. **Locator Mapping**:
    - Convert `By.id("foo")` to `#foo`.
    - Convert `By.xpath("...")` to `xpath=...`.
    - Prefer `page.locator()` or `page.getBy...()` for readability.
4. **Action Mapping**:
    - `element.click()` -> `await element.click()`.
    - `element.sendKeys()` -> `await element.fill()`.
5. **Assertion Mapping**:
    - `Assert.assertEquals(a, b)` -> `expect(a).toBe(b)`.
6. **Refinement**:
    - Remove redundant manual waits (`Thread.sleep`).
    - Ensure all calls use the `page` fixture.
    - Format with standard JS/TS conventions.

## Tool Logic (converter.ps1)
- Sends the source code to Ollama's `/api/chat` endpoint.
- Uses a system prompt containing the above mapping rules.
- Extracts the code block from the response.
- Saves the result to the `converted/` directory.
