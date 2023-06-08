#' Function to return mammal shapefiles of afrosoricida Order
#' @importFrom utils download.file
#' @param dir A directory where to write the output
#' @return A SpatVector object with mammal shapefiles
#' @export
#' @source A phylogeny-informed characterization of global tetrapod traits
#'  addresses data gaps and biases
#'  \url{https://doi.org/10.1101/2023.03.04.531098}
#'
#'
#' @examples
#' get_mdd_afrosoricida()
get_mdd_Rodentia <- function(dir = NULL){
  root <- system.file(package = "mdd")
  filePath <- paste0(root, "/", "data/MDD_Rodentia.rds")

  if(!file.exists(filePath)){
    url <- "https://mdd-aligned-shp-0-1-0.nyc3.cdn.digitaloceanspaces.com/Rodentia.rds"

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
    readr::write_rds(shp, file = paste0(dir, "/MDD_Rodentia.rds"), compress = "xz")
  }
  return(terra::unwrap(shp))
}
