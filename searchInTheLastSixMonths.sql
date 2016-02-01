-- +------------------------------------------------------
-- + Search the products table for items created in the last 6 months
-- + Author: Simon Rogers
-- + Date: 1st February 2016
-- + SQL: mysql
-- +------------------------------------------------------

-- +------------------------------------------------------
-- + This query will do current date at time minus six months 
-- + e.g. (01/01/2016 10:00:00)
-- +------------------------------------------------------
SELECT * 
FROM `products`
WHERE created_at >= date_add(NOW(), INTERVAL -6 MONTH);

-- +------------------------------------------------------
-- + This query will do current date minus six months 
-- + e.g. (01/01/2016 00:00:00)
-- +------------------------------------------------------
SELECT * 
FROM `products`
WHERE created_at >= date_add(CURDATE(), INTERVAL -6 MONTH); 

-- +------------------------------------------------------
-- + Useful information 
-- + Here is a list of main interval values;
-- + MICROSECONDS, SECONDS, MINUTES, HOURS, DAYS, WEEKS, 
-- + MONTHS, QUARTERS, YEARS
-- + You can find full information at
-- + https://dev.mysql.com/doc/refman/5.5/en/date-and-time-functions.html#function_date-add
-- +------------------------------------------------------
