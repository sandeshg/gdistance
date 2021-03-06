\name{geoCorrection}
\alias{geoCorrection}
\alias{geoCorrection,TransitionLayer,character-method}
\alias{geoCorrection,TransitionLayer,missing-method}
\title{ Geographic Correction }
\description{ Correct Transition* objects taking into account local distances
}

\usage{
geoCorrection(x, type, ...)
}
\arguments{
  \item{x}{object of class Transition*}
  \item{type}{type of correction: "c", "r", or missing (only required for lonlat, see below)}  
  \item{...}{multpl: matrix with correction factor (TRUE) or corrected values (FALSE, the default); scl: scale the correction values (default is FALSE)}
}
\details{
Geographic correction is necessary for all objects of the class Transition that are either:
(1) based on a grid in a geographic (lonlat) projection and covering a large area; 
(2) made with directions > 4.

The function will correct for map distortion, as well as for diagonal connections between grid cells (which cover a longer distance than vertical or horizontal connections).

When working with lonlat grids, users should also anticipate whether they will use methods based on either least-cost or random walks, and set the \code{type} argument accordingly. In the case of least-cost distances, the correction is only done in East-West direction. In the case of random walks there should be an additional correction which reduces the conductance in North-South direction (\code{type="r"}).

The correction is done by dividing conductance values by the inter-cell distance. Distances are calculated as great-circle distances for lonlat grids (see function isLonLat()) and Euclidean distances for all other grids.

In the case of randomised shortest paths, the need for correction is somewhat in between these two correction methods. We have not developed an analytical solution for this problem yet. With very low values for theta, you may choose the correction for random walks, and for high values the one for least-cost paths. Users who want to work with intermediate values of theta are encouraged to experiment with different solutions. 

The values are scaled to get values near 1 if the argument \code{scl} is set to TRUE. This is desirable for subsequent calculations involving random walk calculations. Values are divided by the W-E inter-cell distance (at the centre of the grid).

}
\value{
  Transition* object
}
\author{ Jacob van Etten \email{jacobvanetten@yahoo.com} }
\examples{
r <- raster(ncol=36,nrow=18)
r <- setValues(r,rep(1,times=ncell(r)))
tr <- transition(r, mean, directions=8)

#directly
tr1 <- geoCorrection(tr, type="c", multpl=FALSE)

#the same, but with a separate correction matrix
trCorr <- geoCorrection(tr, type="c", multpl=TRUE)
tr2 <- tr * trCorr
}
\keyword{methods}
\keyword{spatial}