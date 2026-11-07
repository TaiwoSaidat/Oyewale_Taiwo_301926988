-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. player pk duplicate. Expected: pk_player, SQLSTATE 23505.
INSERT INTO portfolio."player" ("player_id", "handle", "display_name", "created_at")
VALUES (101, 'fresh_handle', 'Fresh Player', '2026-03-01T10:00:00Z');

-- 2. player handle duplicate. Expected: uq_player_0, SQLSTATE 23505.
INSERT INTO portfolio."player" ("player_id", "handle", "display_name", "created_at")
VALUES (1001, 'player_one', 'Another Player', '2026-03-01T10:00:00Z');

-- 3. game pk duplicate. Expected: pk_game, SQLSTATE 23505.
INSERT INTO portfolio."game" ("game_id", "title", "mode", "active")
VALUES (201, 'Another Game', 'arcade', TRUE);

-- 4. score pk duplicate. Expected: pk_score_entry, SQLSTATE 23505.
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key")
VALUES (301, 101, 201, 841, '2026-03-01T10:00:00Z', 'S2026', 'fresh-submit-pk');

-- 5. score submission duplicate. Expected: uq_score_entry_0, SQLSTATE 23505.
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key")
VALUES (1002, 101, 201, 841, '2026-03-01T10:00:00Z', 'S2026', 'submit-301');

-- 6. score player fk invalid. Expected: fk_score_entry_0, SQLSTATE 23503.
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key")
VALUES (1003, 9001, 201, 841, '2026-03-01T10:00:00Z', 'S2026', 'fresh-submit-player-fk');

-- 7. score game fk invalid. Expected: fk_score_entry_1, SQLSTATE 23503.
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key")
VALUES (1004, 101, 9002, 841, '2026-03-01T10:00:00Z', 'S2026', 'fresh-submit-game-fk');

-- 8. score negative value. Expected: score_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."score_entry" ("entry_id", "player_id", "game_id", "score", "achieved_at", "season_code", "submission_key")
VALUES (1005, 101, 201, -1, '2026-03-01T10:00:00Z', 'S2026', 'fresh-submit-check');

-- 9. player handle not null. Expected: handle, SQLSTATE 23502.
INSERT INTO portfolio."player" ("player_id", "handle", "display_name", "created_at")
VALUES (1006, NULL, 'Null Handle Test', '2026-03-01T10:00:00Z');
