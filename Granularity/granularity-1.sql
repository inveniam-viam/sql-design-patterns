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
