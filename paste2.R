# suppress NA when paste
paste2 <- function(...,sep=", ") {
  L <- list(...)
  L <- lapply(L,function(x) {x[is.na(x)] <- ""; x})
  gsub(paste0("(^",sep,"|",sep,"$)"),"",
       gsub(paste0(sep,sep),sep,
            do.call(paste,c(L,list(sep=sep)))))
}