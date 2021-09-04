const { test, expect } = require('@playwright/test');

test('top story navigation', async ({ page }) => {
  await page.goto('https://hackernoon.com/');

  // search for "Top Stories" text then filter down to visible
  await page.click('text=Top Stories >> visible=true');

  await expect(page).toHaveURL(
    'https://hackernoon.com/tagged/hackernoon-top-story',
  )

  await expect(page).toHaveTitle(
    "#hackernoon-top-story stories | Hacker Noon",
  )
});
