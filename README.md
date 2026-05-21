# analisis-kepuasan-mahasiswa-fmipa-unram.

# Analisis Tingkat Kepuasan Mahasiswa terhadap Pelayanan Administrasi Akademik di FMIPA Universitas Mataram

## Latar Belakang
Pelayanan administrasi akademik merupakan salah satu aspek penting dalam menunjang kelancaran kegiatan perkuliahan di perguruan tinggi. Pelayanan yang baik dapat membantu mahasiswa dalam memperoleh informasi akademik, mengurus dokumen perkuliahan, serta memenuhi berbagai kebutuhan administrasi dengan lebih mudah dan cepat. Sebaliknya, pelayanan yang kurang optimal dapat menyebabkan hambatan dalam proses akademik mahasiswa.

Kepuasan mahasiswa terhadap pelayanan administrasi akademik dapat digunakan sebagai salah satu indikator kualitas pelayanan yang diberikan oleh institusi pendidikan. Oleh karena itu, evaluasi terhadap pelayanan administrasi akademik perlu dilakukan agar pihak fakultas dapat mengetahui kelebihan maupun kekurangan pelayanan yang telah diberikan.

FMIPA Universitas Mataram sebagai salah satu fakultas dengan jumlah mahasiswa yang cukup banyak tentunya memerlukan pelayanan administrasi akademik yang baik dan responsif. Untuk mengetahui tingkat kepuasan mahasiswa terhadap pelayanan administrasi akademik di FMIPA Universitas Mataram, dilakukan survei online menggunakan Google Form. Penelitian ini menggunakan teknik non probability sampling dengan metode convenience sampling.

## Tujuan
Tujuan dari penelitian ini adalah:
- Mengetahui tingkat kepuasan mahasiswa terhadap pelayanan administrasi akademik di FMIPA Universitas Mataram melalui survei online.
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

### 2. Analisis Deskriptif 
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

### 3. Tabel Distribusi Frekuensi dan Persentase
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

### 4. Grafik Distribusi Responden
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

### 5. Naive Estimation Tingkat Kepuasan
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

### 6. Weighting Sederhana Berdasarkan Jenis Kelamin
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

### 7. Perbandingan Naive dan Weighted Estimation
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
