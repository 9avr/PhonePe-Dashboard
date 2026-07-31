
CREATE TABLE phonepe_transactions (
    transaction_id  VARCHAR(50) PRIMARY KEY,
    amount          DECIMAL(12,2),
    user_id         VARCHAR(50),
    service         VARCHAR(50),
    service_type    VARCHAR(50),
    payment_status  VARCHAR(20),      -- 'Success' / 'Failed' / etc.
    reason          VARCHAR(100),     -- failure reason, if any
    txn_date        DATE,
    user_name       VARCHAR(100),
    age             INT,
    join_date       DATE
);


LOAD DATA LOCAL INFILE 'C:\Users\a\Downloads\phonepe_transactions_2024.csv'
INTO TABLE phonepe_transactions
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



-- 1. How many transactions were done in a year?
SELECT
    YEAR(txn_date) AS txn_year,
    COUNT(*) AS total_transactions
FROM phonepe_transactions
GROUP BY txn_year;



-- 2. Total value of the transactions
SELECT
    ROUND(SUM(amount), 2) AS total_transaction_value
FROM phonepe_transactions;



-- 3. How many unique users are using the platform?
SELECT
    COUNT(DISTINCT user_id) AS unique_users
FROM phonepe_transactions;


-- 4. Trends, growth/decline, or recurring patterns over months
SELECT
    DATE_FORMAT(txn_date, '%Y-%m') AS txn_month,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS transaction_value,
    ROUND(
        SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(txn_date, '%Y-%m')),
    2) AS mom_value_change
FROM phonepe_transactions
GROUP BY txn_month
ORDER BY txn_month;

-- 5. Age segment contribution
SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '50+'
    END AS age_segment,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS transaction_value,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM phonepe_transactions), 2) AS pct_of_total
FROM phonepe_transactions
GROUP BY age_segment
ORDER BY transaction_value DESC;

-- 6. Which service type accounts for maximum / minimum transactions?
SELECT
    service_type,
    COUNT(*) AS transaction_count
FROM phonepe_transactions
GROUP BY service_type
ORDER BY transaction_count DESC;
-- Top row = maximum, bottom row = minimum


-- 7. Which service type contributed maximum / minimum revenue?
SELECT
    service_type,
    ROUND(SUM(amount), 2) AS total_revenue
FROM phonepe_transactions
GROUP BY service_type
ORDER BY total_revenue DESC;
-- Top row = maximum, bottom row = minimum


-- 8. Top 5 users and the transactions they've done
-- identify top 5 users by total transaction value
WITH top_users AS (
    SELECT
        user_id,
        user_name,
        SUM(amount) AS total_spent,
        COUNT(*) AS total_transactions
    FROM phonepe_transactions
    GROUP BY user_id, user_name
    ORDER BY total_spent DESC
    LIMIT 5
)
SELECT * FROM top_users;

-- full transaction detail for those top 5 users
SELECT t.*
FROM phonepe_transactions t
JOIN (
    SELECT user_id
    FROM phonepe_transactions
    GROUP BY user_id
    ORDER BY SUM(amount) DESC
    LIMIT 5
) top5 ON t.user_id = top5.user_id
ORDER BY t.user_id, t.txn_date;


-- 9. Intensity of transactions over weekdays
SELECT
    DAYNAME(txn_date) AS weekday,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS transaction_value
FROM phonepe_transactions
GROUP BY weekday, DAYOFWEEK(txn_date)
ORDER BY DAYOFWEEK(txn_date);


-- 10. Success rate of transactions
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN payment_status = 'Success' THEN 1 ELSE 0 END) / COUNT(*),
    2) AS success_rate_pct
FROM phonepe_transactions;

-- Status of transaction
SELECT
    payment_status,
    COUNT(*) AS transaction_count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM phonepe_transactions), 2) AS pct_of_total
FROM phonepe_transactions
GROUP BY payment_status
ORDER BY transaction_count DESC;



-- Duplicate transaction IDs
SELECT transaction_id, COUNT(*) AS dup_count
FROM phonepe_transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- Missing/null values
SELECT COUNT(*) AS rows_with_missing_data
FROM phonepe_transactions
WHERE amount IS NULL OR user_id IS NULL OR txn_date IS NULL OR payment_status IS NULL;

-- Negative or zero-amount transactions 
SELECT *
FROM phonepe_transactions
WHERE amount <= 0;


