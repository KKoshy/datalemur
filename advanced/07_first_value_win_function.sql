WITH card_launch AS (
  SELECT card_name,
         issued_amount,
         MAKE_DATE(issue_year, issue_month, 1) AS present_date,
         FIRST_VALUE(MAKE_DATE(issue_year, issue_month, 1)) OVER (
          PARTITION BY card_name
          ORDER BY issue_year, issue_month
          
          ) AS issue_date
  FROM monthly_cards_issued
)

SELECT card_name,
       issued_amount
FROM card_launch
WHERE present_date=issue_date
ORDER BY issued_amount DESC;
