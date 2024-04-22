-- Granularity

-- Broad Idea: Level of detail that determines an individual row in a table or a view.

-- Fine Grain: High Level of Detail, like one row per transaction
-- Coarse Grain: Low Level of Detail, like count of all transactions in a given day

-- Granularity is usually expressed as the number of unique rows for
-- each column OR combination of columns

-------------------------------------------

-- users table has one row per user; fine grain

-- post_history table contains a log of all changes a user performs on a post on a given date and time
-- granularity of post_history is one row per user per post per timestamp

-- comments table also contains a log of all the comments on a post by a user on a given date
-- granularity is therefore one row per user per post per date

-- votes table contains a log of all upvotes and downvotes on a post on a given date
-- upvotes and downvotes are separated by row
-- granularity therefore is one row per post per vote type per date

-- taking a look at the post_history table's granularity:

SELECT creation_date
     , post_id
     , post_history_type AS type_id
     , user_id
     , COUNT(*) AS total
FROM bigquery-public-data.stackoverflow.post_history
GROUP BY 1, 2, 3, 4
HAVING COUNT(*) > 1;


-- Granularity Manipulation - AGGREGATION

-- reducing level of detail by grouping
-- grain becomes more coarse post-aggregation

SELECT ph.post_id
     , ph.user_id
     , ph.creation_date AS activity_date
     , CASE WHEN ph.post_history_type_id IN (1,2,3) THEN 'created'
            WHEN ph.post_history_type_id IN (4,5,6,) THEN 'edited'
        END AS activity_type
FROM bigquery-public-data.stackoverflow.post_history ph
WHERE
    TRUE
    AND ph.post_history_type_id BETWEEN 1 AND 6
    AND ph.user_id > 0                              -- excluding automated processes
    AND ph.user_id IS NOT NULL                      -- excluding deleted accounts
    AND ph.creation_date >= '2021-06-01'
    AND ph.creation_date <= '2021-09-30'
    AND ph.post_id = 69301792
GROUP BY 
    1, 2, 3, 4;
