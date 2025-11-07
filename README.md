# Sandwich Shop Flutter App

A small Flutter demo app that simulates ordering sandwiches. It's a teaching/example project showing simple state management, basic widgets, and widget + unit tests.

## What this app does

- Presents a simple sandwich counter UI where a user can:
  - Toggle between six-inch and footlong sandwiches.
  - Select a bread type (white, wheat, wholemeal) via a dropdown.
  - Add a short order note via a `TextField`.
  - Increment and decrement the quantity of sandwiches with Add / Remove buttons (bounded by min 0 and a configurable max).
- The `OrderItemDisplay` summarizes the current order (quantity, bread, type) and displays a sandwich emoji per item.

## Project structure (important files)

- `lib/main.dart` — main application entry. Contains the following key pieces:
  - `App` — top-level `MaterialApp` that uses `OrderScreen` as `home`.
  - `OrderScreen` — `StatefulWidget` that composes the UI and holds state such as selected bread, sandwich type, notes, and an `OrderRepository` instance for quantity logic.
  - `StyledButton` — a small `StatelessWidget` wrapper around `ElevatedButton` used for the Add/Remove buttons.
  - `OrderItemDisplay` — `StatelessWidget` that renders the order summary and the note.

- `lib/views/app_styles.dart` — central place for shared `TextStyle` constants used across widgets:
  - `normalText` and `heading1` style constants.

- `lib/repositories/order_repository.dart` — simple stateful repository encapsulating quantity logic:
  - `OrderRepository` holds `_quantity` and `maxQuantity`.
  - Provides `increment()`, `decrement()`, and boolean getters `canIncrement`, `canDecrement`, and `quantity`.

- `test/widget_test.dart` — widget tests that pump the whole `App` and assert UI behaviors (title, initial quantity, Add/Remove behavior, dropdown bread selection, text field updates, and `OrderItemDisplay` widget rendering).

- `test/repositories/order_repository_test.dart` — unit tests for the repository logic (initial quantity, increment/decrement bounds).

## Important implementation notes

- Each Dart file imports the packages it uses directly. For example, `lib/views/app_styles.dart` imports `package:flutter/material.dart` so the style constants can reference Flutter types. `lib/main.dart` also imports `package:flutter/material.dart` because it directly uses `MaterialApp`, `Scaffold`, and other Material widgets.

- `BreadType` is an `enum` with values `white`, `wheat`, and `wholemeal`. The app uses `breadType.name` (lowercase) when rendering text. Tests are written to match this lowercase output.

## How to run the app (development)

Prerequisites:

- Flutter SDK installed (stable channel recommended)
- Platform toolchains set up for your target (Android/iOS/web/desktop)

From the project root (`sandwich_shop/`):

```bash
# fetch dependencies
flutter pub get

# run on the default connected device / emulator
flutter run
```

To run on a specific device (e.g., Windows, chrome, a specific android emulator) use `flutter devices` to list devices and `flutter run -d <deviceId>`.

## Running tests

Run the full test suite (both widget and unit tests):

```bash
flutter test
```

Notes on the tests included:

- `test/repositories/order_repository_test.dart` validates the `OrderRepository` logic (bounds and basic operations).
- `test/widget_test.dart` contains widget tests that pump the `App` and verify UI strings and interactions. The tests assume the app shows text like `0 white footlong sandwich(es): ` by default (bread uses the enum name and the sandwich type is `footlong` by default).

If you change the string formatting in `OrderItemDisplay` (for example, capitalizing bread type or changing the suffix text), update the tests accordingly.

## Contract / Inputs & Outputs

- Input: user interactions (toggle switch, dropdown selection, text entry, Add/Remove button taps).
- Output: UI updates showing quantity, repeated sandwich emoji for each item, and the note text.
- Error modes: none complex — attempts to decrement below 0 or increment above `maxQuantity` are ignored.

## Edge cases handled

- Trying to decrement when quantity is 0 does nothing.
- Trying to increment when quantity equals `maxQuantity` does nothing.
- Empty notes show a default text `No notes added.` in the UI.

## Extension ideas / next steps

- Persist orders locally (e.g., with Hive or SharedPreferences) so the quantity and notes survive app restarts.
- Add input validation / longer notes UI.
- Improve dropdown accessibility and visual styling.
- Add more tests that simulate platform-specific behavior or accessibility checks.

## How I verified this README

- I inspected the key files in `lib/` and `test/` to describe the behavior and list the files. The `OrderRepository` and tests confirm expected behavior around quantity bounds. The widget tests show the text format used by `OrderItemDisplay`.

## Contact / attribution

This README was generated to match the current project layout in this repository. Update the sections above if you refactor file names, change UI strings, or add new features.

---

Happy hacking! 🍞🥪
