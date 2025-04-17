WITH ranked_events AS (
  SELECT 
    *, 
    ROW_NUMBER() OVER (
      PARTITION BY user_pseudo_id, event_name
      ORDER BY event_timestamp ASC 
    ) AS rn /*assigning a row number to events according to the earliest timestamp*/
  FROM `turing_data_analytics.raw_events`
  ), 
    event_counts AS (
  SELECT 
    category, /*including category*/
    event_name, 
    COUNT(*) AS event_count
  FROM ranked_events
  WHERE rn = 1 /*filtering the row number to 1 to take only the first event occurrence*/
  AND event_name IN ('session_start', 'view_item', 'add_to_cart', 'add_shipping_info', 'add_payment_info', 'purchase') /*filtering the chosen events*/
  GROUP BY category, event_name
  ), 
    percentages AS (
  SELECT 
    category, /*including category*/
    event_name, 
    event_count,
    100.0 * event_count / MAX(CASE WHEN event_name = 'session_start' THEN event_count END) OVER (PARTITION BY category) AS event_percentage /*using MAX for non 'session_start' rows not to get NULL values. Using PARTITION BY category to ensure calculations are seperated by category*/
  FROM event_counts
  ),
    final AS (
  SELECT 
    category, /*including category*/
    event_name,
    event_count, 
    LAG(event_count) OVER (PARTITION BY category ORDER BY event_percentage DESC) AS previous_event_count, /*using LAG function to get previous event count for later drop off percentage calculations. Using PARTITION BY category to ensure calculations are seperated by category*/
    ROUND(event_percentage, 2) AS event_percentage
  FROM percentages
  )

SELECT 
  category, /*including category*/
  event_name, 
  event_count, 
  previous_event_count,
  event_percentage,
  ROUND(100 * (1 - event_count / NULLIF(previous_event_count, 0)), 2) AS drop_off_percentage /*using NULLIF to prevent division by 0 and to make the function work in case of NULL values*/
FROM final
ORDER BY category, event_percentage DESC;