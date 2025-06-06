# File created by YHL on 20240321

# 載入必要的套件
library(dplyr)
library(stringr)
library(testthat)

check_data_integrity_fixed <- function(data) {
  # 首先获取数据中的所有唯一ID
  ids <- unique(data$ID)
  
  # 初始化一个空的列表来存储每个ID的缺失数据
  missing_data_list <- list()
  
  # 遍历每个ID
  for (id in ids) {
    # 提取当前ID的数据子集
    subset_data <- data[data$ID == id, ]
    
    # 生成当前ID的所有可能组合
    all_combinations <- expand.grid(ID = id,
                                    Hand = unique(data$Hand),
                                    Force = unique(data$Force),
                                    Hemisphere = unique(data$Hemisphere),
                                    ROI = unique(data$ROI))
    
    # 确定缺失的组合
    missing_combinations <- anti_join(all_combinations, subset_data, by = c("ID", "Hand", "Force", "Hemisphere", "ROI"))
    
    # 如果存在缺失的组合，则添加到列表
    if (nrow(missing_combinations) > 0) {
      missing_data_list[[as.character(id)]] <- missing_combinations
    }
  }
  
  # 合并列表中的所有缺失数据
  missing_data <- do.call(rbind, missing_data_list)
  
  return(missing_data)
}

# Define file directory
file_dir <- '/media/DATA3/GripForce/meta_scripts/ROI_features'

# Get the latest files based on modification date
get_latest_file <- function(directory, pattern) {
  files <- list.files(directory, full.names = TRUE, recursive = FALSE)
  filtered_files <- files[str_detect(files, pattern)]
  if (length(filtered_files) == 0) return(NA)
  file_info <- data.frame(
    file = filtered_files,
    date = sapply(filtered_files, function(f) file.info(f)$mtime),
    stringsAsFactors = FALSE
  )
  latest_file <- file_info %>%
    filter(!is.na(date)) %>%
    arrange(desc(date)) %>%
    slice(1) %>%
    pull(file)
  return(latest_file)
}

# Find the latest voxel count file
latest_voxel_count <- get_latest_file(file_dir, "voxel_count")

# Find the latest beta file
latest_beta <- get_latest_file(file_dir, "beta")

# Check voxel count
if (!is.na(latest_voxel_count)) {
  print('Start voxel count file examination......')
  print(paste0('File name: ', latest_voxel_count))
  data <- read.table(
    latest_voxel_count, 
    header = TRUE, 
    sep = ',', 
    stringsAsFactors = FALSE
  )
  missing_data <- check_data_integrity_fixed(data)
  print(
    paste(
      "Missing combinations of voxel counts:", 
      ifelse(test = (length(missing_data) == 0), yes = 'NONE', no = missing_data)
    )
  )
  if (length(missing_data) != 0) {
    print('-------------------------Following were the missing data points-------------------------')
    print(missing_data)
    print('-------------------------Above were the missing data points-------------------------')
  }
  test_that("All combinations are present", {
    expect_null(missing_data)
  })
} else {
  print("No voxel count file found.")
}

# Check beta
if (!is.na(latest_beta)) {
  print('Start beta file examination......')
  print(paste0('File name: ', latest_beta))
  data <- read.table(
    latest_beta, 
    header = TRUE, 
    sep = ',', 
    stringsAsFactors = FALSE
  )
  missing_data <- check_data_integrity_fixed(data)
  print(
    paste(
      "Missing combinations of beta:", 
      ifelse(test = (length(missing_data) == 0), yes = 'NONE', no = missing_data)
    )
  )
  if (length(missing_data) != 0) {
    print('-------------------------Following were the missing data points-------------------------')
    print(missing_data)
    print('-------------------------Above were the missing data points-------------------------')
  }
  test_that("All combinations are present", {
    expect_null(missing_data)
  })
} else {
  print("No beta file found.")
}
