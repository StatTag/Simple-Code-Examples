
attach(cars)

## show the data
##>>>ST:Table(Label="Show Data", Frequency="Always", Type="Default")
head(cars,n=10)
##<<<

## number of observations
##>>>ST:Value(Label="Num Obs", Frequency="Always", Type="Default")
nrow(cars)
##<<<

## the average speed
##>>>ST:Value(Label="Average Speed", Frequency="Always", Type="Default")
mean(cars$speed)
##<<<

##>>>ST:Value(Label="var", Frequency="Always", Type="Numeric", Decimals=2, Thousands=False)
var(cars$speed)
##<<<

## a plot looking at the relationship between speed and stopping distance
## will store plot in the user's working directory for R
##>>>ST:Figure(Label="Speed by Distance", Frequency="Always")
pdf(paste(getwd(), "/StatTag R plot.pdf", sep = ""), height = 5, width = 5)
plot(speed, dist, xlab = "Speed (mph)", ylab = "Stopping distance (ft)", las = 1)
dev.off()
##<<<

## a model for the linear relationship between distance and speed
model <- lm(dist ~ speed, data = cars)

summary(model)
##>>>ST:Verbatim(Label="Regression Model", Frequency="Always")
print(summary(model))
##<<<
