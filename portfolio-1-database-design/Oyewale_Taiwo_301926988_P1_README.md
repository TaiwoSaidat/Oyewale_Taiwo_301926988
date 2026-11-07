# Portfolio 1 — Database Design and Modelling

I organised the data into player, game, score_entry. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| player | 1 |
| game | 1 |
| score_entry | 1 |

The 9 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Oyewale_Taiwo_301926988_P1_Design.md)
- [ER diagram](Oyewale_Taiwo_301926988_P1_ERDiagram.md)
- [Normalisation](Oyewale_Taiwo_301926988_P1_Normalisation.md)
- [Schema](Oyewale_Taiwo_301926988_P1_Schema.sql)
- [Sample data](Oyewale_Taiwo_301926988_P1_SampleData.sql)
- [Constraint tests](Oyewale_Taiwo_301926988_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Oyewale_Taiwo_301926988_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

