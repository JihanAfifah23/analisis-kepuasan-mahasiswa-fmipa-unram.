# analisis-kepuasan-mahasiswa-fmipa-unram.

# Analisis Tingkat Kepuasan Mahasiswa terhadap Pelayanan Administrasi Akademik di FMIPA Universitas Mataram

## Latar Belakang
Pelayanan administrasi akademik merupakan salah satu aspek penting dalam menunjang kelancaran kegiatan perkuliahan di perguruan tinggi. Pelayanan yang baik dapat membantu mahasiswa dalam memperoleh informasi akademik, mengurus dokumen perkuliahan, serta memenuhi berbagai kebutuhan administrasi dengan lebih mudah dan cepat. Sebaliknya, pelayanan yang kurang optimal dapat menyebabkan hambatan dalam proses akademik mahasiswa.

Kepuasan mahasiswa terhadap pelayanan administrasi akademik dapat digunakan sebagai salah satu indikator kualitas pelayanan yang diberikan oleh institusi pendidikan. Oleh karena itu, evaluasi terhadap pelayanan administrasi akademik perlu dilakukan agar pihak fakultas dapat mengetahui kelebihan maupun kekurangan pelayanan yang telah diberikan.

FMIPA Universitas Mataram sebagai salah satu fakultas dengan jumlah mahasiswa yang cukup banyak tentunya memerlukan pelayanan administrasi akademik yang baik dan responsif. Untuk mengetahui tingkat kepuasan mahasiswa terhadap pelayanan administrasi akademik di FMIPA Universitas Mataram, dilakukan survei online menggunakan Google Form. Penelitian ini menggunakan teknik non probability sampling dengan metode convenience sampling.

## Tujuan
Tujuan dari penelitian ini adalah:
- Mengetahui tingkat kepuasan mahasiswa terhadap pelayanan administrasi akademik di FMIPA Universitas Mataram melalui survei online.
- Menentukan jumlah sampel penelitian menggunakan metode Slovin.
- Menguji validitas instrumen penelitian.
- Menguji reliabilitas instrumen penelitian.
- Membandingkan hasil validitas dan reliabilitas antara 10 data responden dan seluruh data responden.
- Mengetahui distribusi responden.
- Menghitung hasil naive estimation terhadap tingkat kepuasan mahasiswa.
- Melakukan weighting sederhana berdasarkan jenis kelamin untuk memperoleh hasil estimasi yang lebih representatif.

## Metode
Penelitian ini merupakan penelitian kuantitatif dengan pendekatan survei online. Data diperoleh melalui penyebaran kuesioner menggunakan Google Form kepada mahasiswa FMIPA Universitas Mataram.

Teknik sampling yang digunakan adalah non probability sampling dengan metode convenience sampling, yaitu pengambilan sampel berdasarkan kemudahan memperoleh responden. Jumlah responden dalam penelitian ini sebanyak 30 mahasiswa.

Pengolahan data dilakukan menggunakan bahasa pemrograman R dengan bantuan package `readxl`. Analisis dilakukan menggunakan script pada file `analisis.R`.

## Tahapan Analisis Data

### 1. Import Data
Pada tahap ini, data hasil survei yang telah disimpan dalam file Excel diimpor ke dalam R menggunakan package `readxl`. Proses ini bertujuan agar data dapat diolah dan dianalisis lebih lanjut.

```r
library(readxl)

data <- read_excel("C:/Users/asus/Downloads/Hasil Survei.xlsx")
```

---

## 2. Perhitungan Sampel Menggunakan Metode Slovin

Pada tahap ini dilakukan perhitungan jumlah sampel minimum menggunakan metode Slovin. Metode ini digunakan untuk menentukan jumlah sampel berdasarkan jumlah populasi dan margin of error yang digunakan dalam penelitian.

```r
N <- 1693
e <- 0.18

n <- N / (1 + N * (e^2))

ceiling(n)
```

Keterangan:
- `N` : jumlah populasi
- `e` : margin of error
- `ceiling()` : membulatkan hasil ke atas

---

## 3. Uji Validitas dan Reliabilitas Seluruh Data

Tahap ini bertujuan untuk menguji validitas dan reliabilitas instrumen menggunakan seluruh data responden.

Package `psych` digunakan untuk menghitung nilai validitas dan reliabilitas menggunakan metode Cronbach Alpha.

### Mengambil Item Pertanyaan

```r
library(psych)
library(dplyr)

item <- data[, 6:15]

item <- na.omit(item)
```

Syntax di atas digunakan untuk mengambil kolom pertanyaan kuesioner dan menghapus data kosong (`NA`).

### Uji Validitas dan Reliabilitas

```r
hasil <- alpha(item)

validitas <- hasil$item.stats

validitas$status <- ifelse(validitas$r.drop > 0.3,
                           "Valid",
                           "Tidak Valid")

validitas[, c("r.drop", "status")]

hasil$total
```

Keterangan:
- `alpha()` digunakan untuk menghitung validitas dan reliabilitas
- `r.drop` digunakan untuk melihat validitas item
- Item dinyatakan valid jika `r.drop > 0.3`
- `hasil$total` digunakan untuk menampilkan nilai Cronbach Alpha
- Instrumen dinyatakan reliabel jika nilai Cronbach Alpha > 0.7

---

## 4. Uji Validitas dan Reliabilitas 10 Data 

Pada tahap ini dilakukan pengujian menggunakan 10 data responden untuk membandingkan hasil dengan seluruh data responden.

```r
item_10 <- item[1:10, ]

hasil_10 <- alpha(item_10)

validitas_10 <- hasil_10$item.stats

validitas_10$status <- ifelse(validitas_10$r.drop > 0.3,
                              "Valid",
                              "Tidak Valid")

validitas_10[, c("r.drop", "status")]

hasil_10$total
```

Keterangan:
- `item[1:10, ]` digunakan untuk mengambil 10 responden pertama
- `alpha()` digunakan untuk menghitung validitas dan reliabilitas
- `r.drop` digunakan untuk melihat validitas item
- Item dinyatakan valid jika `r.drop > 0.3`
- `hasil_10$total` digunakan untuk menampilkan nilai Cronbach Alpha
- Instrumen dinyatakan reliabel jika nilai Cronbach Alpha > 0.7

---

## 5. Perbandingan Validitas dan Reliabilitas

Tahap ini bertujuan untuk membandingkan hasil validitas dan reliabilitas antara 10 data responden dan seluruh data responden.

### Perbandingan Validitas

Pada tahap ini dilakukan perbandingan jumlah item yang valid antara 10 data pertama dan seluruh data responden.

```r
# Jumlah item valid seluruh data

valid_full <- sum(validitas$r.drop > 0.3)

# Jumlah item valid 10 data

valid_10 <- sum(validitas_10$r.drop > 0.3)

# Tabel perbandingan validitas

perbandingan_validitas <- data.frame(
  Data = c("10 Data", "Seluruh Data"),
  Jumlah_Item_Valid = c(valid_10, valid_full)
)

print(perbandingan_validitas)
```

Keterangan:
- `sum()` digunakan untuk menghitung jumlah item valid
- Item dinyatakan valid jika `r.drop > 0.3`
- `data.frame()` digunakan untuk membuat tabel perbandingan validitas

---

### Perbandingan Reliabilitas

Pada tahap ini dilakukan perbandingan nilai reliabilitas antara 10 data dan seluruh data responden menggunakan Cronbach Alpha.

```r
# Ambil item valid dari 10 data

item_valid_10 <- rownames(validitas_10[validitas_10$r.drop > 0.3, ])

item_baru_10 <- item_10[, item_valid_10]

# Tabel perbandingan reliabilitas

perbandingan_reliabilitas <- data.frame(
  Data = c("10 Data Setelah Hapus", "Seluruh Data"),
  Cronbach_Alpha = c(
    alpha(item_baru_10)$total$raw_alpha,
    hasil$total$raw_alpha
  )
)

print(perbandingan_reliabilitas)
```

Keterangan:
- Item tidak valid pada 10 data dihapus terlebih dahulu
- `raw_alpha` menunjukkan nilai Cronbach Alpha
- `data.frame()` digunakan untuk membuat tabel perbandingan reliabilitas

### 6. Analisis Deskriptif 
Analisis ini dilakukan untuk mengetahui distribusi responden berdasarkan jenis kelamin. Fungsi `table()` digunakan untuk menghitung jumlah responden pada setiap kategori, sedangkan `prop.table()` digunakan untuk menghitung persentasenya.

```r
table(data$`Jenis Kelamin`)

prop.table(table(data$`Jenis Kelamin`)) * 100

table(data$`Program studi`)

prop.table(table(data$`Program studi`))*100

table(data$`Umur`)

prop.table(table(data$`Program studi`))*100
```

---

### 7. Tabel Distribusi Frekuensi dan Persentase
Tahap ini bertujuan untuk menyajikan data dalam bentuk tabel yang lebih rapi agar mudah dibaca dan diinterpretasikan.

```r
frekuensi <- table(data$`Jenis Kelamin`)
frekuensi

persentase <- prop.table(frekuensi) * 100
persentase

tabel_jk <- data.frame(
  Jenis_Kelamin = names(frekuensi),
  Frekuensi = as.vector(frekuensi),
  Persentase = round(as.vector(persentase), 2)
)

tabel_jk

frekuensi_prodi <- table(data$`Program studi`)
persentase_prodi <- prop.table(frekuensi_prodi)*100

tabel_prodi <- data.frame(
  Program_Studi = names(frekuensi_prodi),
  Frekuensi = as.vector(frekuensi_prodi),
  Persentase = round(as.vector(persentase_prodi),2)
)

tabel_prodi

frekuensi_umur <- table(data$`Umur`)
persentase_umur <- prop.table(frekuensi_umur)*100

tabel_umur <- data.frame(
  Umur = names(frekuensi_umur),
  Frekuensi = as.vector(frekuensi_umur),
  Persentase = round(as.vector(persentase_umur),2)
)

tabel_umur

```

---

### 8. Grafik Distribusi Responden
Grafik pie digunakan untuk memvisualisasikan distribusi responden berdasarkan jenis kelamin sehingga lebih mudah dipahami secara visual.

```r
pie(
  table(data$`Jenis Kelamin`),
  main = "Distribusi Responden Berdasarkan Jenis Kelamin"
)

frekuensi_prodi <- sort(table(data$`Program studi`), decreasing = TRUE)

barplot(
  frekuensi_prodi,
  main = "Distribusi Responden Berdasarkan Program Studi",
  xlab = "Program Studi",
  ylab = "Frekuensi",
  col = "lightblue"
)

frekuensi_umur <- table(data$`Umur`)

barplot(
  frekuensi_umur,
  main = "Distribusi Responden Berdasarkan Umur",
  xlab = "Umur",
  ylab = "Frekuensi",
  col = "lightgreen"
)

```

---

### 9. Naive Estimation Tingkat Kepuasan
Naive estimation digunakan untuk memperoleh estimasi awal tingkat kepuasan mahasiswa. Responden dianggap puas jika memberikan nilai ≥ 4 (skala Likert). Nilai proporsi dihitung dengan membagi jumlah responden yang puas dengan total responden.

```r
puas <- sum(
  data$`10. Secara keseluruhan, saya puas terhadap pelayanan administrasi akademik FMIPA Universitas Mataram.` >= 4
)

n <- nrow(data)

p <- puas / n

p
p * 100
```

---

### 10. Weighting Sederhana Berdasarkan Jenis Kelamin
Weighting dilakukan untuk mengurangi bias akibat ketidakseimbangan sampel. Bobot dihitung berdasarkan perbandingan antara proporsi populasi dan proporsi sampel.

```r
# Proporsi populasi
pop_laki <- 0.5
pop_perempuan <- 0.5

# Proporsi sampel
sampel_laki <- 0.3333
sampel_perempuan <- 0.6667

# Perhitungan bobot
w_laki <- pop_laki / sampel_laki
w_perempuan <- pop_perempuan / sampel_perempuan

w_laki
w_perempuan

# Jumlah responden puas
puas_laki <- 7
puas_perempuan <- 18

# Perhitungan weighted estimation
weighted_laki <- puas_laki * w_laki
weighted_perempuan <- puas_perempuan * w_perempuan

total_weighted <- weighted_laki + weighted_perempuan

weighted_estimation <- total_weighted / n

weighted_estimation
weighted_estimation * 100
```

---

### 11. Perbandingan Naive dan Weighted Estimation
Tahap ini bertujuan untuk membandingkan hasil estimasi sebelum dan sesudah dilakukan pembobotan menggunakan grafik batang.

```r
estimasi <- c(p * 100, weighted_estimation * 100)

nama <- c("Naive Estimation", "Weighted Estimation")

barplot(
  estimasi,
  names.arg = nama,
  main = "Perbandingan Hasil Estimasi",
  ylab = "Persentase"
)
```

## Hasil dan Pembahasan

### Hasil Perhitungan Sampel Menggunakan Metode Slovin

Berdasarkan hasil perhitungan menggunakan metode Slovin dengan jumlah populasi sebanyak `1693` mahasiswa dan margin of error sebesar `18%`, diperoleh jumlah sampel sebesar `30,31` sehingga dibulatkan menjadi `31` responden.

## Hasil Uji Validitas dan Reliabilitas Seluruh Data

Berdasarkan hasil uji validitas menggunakan Corrected Item-Total Correlation (`r.drop`), seluruh item pertanyaan memiliki nilai `r.drop > 0,3` sehingga seluruh item dinyatakan valid. Nilai `r.drop` tertinggi terdapat pada item *“Secara keseluruhan, saya puas terhadap pelayanan administrasi akademik FMIPA Universitas Mataram”* sebesar `0,8226397`, sedangkan nilai terendah terdapat pada item *“Pelayanan administrasi mudah diakses mahasiswa”* sebesar `0,5246258`. Hasil ini menunjukkan bahwa seluruh item pertanyaan mampu mengukur tingkat kepuasan mahasiswa dengan baik.

Hasil uji reliabilitas menggunakan Cronbach Alpha memperoleh nilai `0,9144309`. Karena nilai Cronbach Alpha lebih besar dari `0,7`, maka instrumen penelitian dinyatakan reliabel dan memiliki tingkat konsistensi yang sangat baik.

---

### Hasil Uji Validitas dan Reliabilitas 10 Data Pertama

Berdasarkan hasil uji validitas menggunakan 10 data pertama responden, terdapat 9 item yang dinyatakan valid karena memiliki nilai `r.drop > 0,3`. Namun, terdapat 1 item yang tidak valid yaitu item *“Pelayanan administrasi mudah diakses mahasiswa”* dengan nilai `r.drop` sebesar `0,1248612`. Hal ini menunjukkan bahwa item tersebut memiliki hubungan yang rendah terhadap total skor pada 10 data pertama responden.

Hasil uji reliabilitas menggunakan Cronbach Alpha pada 10 data pertama memperoleh nilai sebesar `0,9096981`. Karena nilai Cronbach Alpha lebih besar dari `0,7`, maka instrumen penelitian tetap dinyatakan reliabel dan memiliki tingkat konsistensi yang baik.

Setelah item yang tidak valid dihapus, nilai Cronbach Alpha meningkat menjadi `0,9295424`. Hal ini menunjukkan bahwa penghapusan item tidak valid dapat meningkatkan tingkat konsistensi instrumen penelitian.

### Perbandingan Validitas dan Reliabilitas


Hasil perbandingan validitas menunjukkan bahwa seluruh data memiliki jumlah item valid yang lebih banyak dibandingkan 10 data pertama responden.

| Data | Jumlah Item Valid |
|---|---|
| 10 Data | 9 |
| Seluruh Data | 10 |

Berdasarkan hasil perbandingan validitas, pada 10 data pertama terdapat 9 item yang valid, sedangkan pada seluruh data responden terdapat 10 item yang valid. Hal ini menunjukkan bahwa penggunaan seluruh data responden menghasilkan pengujian validitas yang lebih baik dan lebih representatif dibandingkan hanya menggunakan 10 data pertama responden. Semakin banyak jumlah responden yang digunakan, maka hubungan antar item menjadi lebih stabil sehingga hasil validitas yang diperoleh lebih akurat.

---

Hasil perbandingan reliabilitas menunjukkan bahwa nilai Cronbach Alpha pada 10 data setelah penghapusan item tidak valid lebih besar dibandingkan seluruh data responden.

| Data | Cronbach Alpha |
|---|---|
| 10 Data Setelah Hapus | 0.9295424 |
| Seluruh Data | 0.9144309 |

Berdasarkan hasil perbandingan reliabilitas, nilai Cronbach Alpha pada 10 data setelah penghapusan item tidak valid lebih tinggi dibandingkan seluruh data responden. Hal ini dapat terjadi karena jawaban pada 10 data pertama cenderung lebih homogen dan konsisten sehingga menghasilkan nilai reliabilitas yang lebih besar. Sementara itu, pada seluruh data responden terdapat variasi jawaban yang lebih beragam sehingga nilai Cronbach Alpha sedikit menurun. Meskipun demikian, hasil reliabilitas menggunakan seluruh data responden lebih representatif karena melibatkan jumlah responden yang lebih banyak dan lebih mampu menggambarkan kondisi populasi sebenarnya.

### Analisis Deskriptif
Analisis deskriptif dilakukan untuk mengetahui gambaran karakteristik responden yang berpartisipasi dalam survei online. Karakteristik responden yang dianalisis dalam penelitian ini adalah berdasarkan jenis kelamin, program studi dan umur.

| Jenis Kelamin | Frekuensi | Persentase |
|---|---|---|
| Laki-laki | 10 | 33.33% |
| Perempuan | 20 | 66.67% |
| Total | 30 | 100% |

Berdasarkan hasil survei, diperoleh sebanyak 30 responden dengan distribusi jenis kelamin terdiri atas 10 responden laki-laki (33,33%) dan 20 responden perempuan (66,67%). Hasil ini menunjukkan bahwa mayoritas responden dalam penelitian ini adalah perempuan.

| Program Studi | Frekuensi | Persentase (%) |
|---------------|-----------|----------------|
| Biologi       | 3         | 10,00%          |
| Fisika        | 5         | 16,67%         |
| Kimia         | 5         | 16,67%         |
| Matematika    | 6         | 20,00%          |
| Statistika    | 11        | 36,67%          |
| **Total**     | **30**    | **100,00%**     |

Berdasarkan tabel distribusi responden menurut program studi, responden terbanyak berasal dari Program Studi Statistika sebanyak 11 orang (36,67%), sedangkan responden paling sedikit berasal dari Program Studi Biologi sebanyak 3 orang (10,00%).

| Umur | Frekuensi | Persentase |
|------|-----------|-------------|
| < 18 tahun | 1  | 3,33%  |
| 18–19 tahun | 1  | 3,33%  |
| 20–21 tahun | 26 | 86,67% |
| > 21 tahun | 2  | 6,67%  |
| **Total** | **30** | **100,00%** |

Berdasarkan tabel distribusi umur responden, mayoritas responden berada pada rentang usia 20–21 tahun yaitu sebanyak 26 orang (86,67%). Sisanya berasal dari usia di bawah 18 tahun dan 18–19 tahun masing-masing 1 orang (3,33%), serta usia di atas 21 tahun sebanyak 2 orang (6,67%). Hal ini menunjukkan bahwa responden penelitian didominasi oleh kelompok usia mahasiswa pada rentang usia produktif perkuliahan.

### Grafik Distribusi Responden
Visualisasi data dilakukan menggunakan pie chart untuk memperlihatkan distribusi responden berdasarkan jenis kelamin. 

<img width="1097" height="812" alt="Grafik Distribusi Responden" src="https://github.com/user-attachments/assets/6ceb3cff-6286-4a90-b223-8202cb00251c" />

Grafik menunjukkan bahwa jumlah responden perempuan lebih mendominasi dibandingkan responden laki-laki.

<img width="775" height="845" alt="image" src="https://github.com/user-attachments/assets/c7063d87-f253-487f-aecc-8c3179497617" />

Grafik menunjukkan bahwa jumlah responden statistika lebih mendominasi dibandingkan responden metematika, kimia,fisika, dan biologi.

<img width="807" height="842" alt="image" src="https://github.com/user-attachments/assets/c99bacec-8dcd-409c-b982-e6f9beeb4956" />

Grafik menunjukkan bahwa jumlah responden umur 20-21 tahun lebih mendominasi dibandingkan responden <18, >21, 18-19 tahun.

### Naive Estimation
Naive estimation digunakan untuk menghitung estimasi awal tingkat kepuasan mahasiswa tanpa melakukan pembobotan terhadap data responden.

Berdasarkan hasil analisis menggunakan script R dengan

diperoleh:
- Jumlah responden puas = 25 orang
- Total responden = 30 orang

Hasil naive estimation menunjukkan 83% mahasiswa puas terhadap pelayanan akademik di FMIPA Unram, tetapi estimasi berpotensi bias karena komposisi sampel tidak mewakili populasi 

### Weighting Sederhana
Weighting sederhana dilakukan untuk menyesuaikan distribusi sampel agar lebih mendekati kondisi populasi sebenarnya berdasarkan jenis kelamin.

Dalam penelitian ini diasumsikan bahwa proporsi populasi laki-laki dan perempuan masing-masing sebesar 50%. Setelah dilakukan pembobotan menggunakan script R 

diperoleh weighted estimation sebesar 80%.

Hasil ini menunjukkan adanya sedikit perubahan dibandingkan naive estimation sebelumnya. Weighting sederhana membantu mengurangi potensi bias akibat ketidakseimbangan jumlah responden laki-laki dan perempuan dalam sampel penelitian.

### Perbandingan Estimasi
Perbandingan hasil estimasi dilakukan untuk melihat perbedaan antara naive estimation dan weighted estimation.

| Metode Estimasi | Hasil |
|---|---|
| Naive Estimation | 83% |
| Weighted Estimation | 80% |

<img width="1896" height="902" alt="Grafik distribusi perbandingan estimasi" src="https://github.com/user-attachments/assets/faa07e74-de87-4c51-9ae9-44068422bf4f" />

Hasil analisis menunjukkan bahwa naive estimation menghasilkan tingkat kepuasan sebesar 83%, sedangkan weighted estimation menghasilkan tingkat kepuasan sebesar 80%. Perbedaan hasil yang relatif kecil menunjukkan bahwa distribusi sampel responden sudah cukup mendekati kondisi populasi sebenarnya.

## Kesimpulan
Berdasarkan hasil analisis non-probability sampling pada survei online mengenai tingkat kepuasan mahasiswa terhadap pelayanan administrasi akademik di FMIPA Universitas Mataram, diperoleh bahwa mayoritas responden dalam penelitian ini merasa puas terhadap pelayanan administrasi akademik yang diberikan.

Distribusi responden menunjukkan bahwa responden perempuan lebih mendominasi dibandingkan responden laki-laki. Hasil naive estimation menunjukkan tingkat kepuasan sebesar 83%, sedangkan setelah dilakukan weighting sederhana berdasarkan jenis kelamin diperoleh estimasi sebesar 80%.

Perbedaan hasil yang relatif kecil menunjukkan bahwa distribusi sampel sudah cukup mendekati kondisi populasi sebenarnya. Weighting sederhana membantu mengurangi potensi bias sehingga hasil estimasi menjadi lebih representatif.

## Link Kuesioner

https://docs.google.com/forms/d/e/1FAIpQLSeu39SBVG_iESo01b_hiXV-DUnDqZrHVVGbzfqrI0NlJfssfg/viewform?usp=header
