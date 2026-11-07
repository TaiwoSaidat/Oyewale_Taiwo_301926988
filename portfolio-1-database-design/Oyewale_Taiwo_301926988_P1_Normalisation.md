# Real-time Game Leaderboard — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| player_id | score_entry records (list) |
| --- | --- |
| 101 | [301] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| score_entry.entry_id | score_entry.player_id | score_entry.game_id | score_entry.season_code | player.player_id | player.handle | game.game_id | game.title |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | S2026 | 101 | player_one | 201 | Sky Rally |

Key: entry_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## score_entry_example

| score_entry.entry_id | score_entry.player_id | score_entry.game_id | score_entry.season_code | player.player_id | player.handle | game.game_id | game.title |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | S2026 | 101 | player_one | 201 | Sky Rally |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## player

| player_id | handle | display_name | created_at |
| --- | --- | --- | --- |
| 101 | player_one | Player One | 2026-01-15T12:00:00+00:00 |

## game

| game_id | title | mode | active |
| --- | --- | --- | --- |
| 201 | Sky Rally | time_trial | true |

## score_entry

| entry_id | player_id | game_id | score | achieved_at | season_code | submission_key |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 840 | 2026-02-01T14:30:00+00:00 | S2026 | submit-301 |

## Dependencies

- player: (player_id) → handle, display_name, created_at
- game: (game_id) → title, mode, active
- score_entry: (entry_id) → player_id, game_id, score, achieved_at, season_code, submission_key

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
