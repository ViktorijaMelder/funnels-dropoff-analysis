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
  ) /*filtering the top 3 countries according to their overall number of events*/

SELECT 
    country, 
    event_name, 
    COUNT(*) AS event_count
FROM ranked_events
WHERE rn = 1 /*filtering the row number to 1 to take only the first event occurrence*/
AND country IN (SELECT country FROM top_countries) /*selecting the top 3 countries*/
AND event_name IN ('session_start', 'view_item', 'add_to_cart', 'add_shipping_info', 'add_payment_info', 'purchase') /*filtering the chosen events*/
GROUP BY country, event_name
ORDER BY country, event_count DESC;