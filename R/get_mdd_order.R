#' Function to return mammal shapefiles of Rodentia order
#' @importFrom utils download.file
#' @param dir A directory where to write the output
#' @param order The mammal order want to  download
#' @return A SpatVector object with mammal shapefiles
#' @export
#' @source Expert range maps of global mammal distributions harmonised to
#'  three taxonomic authorities
#'  <https://doi.org/10.1111/jbi.14330>
#'
#'
#' @examples
#' get_mdd_order("Afrosoricida")
get_mdd_order <- function(order, dir = NULL){

  if(is.na(match(order, mddSpList$Order))){
    stop("Order does not exist! Check spell")
  }


  root <- system.file(package = "mdd")

  filePath <- paste0(root, "/", "data/MDD_", order, ".rds")
  if(!file.exists(filePath)){
    url <-
      paste0(
        "https://mdd-aligned-shp-0-1-0.nyc3.cdn.digitaloceanspaces.com/",
        order,
        ".rds"
      )

    # check if the url exists
    if (!url_exists(url)) {
      return("Can't access mammal data.")
    }


    shp <- readr::read_rds(url)
    readr::write_rds(shp, file = filePath, compress = "xz")
  }
  else{
    shp <- readr::read_rds(filePath)
  }

  if (!is.null(dir)) {
    readr::write_rds(shp, file = paste0(dir, "/MDD_", order, ".rds"), compress = "xz")
  }
  return(terra::unwrap(shp))
}
