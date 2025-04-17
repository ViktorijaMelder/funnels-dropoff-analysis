WITH ranked_events AS (
  SELECT 
    *, 
    ROW_NUMBER() OVER (
      PARTITION BY user_pseudo_id, event_name
      ORDER BY event_timestamp ASC 
    ) AS rn /*assigning a row number to events according to the earliest timestamp*/
  FROM `turing_data_analytics.raw_events`
  ),
    top_countries AS (
  SELECT 
    country
  FROM `turing_data_analytics.raw_events`
  GROUP BY country
  ORDER BY COUNT(*) DESC
  LIMIT 3
  ), /*filtering the top 3 countries according to their overall number of events*/
    event_counts AS (
  SELECT 
    country, 
    event_name, 
    COUNT(*) AS event_count
  FROM ranked_events
  WHERE rn = 1 /*filtering the row number to 1 to take only the first event occurrence*/
  AND country IN (SELECT country FROM top_countries) /*selecting the top 3 countries*/
  AND event_name IN ('session_start', 'view_item', 'add_to_cart', 'add_shipping_info', 'add_payment_info', 'purchase') /*filtering the chosen events*/
  GROUP BY country, event_name
  ),
    base_counts AS (
  SELECT 
    country, 
    event_count AS session_start_count
  FROM event_counts
  WHERE event_name = 'session_start'
  ), /*creating the starting event count to be later used in calculating the percentage*/
    final_data AS (
  SELECT 
    e.country,
    e.event_name,
    e.event_count,
    ROUND((e.event_count * 100.0) / b.session_start_count, 2) AS percentage, /*calculating the percentage*/
    LAG(e.event_count) OVER (PARTITION BY e.country ORDER BY /*using LAG function to get the previous_event_counts for later drop_off percentage calculations*/
      CASE e.event_name /*assigning the events order to be used in LAG function*/
        WHEN 'session_start' THEN 1
        WHEN 'view_item' THEN 2
        WHEN 'add_to_cart' THEN 3
        WHEN 'add_shipping_info' THEN 4
        WHEN 'add_payment_info' THEN 5
        WHEN 'purchase' THEN 6
      END
      ) AS previous_event_count 
  FROM event_counts e
  JOIN base_counts b 
  ON e.country = b.country
  )

SELECT 
  country,
  event_name,
  event_count,
  percentage,
  previous_event_count,
  ROUND(100.0 - ((event_count * 100.0) / NULLIF(previous_event_count, 0)), 2) AS drop_off_percentage /*using NULLIF to prevent division by 0 and to make the function work in case of NULL values*/
FROM final_data
ORDER BY country DESC;