-- INFORMATION_SCHEMA Views in BigQuery

-- Filtering out tables in the available information schema
-- that are related to the various post types

SELECT table_name
FROM bigquery-public-data.stackoverflow.INFORMATION_SCHEMA.TABLES
WHERE table_name LIKE 'posts_%';

-- Reading the schema of a given table

SELECT column_name, data_type
FROM bigquery-public-data.stackoverflow.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'posts_answers';

-- Seems like there's a one-to-many relationship between
-- post types and post_history

SELECT column_name, data_type
FROM bigquery-public-data.stackoverflow.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'post_history'



