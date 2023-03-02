-- Cleaning customer_orders table
-- Turning Rows with ‘null’ in both columns (exclusion and extras) to NULL

use pizza_runner;
UPDATE customer_orders
SET exclusions = NULL
WHERE exclusions ='null' or exclusions ='';

UPDATE customer_orders
SET extras = NULL
WHERE extras ='null' or extras ='NaN' or extras ='';

Select * from customer_orders;

-- Changing datatype of order_time column from customer_orders table to datetime
ALTER TABLE customer_orders
MODIFY COLUMN order_time DATETIME;

-- Cleaning runner_orders’ table
-- Changing ‘null’ texts in the pickup_time column to NULL

UPDATE runner_orders
SET pickup_time = NULL
WHERE pickup_time ='null';

-- Changing ‘null’ texts in the duration column to NULL
UPDATE runner_orders
SET distance = NULL
WHERE distance ='null';

-- Changing ‘null’ texts in the distance column to NULL
UPDATE runner_orders
SET duration = NULL
WHERE duration ='null';

-- In the cancellation column, turn rows with ‘NaN’ and ‘null’ to NULL
UPDATE runner_orders
SET cancellation = NULL
WHERE cancellation ='null' or cancellation ='NaN' OR cancellation ='' ;
SELECT*FROM runner_orders;

-- removing ‘km’ at the end of rows in the column  distance

UPDATE runner_orders
SET distance = REPLACE (distance,'km','');


-- Trim extra spaces from the distance column after removing ‘km’
UPDATE runner_orders
SET distance =TRIM(distance);


-- Removing minutes/mins/minute added at the end of the duration column
UPDATE runner_orders
SET duration = SUBSTRING(duration ,1,2);


-- Trim extra spaces from the duration column after removing ‘minutes/mins/minute’
UPDATE runner_orders
SET duration =TRIM(duration);


-- Changing Column Datatypes of table runner_orders 
-- Changing pickup_time column datatype from varchar to datetime

ALTER TABLE runner_orders
MODIFY COLUMN pickup_time DATETIME;

-- Changing distance column datatype from varchar to FLOAT
ALTER TABLE runner_orders
MODIFY COLUMN distance FLOAT;
SELECT*FROM runner_orders;

-- Changing duration column datatype from varchar to FLOAT
ALTER TABLE runner_orders
MODIFY COLUMN duration FLOAT;

