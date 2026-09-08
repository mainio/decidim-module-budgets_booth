// We are customizing this functionality at decidim/budgets_booth/projects.js
// which is why we have disabled the default functionality by overriding this
// file.

// This is still needed because `budgetSummaryBackdrop.js` assumes this has
// already been set by this file.
document.addEventListener("turbo:load", () => {
  window.DecidimBudgets = window.DecidimBudgets || {};
});
