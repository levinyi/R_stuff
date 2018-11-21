xz = c(2,4,6,7,9)
yz = c(11,13,14,15)
plot(xz,yz)
lines(lowess(xz,yz))
