WITH ranked_events AS (
  SELECT 
    *, 
    ROW_NUMBER() OVER (
      PARTITION BY user_pseudo_id, event_name
      ORDER BY event_timestamp ASC 
    ) AS rn /*assigning a row number to events according to the earliest timestamp*/
  FROM `turing_data_analytics.raw_events`
  )

SELECT *
FROM ranked_events
WHERE rn = 1; /*filtering the row number to 1 to take only the first event occurrence*/