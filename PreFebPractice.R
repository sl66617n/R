#   Figure 2.2: Bivariate normals
###pdf(file = "rmvnorm.pdf")
library(mvtnorm)
plot(rmvnorm(2000, mean = c(0,0), 
             sigma = matrix(c(1, -.8, -.8, 1), 2,2)),
     xlab = "x1", ylab = "x2", pch = 16, col = "red")
###dev.off()

########################################################

#  A simulation of the correlation coefficient

simcor <- function(ncor, nnor, rho)
  
  #  Simulate ncor random correlation coefficients based on nnor 
  #  pairs of bivariate normals with population correlation rho.
  # simcor=a list of recorded r12
  # rho=r12 
  # ncor=number of correlation 
  # nnor=number of items in each variable
{
  
  # Check validity of arguments:
  if( ncor < 1 || nnor < 2 || rho < -1 || rho > 1 )return(NA)
  library(mvtnorm)            # access library
  
  vm <- matrix(c(1, rho, rho, 1), 
               2, 2)          # variance matrix
  simcor <- NULL              # start a list of values
  for (i in 1 : ncor)         # For every simulated correlation: 
  {
    norv <- rmvnorm(nnor,   # generate normal pairs 
                    mean = c(0,0), sigma = vm )
    sc <-  cor(norv)[1, 2]  # correlation of these pairs
    simcor <- c(simcor, sc) # add to list of values
  }
  simcor                      # Done
}
hist(simcor(ncor=500, nnor=100, rho=0.8))
#########################################################
#  Figure 3.2 Boxplots
install.packages('boot')
library(boot)
data(cd4)
boxplot(cd4$baseline)
n <- length(cd4$baseline)                  # sample size
pdf(file = "boxplot.pdf")
op <- par(mfrow = c(1, 4), cex.lab = 1.5)  # four plots and large labels
plot(rep(.5, n), cd4$baseline, axes = FALSE, xlab = "Baseline", 
     xlim = c(0, 1), ylim = range(cd4), col = "red",
     ylab = "CD4 values", cex.lab = 1.5, cex = 2)    
plot(rep(.5, n), cd4$oneyear, axes = FALSE, xlab = "1 year", 
     xlim = c(0, 1), ylim = range(cd4), col = "red",
     yaxt = "n", ylab = "", cex.lab = 1.5, cex = 2) 
text(c(0, 1), c(0, 0), 
     c(boxplot(cd4$baseline, xlab = "Baseline", col = "red", 
               ylim = range(cd4),axes = FALSE),
       boxplot(cd4$oneyear, xlab = "1 year", col = "red",
               ylim = range(cd4), axes = FALSE)))
par(op)
dev.off()


##########################################################################

# Figure 3.5:  Jittered CD4 values and spaghetti

library(boot)                       # contains the cd4 dataset
data(cd4)
cd4 

### pdf("jittered.pdf")
n <- length(cd4$baseline)           # sample size
join <- c(cd4$baseline,cd4$oneyear) # concatenate all CD4 values
group <- rep(c(0, 1), each = n)     # assign group membership
par(mfrow = c(1, 3), cex.lab = 1.5)     # three side by side plots on one page
plot(group, join,                   # 1st plot with simple X axis
     ylab = "CD4 counts", cex.lab = 1.5, xlab = "", axes = FALSE, 
     ylim = c(0, max(join)), xlim = c(-.25, 1.25))
text(c(0, 1), c(1, 1), labels = c("Baseline", "1 year"), cex=1.5)

plot(jitter(group), join,           # 2nd plot with jittered X-axis
     ylab = "", xlab = "", axes = FALSE, 
     ylim = c(0, max(join)), xlim = c(-.25, 1.25))
text(c(0, 1), c(1, 1), labels = c("Baseline", "1 year"), cex = 1.5)

plot(group, join,                   # 3rd plot: spaghetti
     ylab = "", xlab = "", axes = FALSE, 
     ylim = c(0, max(join)), xlim = c(-.25, 1.25))
text(c(0, 1), c(1, 1), labels = c("Baseline", "1 year"), cex = 1.5)
for (i in 1 : n)                      # draw individual connecting lines
  lines(c(0, 1),c(cd4$baseline[i], cd4$oneyear[i]))
### dev.off()  # Close jittered.pdf


####################################################################
#                Section 3.3 Bivariate data 
####################################################################
#  Figure 3.7

# High data to ink ratio, fringes instead of axes 

# Illustrate plot options: pch=  cex=  and col=
install.packages('MVA')
library(MVA)
bvbox(house,xlab="Apt", ylab="House")
text(house$Apartment[exst],house$House[exst], labels=extreme)

housing <- read.table(file = "Housing.txt")
housing

### pdf(file = "house2.pdf")

require(graphics)                           # library for rug program
attach(housing)
boundA <- range(Apartment) * c(.95, 1)      # find bounds for plot area
boundH <- range(House) * c(.8, 1)

plot(housing, xlim = boundA, ylim = boundH, # Plot data with these bounds
     axes = FALSE, cex.lab = 1.5,            # Omit usual axes, larger font
     cex = 1.5, pch = 16,                    # Plot large, solid circles
     col = "red")                            # Select color of points
rug(Apartment, side = 1)                    # Add rug fringes instead of axes
rug(House, side = 2)

### dev.off()  # close house2.pdf

###############################################################################
# Figure 3.10: Convex hull and five layers of onion peeling

housing <- read.table(file = "Housing.txt")

### pdf(file = "chullheat.pdf")

library(aplpack)
nlev <- 5            # Number of levels
colors <- heat.colors(9)[3 : (nlev + 2)]
plothulls(housing, n.hull = nlev, col.hull = colors,
          xlab = "Apartment", ylab = "House", cex.lab = 1.5,
          lty.hull = 1 : nlev, density = NA, col = 0, main = "")
points(housing, pch = 16, cex = 1, col = "blue")

### dev.off()
#############################################################################

#  Figure 3.11:  Bubbleplot map of US 

### pdf(file="USbubblemap.pdf")

JanTemp <- read.table(file = "JanTemp.txt", header = TRUE)
require(MASS)
attach(JanTemp)
longe <- 180 - long                           # Reverse East and West

plot(longe,lat, pch = 16,  cex = .7,  cex.lab = 1.5,  # Plot dots at cities
     xlab = "Longitude, east", ylab = "Latitude", col = "red")                                 
with(JanTemp,symbols(longe,lat, circles = alt,   # Altitude sized circles
                     inches = .3, add = TRUE, lwd = 3, fg = "green"))
landmarks <- c( "AK", "HI", "MA", "PR")       # Four landmark states 
lmi <- match(landmarks, state) # identify landmark"s index in data
text(longe[lmi], lat[lmi], labels=landmarks,  # Identify landmarks
     pos=c(1, 1, 4, 3), col = "blue")

### dev.off()  #  close USbubblemap.pdf

############################################################################

#  Figure 3.12:  Kriging map of US altitudes

JanTemp <- read.table(file = "JanTemp.txt", header = TRUE)
JanTemp <- data.frame(JanTemp)

library(MASS)
library(spatial)
attach(JanTemp)

### pdf(file = "USKrig.pdf")
longe <- 180 - long                # Longitude, east
alt.kr <- surf.ls(4, longe, lat, alt) # Kriging surface
altsur <- trmat(alt.kr, 55, 110, 
                28, 50, 50)        # Set limits of plot, excluding outliers
eqscplot(altsur, xlab = "Longitude, east", cex.lab = 1.5,
         ylab = "Latitude",type = "n")    # plot in equal scale coordinates
contour(altsur, levels = c(0, 1000, 2000, 4000), add = TRUE, col = "blue") 
points(longe, lat, pch = 16, col = "red") # add original cities
ex <- c("Miami", "Seattle", "SanFrancisco", 
        "Denver", "Cheyenne")           # List of special cities 
exi <- match(ex, name)              # index for these cities
text(longe[exi], lat[exi], labels = ex, # label special cities
     pos = c(4, 3, 4, 4, 4), cex = 1)

### dev.off()




## convex hull (the smallest convex polygon containing all data)
chull(house)
ch =chull(house) # find indices of the convex hull
ch=c(ch,ch[1]) # loop back to the beginning
plot(house)
lines(house$Apartment[ch],house$House[ch], type="l")
#outer boundaries of the dataset



