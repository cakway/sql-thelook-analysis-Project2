# 🔍 SQL Data Filtering & Sorting: `thelook_ecommerce`

Dokumen ini berisi materi dan kumpulan kueri SQL untuk tingkat menengah-dasar dalam melakukan pemfilteran (*filtering*), pengurutan (*sorting*), serta ekstraksi data unik (*unique values*) menggunakan Google BigQuery pada dataset `thelook_ecommerce`.

---

## 📌 Topik Pembelajaran

1. **Filtering Data**: Penggunaan klausa `WHERE` dengan operator perbandingan (`=`, `>`, `>=`, `<`, `<=`).
2. **Kondisi Majemuk & Negasi**: Penggunaan operator `IN` dan `NOT IN`.
3. **Nilai Unik**: Penggunaan klausa `DISTINCT`.
4. **Pengurutan Data**: Penggunaan klausa `ORDER BY` (`ASC` dan `DESC`).
5. **Manipulasi Tanggal**: Pemanfaatan fungsi `DATE()` dan `DATE_TRUNC()`.

---

## 📜 Kueri SQL dan Penjelasan

### 1. Analisis Status Pemesanan (`orders`)

* **Menghitung Total Order** *(Total: 124.452 baris)*:
  ```sql
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders;
  ```

* **Filter berdasarkan Status Spesifik** *(Case-Sensitive)*:
  ```sql
  -- Mencari transaksi dengan status Complete (Total: 31.359)
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE status = 'Complete';
  ```

* **Mengekstrak Kategori Status Unik**:
  ```sql
  -- Hasil: Cancelled, Complete, Processing, Returned, Shipped
  SELECT DISTINCT status
  FROM bigquery-public-data.thelook_ecommerce.orders;
  ```

* **Filter Banyak Status (`IN` & `NOT IN`)**:
  ```sql
  -- Mengambil status Complete dan Cancelled (Total: 49.993)
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE status IN ('Complete', 'Cancelled');

  -- Negasi: Mengambil status SELAIN Complete dan Cancelled
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE status NOT IN ('Complete', 'Cancelled');
  ```

---

### 2. Filtering Angka dan Tanggal

* **Filter Jumlah Barang (`num_of_item`)**:
  ```sql
  -- Transaksi dengan persis 3 barang
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE num_of_item = 3;

  -- Transaksi dengan minimal 1 barang
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE num_of_item >= 1;
  ```

* **Pengurutan berdasarkan Waktu (`ORDER BY`)**:
  ```sql
  -- Urutan Ascending (Terlama ke Terbaru)
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE created_at >= '2026-10-20'
  ORDER BY created_at ASC;

  -- Urutan Descending (Terbaru ke Terlama)
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE created_at >= '2026-10-20'
  ORDER BY created_at DESC;
  ```

* **Studi Kasus Tanggal Spesifik**:
  Mencari transaksi *Complete* pada tanggal **28 Oktober 2026** dengan jumlah barang terbanyak.
  ```sql
  -- Opsi 1: Menggunakan DATE_TRUNC
  SELECT order_id, num_of_item
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE DATE_TRUNC(created_at, DAY) = '2026-10-28' 
    AND status = 'Complete'   
  ORDER BY num_of_item DESC;

  -- Opsi 2: Menggunakan DATE()
  SELECT *
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE status = 'Complete'
    AND DATE(created_at) = '2026-10-28'
  ORDER BY num_of_item DESC;
  ```

---

### 3. Analisis Demografi dan Traffic Pengguna (`users`)

* **Daftar Negara Terdaftar**:
  ```sql
  SELECT DISTINCT country
  FROM bigquery-public-data.thelook_ecommerce.users;
  ```

* **Daftar Kota di Negara Spesifik (Brasil)**:
  ```sql
  SELECT DISTINCT city 
  FROM bigquery-public-data.thelook_ecommerce.users
  WHERE country = 'Brasil';
  ```

* **Analisis Sumber Kunjungan (*Traffic Source*)**:
  ```sql
  -- Melihat daftar saluran trafik unik
  SELECT DISTINCT traffic_source
  FROM bigquery-public-data.thelook_ecommerce.users;
  ```

  **Ringkasan Distribusi Traffic Source:**
  1. `Search`: 70.294 pengguna
  2. `Organic`: 14.692 pengguna
  3. `Facebook`: 6.034 pengguna
  4. `Email`: 5.021 pengguna
  5. `Display`: 3.959 pengguna

* **Pemeriksaan Pengguna per Traffic Source**:
  ```sql
  -- Contoh filter berdasarkan saluran tertentu (misal: Search)
  SELECT id
  FROM bigquery-public-data.thelook_ecommerce.users
  WHERE traffic_source = 'Search';
  ```

---

## 📌 Catatan Penting (Key Takeaways)

1. **Nilai Teks bersifat Case-Sensitive**: 'Complete' berbeda dengan 'complete'.
2. **`IN` vs `OR`**: Penggunaan `IN ('A', 'B')` lebih efisien dan rapi dibandingkan menggunakan banyak klausa `OR`.
3. **Pengolahan Tanggal**: Tipe data `TIMESTAMP` memerlukan fungsi perantara seperti `DATE()` atau `DATE_TRUNC()` untuk membandingkannya secara presisi dengan format tanggal `YYYY-MM-DD`.
