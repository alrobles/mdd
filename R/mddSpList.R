#' Species list from Mammal Diversity Database
#'
#' A list of species related with shapefiles
#' in MDD. Includes taxonomy
#'
#' @format ## `mddSpList`
#' A data frame with 6362 rows and 8 columns:
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
#' @source <https://www.who.int/teams/global-tuberculosis-programme/data>
"mddSpList"
