## Purpose
Short, focused guidance for AI coding agents working on the MASQ-Team AL extension package.

Be concise. When changing code, keep modifications within the project's id range (70100-70180) and follow existing naming and permission patterns.

## Big picture
- This repo is a Dynamics 365 Business Central extension (AL) named "MASQ Team" defined in `app.json`.
- Key components live under `src/`: `codeunit/`, `table/`, `tableextension/`, `page/`, `pageextension/`, `enum/`, `enumextension/`, `report/`, and `query/`.
- Object id range is declared in `app.json` ("idRanges": 70100-70180). New objects should use ids in this range.
- The extension depends on other apps (see `app.json` -> `dependencies`), e.g., `MASQ`, `Apollo`, and Microsoft Excel Reports. Respect those dependencies when referencing symbols.

## Coding patterns and conventions (discoverable from code)
- Event-driven: The codebase heavily uses EventSubscriber attributes in `src/codeunit/*.al` (example: `Cod70101.MASQSubsFunctions.al`) to hook into platform events rather than modifying base objects directly. Prefer adding subscribers where possible.
- Naming: Objects use a numeric prefix in filenames and object names consistent with their id, e.g., `Cod70101.MASQSubsFunctions.al` → codeunit 70101. Use the same pattern for new files: three-letter type + id + short descriptive name.
- Fields and FlowFields: `tableextension` files add fields in the 70100+ range (see `src/tableextension/Tab-Ext70132.ProjectPlanningLinesexte.al`). Use `FieldClass = FlowField` and `CalcFormula` for computed data when following existing approaches.
- Permissions: Codeunits declare `Permissions` (see `Cod70101.MASQSubsFunctions.al`); follow existing permission patterns when adding codeunits that access tables.
- Data classification: Fields may include `DataClassification` attributes (e.g., ToBeClassified). Preserve or set appropriately.

## Build, test, and debug workflows
- Primary development flow uses VS Code AL extension with the workspace `launch.json` in `.vscode/`.
- Typical debug target: "Microsoft cloud sandbox" (see `.vscode/launch.json`) — use VS Code "Run and Debug" with that configuration to deploy to a sandbox and debug.
- Schema updates are often set to `ForceSync` in the launch configuration. Be cautious: this will alter the target DB schema.
- No unit test harness was found in the workspace. Prefer manual validation via the sandbox and sample data.

## Integration points and dependencies
- External dependencies are declared in `app.json` (IDs and publisher names). When referencing tables/fields from dependencies, ensure the symbol names match and that the dependency version supports them.
- The project contains a number of .app files and .rdl reports in the root—these are packaged artifacts and report layouts. Do not edit compiled `.app` files in this repo; work in `src/`.

## Quick examples (copyable patterns)
- Event subscriber in codeunit (pattern found in `src/codeunit/Cod70101.MASQSubsFunctions.al`):

- Tableextension field addition (from `src/tableextension/Tab-Ext70132.ProjectPlanningLinesexte.al`): add fields in id range and reuse Project/Job fields when creating FlowFields with `CalcFormula`.

## What to avoid
- Do not add objects with ids outside the declared idRanges in `app.json`.
- Do not modify compiled `.app` files in the repo root. They are packaged releases.

## Files to inspect when making changes
- `app.json` — idRanges, dependencies, runtime and application versions.
- `.vscode/launch.json` — debug/deploy targets and schemaUpdateMode.
- `src/codeunit/Cod70101.MASQSubsFunctions.al` — canonical style for event subscribers and permissions block.
- `src/tableextension/Tab-Ext70132.ProjectPlanningLinesexte.al` — example of field additions, FlowFields, and triggers.

## If you modify behavior
- Prefer adding EventSubscribers or local procedures. Avoid changing base objects.
- If a new permission is required, add it to the appropriate codeunit's `Permissions` section.

## When in doubt
- Look for existing objects in `src/` with the same prefix (701xx) to follow naming and id assignment.
- If a change touches external dependencies, verify the referenced object exists in `app.json` dependencies and matches the expected version.

---
If any section is unclear or you want more specifics (tests, CI, or example change), tell me which area to expand and I'll iterate.
