# Hitung Sampel (Slovin)

N <- 1693
e <- 0.15

n <- N / (1 + N * (e^2))
ceiling(n)

# Load package

library(readxl)
library(psych)
library(dplyr)

# Import data

data <- read_excel("C:/Users/asus/Downloads/Hasil Survei (3).xlsx")

# Ambil item

item <- data[, 6:15]

# Hapus NA

item <- na.omit(item)

# Uji validitas & reliabilitas seluruh data

cat("HASIL SELURUH DATA\n")

hasil <- alpha(item)

validitas <- hasil$item.stats

validitas$status <- ifelse(validitas$r.drop > 0.3,
                           "Valid",
                           "Tidak Valid")

print(validitas[, c("r.drop", "status")])

cat("\nReliabilitas Seluruh Data:\n")
print(hasil$total)

# Item valid

item_valid <- rownames(validitas[validitas$r.drop > 0.3, ])

item_baru <- item[, item_valid]

# Uji ulang

cat("\nReliabilitas Setelah Hapus Item Tidak Valid:\n")
print(alpha(item_baru)$total)

# Analisis 10 data pertama

cat("\nHASIL 10 DATA PERTAMA\n")

item_10 <- item[1:10, ]
View(item_10)
hasil_10 <- alpha(item_10)

validitas_10 <- hasil_10$item.stats

validitas_10$status <- ifelse(validitas_10$r.drop > 0.3,
                              "Valid",
                              "Tidak Valid")

print(validitas_10[, c("r.drop", "status")])

cat("\nReliabilitas 10 Data:\n")

print(hasil_10$total)
# Ambil item valid saja dari 10 data

item_valid_10 <- rownames(validitas_10[validitas_10$r.drop > 0.3, ])

item_baru_10 <- item_10[, item_valid_10]


cat("\nReliabilitas 10 Data Setelah Hapus Item Tidak Valid:\n")

print(alpha(item_baru_10)$total)
# Perbandingan Validitas

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
# Perbandingan reliabilitas

perbandingan <- data.frame(
  Data = c("10 Data Setelah Hapus", "Seluruh Data"),
  Cronbach_Alpha = c(
    alpha(item_baru_10)$total$raw_alpha,
    hasil$total$raw_alpha
  )
)

cat("\nPerbandingan Reliabilitas:\n")
print(perbandingan)
