const { test, expect } = require('@playwright/test');

test('top story navigation', async ({ page }) => {
  await page.goto('https://hackernoon.com/');
  // :visible pseudoclass
  const title = page.locator('.sponsor:visible');
  await title.click();

  await expect(page).toHaveURL(
    'https://hackernoon.com/tagged/hackernoon-top-story',
  )

  await expect(page).toHaveTitle(
    "#hackernoon-top-story stories | Hacker Noon",
  )
});
