# Real-time Game Leaderboard — SQL queries

## 1. Show related score_entry, player, game records (up to 20).

```sql
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
```

| score_entry_entry_id | score_entry_score | player_player_id | player_handle | game_game_id | game_title |
| --- | --- | --- | --- | --- | --- |
| 301 | 840 | 101 | player_one | 201 | Sky Rally |

## 2. Find score_entry records where achieved_at matches "2026-02-01T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."score_entry"
WHERE "achieved_at" IS NOT DISTINCT FROM '2026-02-01T14:30:00Z'
ORDER BY "entry_id"
LIMIT 20;
```

| entry_id | player_id | game_id | score | achieved_at | season_code | submission_key |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 101 | 201 | 840 | 2026-02-01T14:30:00+00:00 | S2026 | submit-301 |

## 3. Count score_entry records for each player_id (up to 20 groups).

```sql
SELECT "player_id", count(*) AS record_count
FROM portfolio."score_entry"
GROUP BY "player_id"
ORDER BY record_count DESC, "player_id" NULLS LAST
LIMIT 20;
```

| player_id | record_count |
| --- | --- |
| 101 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.522 | 1.262, 0.517, 0.522 | Sort → Seq Scan | 58 |
| After index | 0.14 | 0.164, 0.14, 0.138 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 15 |

The median execution time changed from 0.522 ms to 0.14 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.18..1.181 rows=10 loops=1)
  Seq Scan on score_entry (actual time=0.024..1.127 rows=10 loops=1)
Planning Time: 0.597 ms
Execution Time: 1.262 ms
```

### Before index, run 2

```text
Sort (actual time=0.493..0.494 rows=10 loops=1)
  Seq Scan on score_entry (actual time=0.014..0.462 rows=10 loops=1)
Planning Time: 0.315 ms
Execution Time: 0.517 ms
```

### Before index, run 3

```text
Sort (actual time=0.499..0.5 rows=10 loops=1)
  Seq Scan on score_entry (actual time=0.013..0.468 rows=10 loops=1)
Planning Time: 0.335 ms
Execution Time: 0.522 ms
```

### After index, run 1

```text
Sort (actual time=0.111..0.112 rows=10 loops=1)
  Bitmap Heap Scan on score_entry (actual time=0.024..0.077 rows=10 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=10 loops=1)
Planning Time: 0.529 ms
Execution Time: 0.164 ms
```

### After index, run 2

```text
Sort (actual time=0.085..0.086 rows=10 loops=1)
  Bitmap Heap Scan on score_entry (actual time=0.024..0.053 rows=10 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=10 loops=1)
Planning Time: 0.546 ms
Execution Time: 0.14 ms
```

### After index, run 3

```text
Sort (actual time=0.087..0.088 rows=10 loops=1)
  Bitmap Heap Scan on score_entry (actual time=0.024..0.054 rows=10 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=10 loops=1)
Planning Time: 0.544 ms
Execution Time: 0.138 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Oyewale_Taiwo_301926988_P2_Queries.sql, then Oyewale_Taiwo_301926988_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Oyewale_Taiwo_301926988_P2_QueryResults.png) · [Index comparison](screenshots/Oyewale_Taiwo_301926988_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

