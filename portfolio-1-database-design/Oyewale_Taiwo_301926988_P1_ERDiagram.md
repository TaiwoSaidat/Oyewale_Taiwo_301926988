# Real-time Game Leaderboard — ER diagram

```mermaid
erDiagram
    direction LR
    player {
        bigint player_id PK
        text handle UK
        text display_name
        timestamptz created_at
    }
    game {
        bigint game_id PK
        text title
        text mode
        boolean active
    }
    score_entry {
        bigint entry_id PK
        bigint player_id FK
        bigint game_id FK
        bigint score
        timestamptz achieved_at
        text season_code
        text submission_key UK
    }
    player ||--o{ score_entry : "player_id"
    game ||--o{ score_entry : "game_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Oyewale_Taiwo_301926988_ERDiagram.png)
