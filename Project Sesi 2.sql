-- Ada berapa jumlah order yang tercatat? Ada 124.452
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders

-- Ada berapa yang complete? 31.359
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 status = 'Complete'; -- value bersifat case sensitif

-- Distinct/ Mengambil nilai unique (Canceled, Complete, Processing, Returned, Shipped)
SELECT
 DISTINCT status
FROM bigquery-public-data.thelook_ecommerce.orders;

-- Ada berapa total yang cancel (18.634) dan complete (31.359)
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 status = 'Cancelled';

SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 status = 'Complete';

-- Ada berapa total canceled dan complete pakai IN untuk memfilter beberapa status (49.993)
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 status IN  ('Complete', 'Cancelled');

 -- Ambil negasi pakai NOT
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 status NOT IN  ('Complete', 'Cancelled');


SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 num_of_item = 3;

-- >, <, >=, <=
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 num_of_item >= 1;


SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 created_at >= '2026-10-20';

-- ORDER BY, sort/mengurutkan data ASC (ascending) DESC (descending)
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 created_at >= '2026-10-20'
ORDER BY created_at ASC;

SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 created_at >= '2026-10-20'
ORDER BY created_at DESC;

-- berapa item terbanyak dalam satu transaksi complete yang terjadi pada tanggal 28 oktober 2026
SELECT
 order_id,
 num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 DATE_TRUNC (created_at, day) ='2026-10-28'AND 
 status = 'Complete'   
ORDER BY num_of_item DESC;

SELECT
  *
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
  status = 'Complete'
  AND DATE(created_at) = '2026-10-28'
ORDER BY
  num_of_item DESC;

--Ada berapa banyak negara yang terdaftar?
SELECT
DISTINCT country
FROM bigquery-public-data.thelook_ecommerce.users;

-- Ada berapa banyak kota yang terdaftar dari brazil?
SELECT
DISTINCT city 
FROM bigquery-public-data.thelook_ecommerce.users
WHERE country = 'Brasil';

--identifikasi sumber kunjungan user (trafic source). list apa saja
SELECT
DISTINCT traffic_source
FROM bigquery-public-data.thelook_ecommerce.users;
1	Search 70.294
2	Organic 14.692
3	Email 5021
4	Facebook 6034
5	Display 3959

-- sumber mana yang paling dominan
SELECT
 id
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Search';

SELECT
 id
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Organic';

SELECT
 id
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Email';

SELECT
 id
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Facebook';

SELECT
 id
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Display';

-- Tantangan C
SELECT
 id, status, 
