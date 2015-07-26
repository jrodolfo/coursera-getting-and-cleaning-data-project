containsMeanOrStd <- function(string_input) {
    grepl("-mean", string_input) || grepl("-std", string_input)
}

extract_mean_and_std <- function(data_frame_input) {

    debug = FALSE
    num_rows <- nrow(data_frame_input)
    result <- data.frame()

    for (i in 1:num_rows) {
        row <- data_frame_input[i, ]
        row_num <- data_frame_input[i, 1]
        feature <- tolower(data_frame_input[i, 2])
        if (containsMeanOrStd(feature)) {
            if (debug) {
                message("-----------------------------------------------")
                message("row_num: ", row_num)
                message("feature: ", feature)
            }
            result <- rbind(result, row)
        }
    }
    result
}
