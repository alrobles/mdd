#' Title
#'
#' @param species A vector of mammal species name.
#' @param Order A vector of mammal orders to retrive.
#' @param country A string of country name in English.
#' @param continent A string of continent name in English.
#' @param cropCountry Logical. If TRUE, the shapefiles are crop with
#'  country or continent shape
#'
#' @return A SpatVector object with mammal shapefiles
#' @export
#' @source Expert range maps of global mammal distributions harmonised to
#'  three taxonomic authorities
#'  <https://doi.org/10.1111/jbi.14330>
#'
#' @examples
#' get_mdd_map("Notoryctes caurinus")
get_mdd_map <- function(species = NULL, Order = NULL, country = NULL, continent = NULL, cropCountry = FALSE){

  if(!(is.null(species) || is.null(Order))){
    stop("Please provide only species or order, not both!")
  }

  if(!(is.null(country) || is.null(continent))){
    stop("Please provide only country or continent, not both!")
  }

  allOrder <- unique(mddSpList$Order)
  allSp <- unique(mddSpList$MDD_SciName)
  matchOrder <- match(Order, allOrder)
  matchSp <- match(species, allSp)
  if( any(is.na( matchOrder) ) ){
    stop("Order not found. Check spell")
  }

  if( any(is.na(matchSp) ) ){
    stop("Species not found. Check spell")
  }


  #matchNames <- match(species, mddSpList$MDD_SciName)
  if(is.null(Order)){
    Order = unique(mddSpList$Order[matchSp] )
  }
  if(length(Order) == 27){
    shp <- get_mdd()
  } else {
    MapList <- Map(get_mdd_order, Order)
    shp <- terra::vect(MapList)
  }

  if(!is.null(species)){
    shp <- terra::subset(shp, shp$sciname %in% species)
  }

  safe_intersect <- function(shp, country, otherwise = NULL){
    force(otherwise)
    tryCatch(terra::intersect(shp, country), error = function(e) {
      message("Error: ", conditionMessage(e))
      otherwise
    })

  }

  if((!is.null(country) || !is.null(continent))){
    country_shp <- rnaturalearth::ne_countries(country = country, continent = continent, returnclass = "sp")
    country_shp <- terra::vect(country_shp)
    country_shp <- country_shp[, "name"]
    terra::crs(country_shp) <- terra::crs(shp)
    country_shp <- terra::buffer(country_shp, 0)
    #shp <- terra::buffer(shp, 0)
    shp_country <- safe_intersect(shp, country_shp)
    shp_country <- shp_country[ ,"sciname"]
    if(cropCountry){
      shp <- shp_country
    } else
    {
      shp <- subset(shp, shp$sciname %in% shp_country$sciname,  NSE=TRUE)
    }

  }

  return(shp)

}
