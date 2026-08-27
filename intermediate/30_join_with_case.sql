SELECT CASE 
        WHEN advertiser.user_id IS NOT NULL THEN advertiser.user_id
        ELSE daily_pay.user_id
       END AS user_id,
      -- paid,
      -- status AS current_status,
       CASE
        WHEN status='NEW' AND paid IS NOT NULL THEN 'EXISTING'
        WHEN status='EXISTING' AND paid IS NOT NULL THEN 'EXISTING'
        WHEN status='CHURN' AND paid IS NOT NULL THEN 'RESURRECT'
        WHEN status='RESURRECT' AND paid IS NOT NULL THEN 'EXISTING'
        WHEN paid IS NULL THEN 'CHURN'
        ELSE 'NEW'
       END AS new_status
FROM advertiser 
FULL JOIN daily_pay
ON advertiser.user_id = daily_pay.user_id
ORDER BY 1;
