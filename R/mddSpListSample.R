#' Species list sample from Mammal Diversity Database
#'
#' A list of species related with shapefiles
#' in MDD. Includes taxonomy
#'
#' @format ## `mddSpListSample`
#' A data frame with 5 rows and 8 columns:
#' \describe{
#'   \item{Order}{Order of the species}
#'   \item{Family}{Family of the species }
#'   \item{Genus}{Genus of the species}
#'   \item{Species}{Species Name}
#'   \item{MDD_SciName}{Species binomial name}
#'   \item{Digitisable}{Is digitisable?}
#'   \item{diffSinceCMW}{Has a difference from CMW}
#'   \item{CMW_SciName}{Species name in CMW }
#'   \item{shp_orig}{Source of the shp}
#'   ...
#' }
#' @source Expert range maps of global mammal distributions harmonised to
#'  three taxonomic authorities
#'  <https://doi.org/10.1111/jbi.14330>
"mddSpListSample"
