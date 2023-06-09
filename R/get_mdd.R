#' Function to return mammal shapefiles of Rodentia order
#' @importFrom utils download.file
#' @param dir A directory where to write the output
#' @param Order The mammal order want to  download
#' @return A SpatVector object with mammal shapefiles
#' @export
#' @source Expert range maps of global mammal distributions harmonised to
#'  three taxonomic authorities
#'  \url{https://doi.org/10.1111/jbi.14330}
#' @examples
#' get_mdd("all")
get_mdd <- function(Order = "all", dir = NULL){
  if(Order == "all")
    Order = sort(unique(mddSpList$Order))

  if(
    any(
      is.na(
        match(Order, unique(mddSpList$Order)))
    )
  ){
    stop("Order does not exist! Check spell")
  }
  #### progress call

  map_mdd_progress <- function(.x = Order, ...) {
    #.f <- purrr::as_mapper(.f, ...)
    pb <- progress::progress_bar$new(total = length(.x), format = " [:bar] :current/:total (:percent) eta: :eta", force = TRUE)
    f <- function(...) {
      pb$tick()
      get_mdd_order(...)
    }
    Map(f = f, .x )
  }
  root <- system.file(package = "mdd")
  filePath <- paste0(root, "/", "data/MDD.rds")
  if(!file.exists(filePath)){
    MapList <- map_mdd_progress(Order)
    shp <- terra::vect(MapList)
    shp <- terra::wrap(shp)
    readr::write_rds(shp, file = filePath, compress = "xz")
  } else{
    shp <- readr::read_rds(filePath)
  }
  if (!is.null(dir)) {
    readr::write_rds(shp, file = paste0(dir, "/MDD_", Order, ".rds"), compress = "xz")
  }
  return(terra::unwrap(shp))
}
