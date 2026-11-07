-- Show related score_entry, player, game records (up to 20).
SELECT t0."entry_id" AS "score_entry_entry_id",
       t0."score" AS "score_entry_score",
       t1."player_id" AS "player_player_id",
       t1."handle" AS "player_handle",
       t2."game_id" AS "game_game_id",
       t2."title" AS "game_title"
FROM portfolio."score_entry" t0
JOIN portfolio."player" t1 ON t0."player_id" = t1."player_id"
JOIN portfolio."game" t2 ON t0."game_id" = t2."game_id"
ORDER BY t0."entry_id", t1."player_id", t2."game_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."entry_id" AS "score_entry_entry_id",
       t0."score" AS "score_entry_score",
       t1."player_id" AS "player_player_id",
       t1."handle" AS "player_handle",
       t2."game_id" AS "game_game_id",
       t2."title" AS "game_title"
FROM portfolio."score_entry" t0
JOIN portfolio."player" t1 ON t0."player_id" = t1."player_id"
JOIN portfolio."game" t2 ON t0."game_id" = t2."game_id"
ORDER BY t0."entry_id", t1."player_id", t2."game_id"
LIMIT 20;

-- Find score_entry records where achieved_at matches "2026-02-01T14:30:00Z" (up to 20).
SELECT * FROM portfolio."score_entry"
WHERE "achieved_at" IS NOT DISTINCT FROM '2026-02-01T14:30:00Z'
ORDER BY "entry_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."score_entry"
WHERE "achieved_at" IS NOT DISTINCT FROM '2026-02-01T14:30:00Z'
ORDER BY "entry_id"
LIMIT 20;

-- Count score_entry records for each player_id (up to 20 groups).
SELECT "player_id", count(*) AS record_count
FROM portfolio."score_entry"
GROUP BY "player_id"
ORDER BY record_count DESC, "player_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "player_id", count(*) AS record_count
FROM portfolio."score_entry"
GROUP BY "player_id"
ORDER BY record_count DESC, "player_id" NULLS LAST
LIMIT 20;
