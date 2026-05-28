# Yindii Flutter Intern — Coding Challenge

Welcome! You will work on **Rescue Bites**, a small surplus-food marketplace app (fictional data, no connection to production Yindii code).

**Timebox:** 3–4 hours (we respect if you need a bit more — tell us).  
**Deliverable:** A Git repository with your changes + short `SOLUTION.md` (see below).

You may use **any AI coding tools** (Cursor, Copilot, ChatGPT, etc.). We evaluate *how* you use them, not whether you used them.

---

## Setup

Use Flutter version 3.27.0

```bash
flutter pub get
flutter run
```

The app should launch to a home feed of surplus offers, with Cart and Profile tabs.

Read the codebase first — it follows patterns similar to our production Flutter app (GetX, bindings, repositories, `.tr` strings).

---

## What we assess

| Area | What we look for |
|------|------------------|
| Problem solving | You break tasks down, prioritize, ship working increments |
| AI tool use | Clear prompts, you verify output, you fix hallucinations |
| Navigation | You find controllers, bindings, routes, repos without hand-holding |
| Speed | Meaningful progress in the timebox; not perfection on everything |
| Debugging | You reproduce issues, trace data flow, fix root cause |

---

## Required tasks (do in order)

### Task A1 — Home search & category filters *(~45 min)*

**Symptoms today:**
- Typing in the search bar does nothing.
- Tapping Bakery / Cafe / Market chips does not filter the list.

**Expected behavior:**
- Search filters by **offer title** or **store name** (case-insensitive).
- Category chips filter by `category` (`bakery`, `cafe`, `market`; “All” shows everything).
- Search + filter work **together**.

**Hints:** `HomeScreenController`, `home_screen.dart`. Keep logic in the controller, not the widget.

---

### Task A2 — Offer details screen *(~60 min)*

**Symptoms today:** Tapping an offer opens a “TODO” placeholder.

**Expected behavior:**
- Full details screen: image, title, store, prices, discount %, pickup window, quantity left, CO₂ badge.
- **Add to bag** with quantity stepper (1 … `quantityLeft`).
- Success feedback (snackbar) and cart badge updates.
- Register GetX **binding + controller** the same way other screens do.

**Route:** `Routes.offerDetails` with `Get.parameters['id']`.

---

### Task A3 — Pull to refresh on Home *(~20 min)*

Wire pull-to-refresh on the offer list to reload offers (use `pull_to_refresh` or `RefreshIndicator` — match project style).

---

### Task A4 — Empty state on Home *(~15 min)*

When no offers match filters/search (or API returns empty), show a friendly empty state using `empty_offers`.tr — not a blank screen.

---

## Bug fixes (find & fix — we do not tell you where)

Reproduce each issue in the running app, then fix the root cause.

| ID | Symptom |
|----|---------|
| **B1** | On offer details (after you build it), CO₂ always shows **0** even though mock data has values. |
| **B2** | Tapping the heart on Home does not update the favorite icon until you restart the app. |
| **B3** | Cart **Total** uses original prices instead of discounted rescue prices. |

Document each fix in `SOLUTION.md` (1–2 sentences: cause + fix).

---

## Optional stretch (only if time remains)

- **S1:** Unit test for cart total calculation (`test/cart_service_test.dart`).
- **S2:** Persist and show “favorites only” filter on Home.
- **S3:** Simple shimmer loading on Home while offers load.

---

## Submission

1. Add **`SOLUTION.md`** at project root:

```markdown
# Solution — Your Name

## Time spent
~X hours

## Tasks completed
- A1: ...
- A2: ...
(list all)

## Bugs fixed
- B1: ...
- B2: ...
- B3: ...

## AI tools used
(Which tools, example prompts, what you verified manually)

## If I had more time
...
```

4. Create an initial commit, add your changes to new a commit and push to a public repository. Send us the link.


---

## Rules

- ✅ Use GetX patterns already in the codebase.
- ✅ Use `.tr` for user-visible strings (add keys to `assets/language/en.json` and `th.json` if needed).
- ❌ Do not add heavy new dependencies without a note in `SOLUTION.md`.

Good luck — we are excited to see how you ship! 🌱
