# Solution — Pakawat Khamvengjan

## Time spent

~2+ hours (for Tasks A1-A4, Bugs B1-B3, and Stretch Goals S1-S3)

## Tasks completed

- **A1: Home search & category filters**
  - Implemented real-time case-insensitive filtering for both offer titles and store names.
  - Linked category chips (`bakery`, `cafe`, `market`, and `all` to show everything) to filter offers dynamically.
  - Connected the `TextField`'s `onChanged` callback to the controller's `setSearchQuery` method.
  - Combined both category selection and search query constraints reactively using GetX's `Obx` system without manual state resets, keeping logic clean and highly responsive.
- **A2: Offer details screen**
  - Replaced the temporary "TODO Placeholder" details screen with a modern, high-fidelity UI layout.
  - Structured standard GetX patterns by creating `OfferDetailsBindings` and `OfferDetailsController` to fetch item details asynchronously based on route parameters (`id`).
  - Added a reactive quantity stepper constrained between 1 and the available quantity (`quantityLeft`).
  - Crafted a premium sticky bottom action bar ("Add to bag") that computes the total price dynamically.
  - Connected the action bar to the centralized `CartService` so that when tapped, it fires a beautiful success snackbar and automatically updates the global shopping bag badge.
  - Added English and Thai translation keys (`"added_to_bag"`) to `assets/language/en.json` and `th.json` for proper localized success feedback.
- **A3: Pull to refresh on Home**
  - Wrapped the home screen `ListView.builder` inside a standard Flutter `RefreshIndicator` connected to the controller's `onRefresh` action.
  - Added `AlwaysScrollableScrollPhysics` to ensure pull-to-refresh works fluidly even when the item list is short.
- **A4: Empty state on Home**
  - Designed and built a high-fidelity scrollable empty state widget utilizing the key `'empty_offers'.tr` and `Icons.no_food_outlined` to inform users when search/category constraints find no food offers.
  - Wrapped the empty state layout in a `SingleChildScrollView` with `AlwaysScrollableScrollPhysics` inside a `RefreshIndicator` so that users can seamlessly pull-to-refresh to fetch new offers even when the list is empty.
- **S1 (Stretch): Unit test for cart total calculation**
  - Wrote a comprehensive unit test suite in [cart_service_test.dart] covering all calculations in `CartService`.
  - Injected a `FakeCartRepo` to isolate and mock data retrieval.
  - Covered 5 distinct test scenarios: `CartItemModel` line total calculation, empty cart total initialization, single item cart calculation, multiple mixed items cumulative calculation, and defensive stock limit exceptions (our Custom Bug).
- **S2 (Stretch): Persist and show "favorites only" filter on Home**
  - Elevated the Favorites filter from a standard category chip to a premium screen-level App Bar action toggle button (heart icon) for a realistic, high-fidelity UX.
  - Built a dynamic empty state layout presenting a heart icon and the custom message `"empty_favorites".tr` ("You don't have any favorites yet.") when favorites filtering yields no results.
  - Integrated `SharedPreferences` to dynamically load and persist the Favorites active state across app restarts.
- **S3 (Stretch): Simple shimmer loading on Home while offers load**
  - Crafted a high-fidelity, native `ShimmerSkeleton` card placeholder widget in `HomeScreen` mimicking the real card layout.
  - Leveraged Flutter's built-in `AnimationController` and `FadeTransition` to create a smooth, zero-dependency pulsing loading effect.
  - Replaced the generic `CircularProgressIndicator` with a list of ShimmerSkeletons during data loading to provide a premium loading experience.

## Bugs fixed

- **B1: CO₂ badge always shows 0 on details screen:**
  - _Cause:_ The `OfferModel.fromJson` was mapping `co2Kg` using the key `'co2_saved_kg'`, which doesn't exist in the mock JSON file.
  - _Fix:_ Corrected the JSON key mapping in `OfferModel.fromJson` from `'co2_saved_kg'` to `'co2_kg'` to align with the mock API data.
- **B2: Favorite icon does not update instantly:**
  - _Cause:_ The `HomeScreenController.toggleFavorite` method was successfully persisting the favorite status via the repository, but failed to update the local `OfferModel` within the reactive list `_offers` in memory. This left the UI in the old state since GetX didn't detect any list modification.
  - _Fix:_ Added logic to find the modified offer by ID inside `_offers` and update its `isFavorite` boolean dynamically, which triggers GetX's reactive UI updates immediately.
- **B3: Cart Total uses original prices:**
  - _Cause:_ The `CartService.cartTotal` getter was multiplying `item.offer.originalPrice` by `item.quantity` to compute the total, adding the full original price instead of the discounted price.
  - _Fix:_ Changed `originalPrice` to `discountedPrice` inside the `.fold()` calculation in `CartService.cartTotal` so that the rescue discount price is applied properly.

## AI tools used

- **Antigravity (AI Coding Assistant)**: Collaborated via interactive pair-programming to analyze, build, and debug:
  - _Context Retrieval:_ Directed the AI to systematically scan `CHALLENGE.md`, `HomeScreenController`, `OfferModel`, and `CartService` first to align with GetX structure and project conventions.
  - _Precise Prompting:_ Utilized precise, targeted prompts to enforce strict state management boundaries (GetX reactivity, declarative `visibleOffers` filtering, zero-dependency custom shimmer loader) to fulfill requirements cleanly without breaking project patterns.
  - _Validation & Refinement:_ Reviewed and manually tested key application flows to ensure features worked correctly, UI updated properly, and application behavior remained stable.

## If I had more time

- **Profile Screen Enhancements (Gamification & Social):**
  - Implement a dynamic badge/achievement system on the Profile tab to reward users with green medals for reaching environmental milestones (e.g., "Eco Guardian" for saving 5kg of CO₂).
  - Add a "Share My Impact" feature that dynamically generates a beautiful graphic card displaying the user's rescued meals and CO₂ savings, optimized for sharing directly to Instagram or Facebook Stories.
  - Implement offline local caching of profile statistics using SharedPreferences or SQLite so that the user's green impact dashboard loads instantly even in offline states.
