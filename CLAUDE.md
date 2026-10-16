# CoachApp: project rules

Architecture, layers and conventions are in `docs/architecture.md`. Follow them.

## Comments

Code should explain itself through clear names. Only write a comment when it says something the code can't:

- **Why** a decision was made, when a reader might otherwise "fix" it
  (e.g. "Uses its own Dio so a failing refresh can't trigger another refresh").
- **Non-obvious contracts or gotchas**: what `null` means, ordering requirements,
  concurrency behaviour, platform quirks.
- **`TODO(team): …`** for open questions, such as unconfirmed backend contracts.

Do not write comments that:

- restate the class, method, field or parameter name
  (`/// The signed-in user.`, `/// Card titles.`, `// Bottom tabs`);
- describe what the next line obviously does;
- narrate test steps that the test name and assertions already make clear;
- contain usage examples for simple APIs.

Keep every comment short: one or two lines. If a comment needs a paragraph, the code probably needs a better name or structure. When you change code, update or delete any comment next to it that no longer holds.

## Before committing

`dart format .` · `flutter analyze` (must be clean) · `flutter test` (must pass).
