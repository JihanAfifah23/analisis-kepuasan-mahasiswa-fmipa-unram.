# ANALISIS NON-PROBABILITY SAMPLING
# Tingkat Kepuasan Mahasiswa terhadap Pelayanan Administrasi Akademik FMIPA Universitas Mataram
# 1. Import Data
library(readxl)
data <-read_excel("C:/Users/asus/Downloads/Hasil Survei (3).xlsx")
# Melihat data
View(data)
# 2. Analisis Deskriptif
table(data$`Jenis Kelamin`)
table(data$`Program studi`)
table(data$`Umur`)
prop.table(table(data$`Jenis Kelamin`))*100
prop.table(table(data$`Program studi`))*100
prop.table(table(data$`Umur`))*100
# 3. Tabel dan Grafik Distribusi Responden
frekuensi <- table(data$`Jenis Kelamin`)
frekuensi
persentase <- prop.table(frekuensi)*100
persentase
tabel_jk <- data.frame(
  Jenis_Kelamin = names(frekuensi),
  Frekuensi = as.vector(frekuensi),
  Persentase = round(as.vector(persentase),2)
)
tabel_jk
# Tabel Distribusi Program Studi
frekuensi_prodi <- table(data$`Program studi`)
persentase_prodi <- prop.table(frekuensi_prodi)*100

tabel_prodi <- data.frame(
  Program_Studi = names(frekuensi_prodi),
  Frekuensi = as.vector(frekuensi_prodi),
  Persentase = round(as.vector(persentase_prodi),2)
)

tabel_prodi
# Tabel Distribusi Umur
frekuensi_umur <- table(data$`Umur`)
persentase_umur <- prop.table(frekuensi_umur)*100

tabel_umur <- data.frame(
  Umur = names(frekuensi_umur),
  Frekuensi = as.vector(frekuensi_umur),
  Persentase = round(as.vector(persentase_umur),2)
)

tabel_umur
# Pie chart
pie(table(data$`Jenis Kelamin`),
    main = " Distribusi Responden Berdasarkan Jenis Kelamin")
#grafik Program studi
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

# 4. Naive Estimation
# Menghitung jumlah responden puas
# (Puas + Sangat Puas)
puas <- sum(
  data$`10. Secara keseluruhan, saya puas terhadap pelayanan administrasi akademik FMIPA Universitas Mataram.` >= 4
)
# Total responden
n <- nrow(data)
# Naive estimation
p <- puas/n
# Hasil naive estimation
p
# Persentase
p*100
# 5. Weighting Sederhana
# Proporsi populasi
pop_laki <- 0.5
pop_perempuan <- 0.5
# Proporsi sampel
sampel_laki <- 0.3333
sampel_perempuan <- 0.6667
# Menghitung bobot
w_laki <- pop_laki/sampel_laki
w_perempuan <- pop_perempuan/sampel_perempuan
# Menampilkan bobot
w_laki
w_perempuan
# 6. Weighted Estimation
# Jumlah puas laki-laki
puas_laki <- 7
# Jumlah puas perempuan
puas_perempuan <- 18
# Weighted puas laki-laki
weighted_laki <- puas_laki*w_laki
# Weighted puas perempuan
weighted_perempuan <- puas_perempuan*w_perempuan
# Total weighted puas
total_weighted <- weighted_laki + weighted_perempuan
# Weighted estimation
weighted_estimation <- total_weighted/n
# Hasil weighted estimation
weighted_estimation
# Persentase weighted estimation
weighted_estimation*100
# 7. Grafik Perbandingan
estimasi <- c(p*100,
              weighted_estimation*100)
nama <- c("Naive Estimation",
          "Weighted Estimation")
barplot(estimasi,
        names.arg = nama,
        main = "Perbandingan Hasil Estimasi",
        ylab = "Persentase")
# 8. Output Hasil
cat("Naive Estimation =", p*100, "%/n")
cat("Weighted Estimation =",
    weighted_estimation*100,
    "%/n")