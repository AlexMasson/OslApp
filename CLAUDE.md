# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Internal Flutter app for the Orchestre Symphonique de Lyon (OSL). Shows musicians their upcoming
rehearsals, concerts, and the works being played (scores + audio excerpts). Deployed as a **web PWA**
to Azure Static Web Apps; the mobile/desktop platform folders exist but are not the deployment target.

All user-facing strings and domain vocabulary are **French** (`repetitions`, `concerts`, `programme`,
`horaire`, `lieu`, `commentaire`). Keep new UI text in French and match existing wording.

## Commands

```bash
flutter pub get                      # install deps
flutter run -d chrome                # run locally (web is the real target)
flutter analyze                      # lint (flutter_lints ruleset)
flutter test                         # all tests
flutter test test/widget_test.dart   # single test file
flutter test --plain-name "some test name"   # single test by name

# what CI actually builds:
flutter build web --web-renderer canvaskit --target=lib/main.dart --release
```

### `.env` is required to run

`main()` calls `dotenv.load(fileName: ".env")` before `runApp`, and `.env` is declared as a Flutter
asset in `pubspec.yaml`. It is gitignored, so a fresh clone **will not start** until you create one at
the repo root with these keys (values come from the GitHub environment vars in the workflows):

```
REPETITIONS_CSV_URL=
CONCERTS_CSV_URL=
PROGRAMME_CSV_URL=
LIENS_CSV_URL=
ENVIRONMENT=dev
```

`ENVIRONMENT=dev` appends " dev" to the app title. Each URL points to a Google Sheet CSV
(either a "publish to web" `.../pub?...&output=csv` URL or a direct
`.../export?format=csv&gid=<gid>` URL — both support CORS). The URL must already contain a `?`,
because the repository appends `&version=<timestamp>` as a cache-buster.

### Deployment

`.github/workflows/dev.yml` (push to `dev`) and `prod.yml` (push to `main`) are identical except for
the environment and the `web/manifest.json` name they patch in. Both generate `.env` from GitHub
environment variables, build web with canvaskit, and upload to Azure Static Web Apps.
Work happens on `dev`; `main` is production.

## Architecture

**The backend is a set of published Google Sheets exported as CSV.** There is no API, no database, no
auth, and no local persistence. `lib/repository/google_sheet_repository.dart` is the entire data layer:
four top-level functions (`fetchRepetitionsAsync`, `fetchConcertsAsync`, `fetchProgrammeAsync`,
`fetchLiensAsync`) that HTTP-GET a CSV URL, parse it, and return a `List<Model>`.

The sheets live in a shared Google Drive folder ("AppOslyon"), one spreadsheet per entity, with dev
copies under its `_dev` subfolder. The `Liens` tab of the "Options" spreadsheet drives the external
links on the home page (`IndexPage`): headers `Nom | Url`, one row per link, sheet row order = display
order, deleting a row removes the link. Do NOT reintroduce hardcoded link URLs or a build-time
TROMBI_URL — links are runtime data precisely so non-technical maintainers can edit them.

Conventions that matter when touching the repository:

- **Columns are resolved by header name, not index.** Each fetch builds a `HashMap<String, int>` from
  row 0, then looks up cells via `fieldsMap[Model.xxxCsvField]`. The `xxxCsvField` string constants on
  the model classes (`lib/model/*.dart`) are the contract with the spreadsheet — changing one silently
  breaks parsing for that column.
- **Per-row try/catch.** A malformed row is logged via `dart:developer` and skipped; the rest still
  load. Preserve this — the sheets are human-edited and rows are routinely half-filled.
- **Multi-value columns are flattened, fixed-arity slots**: `Programme_1`..`Programme_10` on
  Repetition/Concert, `Lien_Extrait_1..3` on Programme, collected into a `List<String>` with empties
  dropped. Adding an 11th slot means editing both the model constants and the repository's
  `addProgrammeIfNotEmpty` calls.
- **Cache-busting**: every URL gets `&version=${DateTime.now().toIso8601String()}` appended, otherwise
  Google serves a stale CSV.
- Dates are parsed as `dd-MM-yyyy` and formatted for display with the `fr_FR` locale
  (`initializeDateFormatting('fr_FR')` in `main()`). Rehearsals and concerts in the past are filtered
  out and the list is sorted date-ascending in the repository, not in the UI.

**`IndexPage` (home) follows the same fetch idiom** as the list components: stateful, fetch in
`didChangeDependencies` under `EasyLoading`, pull-to-refresh, `mounted` guard. Empty state text:
"Aucun lien pour le moment."

**Navigation is manual, not routed.** `MyHomePage` in `lib/main.dart` holds a `const List<Widget> _pages`
indexed in lockstep with `lib/nav_bar_items.dart`; `BottomNavigationBarComponent` reports the tapped
index up and the parent swaps `body` and the AppBar `title` via `setState`. Adding a tab means adding
entries to **both** lists at the same index. Only the detail views use `Navigator.push`.

**Feature folders follow a page → list → detail triad** (`lib/concerts/`, `lib/repetitions/`,
`lib/programe/` — note the single-`m` typo in that folder name, it is load-bearing for imports). The
`*_page.dart` is a thin StatefulWidget wrapper; the `*_list_component.dart` does the real work: fetches
in `didChangeDependencies` wrapped in `EasyLoading.show()`/`dismiss()`, guards `setState` with
`mounted`, and wraps the `ListView.separated` in a `RefreshIndicator` that re-fetches on pull.

**State management is plain `setState`.** No provider/riverpod/bloc, no DI — the repository functions
are imported and called directly. Don't introduce a state library for a small change.

**Responsive layout** goes through `ResponsiveTools` (`lib/tools/reponsive_tools.dart`, also a typo'd
filename): either as a widget taking `smallScreen`/`bigScreen`, or via the static
`isSmallScreen`/`isBigScreen` predicates. Breakpoint is 650px.

**Theming**: Material 3 with a seed color, and `themeMode` is pinned to `ThemeMode.light` — `darkTheme`
is deliberately defined with `Brightness.light` so the app looks the same regardless of OS setting.

## Testing

`test/widget_test.dart` is still the unmodified Flutter counter-app boilerplate and does not reflect
this app — it will fail if run. Replace it rather than building on it. Note that any widget test
touching `MyApp` needs `dotenv` loaded first, since `main()` is where that normally happens.
