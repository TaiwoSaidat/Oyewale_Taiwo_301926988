# Real-time Game Leaderboard — database design

My case study records player, game, score_entry.

## Users

- Players submitting scores
- Viewers checking leaderboard rankings
- Operators reviewing score submissions

## Main operations

- Register players and games
- Record score submissions
- Filter and rank scores by game and season

## Entities

| Entity | Information stored |
| --- | --- |
| player | Stores leaderboard participants. |
| game | Stores games that have leaderboards. |
| score_entry | Records a player's score submission for a game and season. |

## player

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| player_id | BIGINT | PK | Yes |
| handle | TEXT | Unique | Yes |
| display_name | TEXT |  | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (handle).

## game

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| game_id | BIGINT | PK | Yes |
| title | TEXT |  | Yes |
| mode | TEXT |  | Yes |
| active | BOOLEAN |  | Yes |


## score_entry

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| entry_id | BIGINT | PK | Yes |
| player_id | BIGINT | FK | Yes |
| game_id | BIGINT | FK | Yes |
| score | BIGINT |  | Yes |
| achieved_at | TIMESTAMPTZ |  | Yes |
| season_code | TEXT |  | Yes |
| submission_key | TEXT | Unique | Yes |
- player_id → player.player_id
- game_id → game.game_id
- Unique key: (submission_key).

## Relationships and business rules

- Each player handle identifies at most one player.
- A submitted score must be zero or greater.
- Every score entry references an existing player.
- Every score entry references an existing game.
- A submission key can be recorded only once, preventing duplicate retries.

## Assumptions

- Each entity has a single-column primary key, and all primary-key values come from one globally unique ID namespace.
- A score entry represents one submission; submission_key is a client-provided idempotency key, unique across entries.
- Scores are non-negative integers. Leaderboard queries select each player's highest score for a game and season, with ties ordered by achievement time.
- For the normalization example, score_entry is the root relation with foreign keys to player and game. Keep player and game attributes in their respective entities and store only their keys in score_entry, avoiding repeated player or game attributes.

