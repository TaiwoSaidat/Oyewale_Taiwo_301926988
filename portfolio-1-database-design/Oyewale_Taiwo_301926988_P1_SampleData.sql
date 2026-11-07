-- Fictional sample records for Real-time Game Leaderboard.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."player" ("player_id", "handle", "display_name", "created_at") VALUES (101, 'player_one', 'Player One', '2026-01-15T12:00:00Z');
INSERT INTO portfolio."game" ("game_id", "title", "mode", "active") VALUES (201, 'Sky Rally', 'time_trial', TRUE);
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key") VALUES (301, 101, 201, 840, '2026-02-01T14:30:00Z', 'S2026', 'submit-301');
COMMIT;
