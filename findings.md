### TestNG to Playwright Mapping

| TestNG (Java) | Playwright (TS/JS) | Description |
| :--- | :--- | :--- |
| `@Test` | `test('name', async ({ page }) => { ... })` | Individual test case |
| `@BeforeMethod` | `test.beforeEach(async ({ page }) => { ... })` | Runs before each test |
| `@AfterMethod` | `test.afterEach(async ({ page }) => { ... })` | Runs after each test |
| `@BeforeClass` | `test.beforeAll(async () => { ... })` | Runs once before all tests |
| `@AfterClass` | `test.afterAll(async () => { ... })` | Runs once after all tests |
| `enabled = false` | `test.skip()` | Skips the test |
| `priority = 1` | (Custom grouping) | Playwright executes in order or parallel |

### Selenium to Playwright Locator Mapping

| Selenium (Java) | Playwright (TS/JS) |
| :--- | :--- |
| `driver.get("url")` | `await page.goto("url")` |
| `driver.findElement(By.id("id"))` | `page.locator("#id")` or `page.getByTestId("id")` |
| `driver.findElement(By.cssSelector(".class"))` | `page.locator(".class")` |
| `driver.findElement(By.xpath("//xpath"))` | `page.locator("//xpath")` |
| `element.click()` | `await element.click()` |
| `element.sendKeys("text")` | `await element.fill("text")` |
| `element.getText()` | `await element.textContent()` |
| `Thread.sleep(ms)` | `await page.waitForTimeout(ms)` (Not recommended) |
| `WebDriverWait` | (Auto-waiting built-in) or `page.waitForSelector()` |

### UI Design Strategy
- **Framework**: Vite + React or Vanilla JS (User preference for "premium" feel).
- **Layout**: Two-pane editor (Source: Left, Result: Right).
- **Features**: 
    - Syntax highlighting.
    - Copy to clipboard.
    - Download `.spec.ts` file.
    - Toggle for JavaScript / TypeScript.

### Potential Strategies
1. **Regex-based:** Simple but fragile for complex logic.
2. **AST (Abstract Syntax Tree):** More robust for code transformation. Use a Java parser to extract logic.
3. **LLM-assisted:** Use AI to handle the nuances of logic conversion while maintaining structure.
