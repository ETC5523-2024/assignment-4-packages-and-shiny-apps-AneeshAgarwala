## code to prepare `asxdata` dataset goes here

library(readr)
library(dplyr)

asxdata <- read_csv(file = "data-raw/asxdata.csv") |>
  filter(`Market Cap` != "SUSPENDED") |>
  filter(`Market Cap` != "--")

asxdata$MarketCap <- as.numeric(asxdata$`Market Cap`)/1000000

asxdata <- asxdata |> select(-`Market Cap`)

usethis::use_data(asxdata, overwrite = TRUE)

