R Graphics Cookbook

# 2.5
# use plot() and pass it a factor of x values and a vector of y values. when x is a factor (as opposed to a numeric vector), it will automatically create a box plot:
plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len~supp, data = ToothGrowth)
boxplot(len ~ supp + dose, data = ToothGrowth)

qplot(ToothGrowth$supp, ToothGrowth$len, geom = "boxplot")
# using three separate vectors
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom = "boxplot")
# Alternatively, get the columns from the data frame
ggplot(ToothGrowth, aes(x=supp, y=len)) +geom_boxplot()
# this is equivalent to:
ggplot(ToothGrowth, aes(x=interaction(supp, dose), y=len)) + geom_boxplot()


# 2.6. Plotting a Function Curve.
# to plot a function curve, use curve() and pass it an expression with the variable x:
curve(x^3 - 5**x, from = -4, to = 4)
# you can plot any function that takes a numeric vector as input and returns a numeric vector, 
# including functions that you define yourself. Using add=TRUE will add a curve to the previously created plot:
# plot a user-defined function
myfun = function(xvar){
  1/(1 + exp(-xvar + 10))
}
curve(myfun(x), from = 0, to = 20)
# add a line
curve(1-myfun(x),add = TRUE, col = "red")

# with ggplot2 package, you can get a similar result using qplot(), by using stat="function" and geom="line" and passing it
# a function that takes a numeric vector as input and returns a numreic vector:
# library(ggplot2)
qplot(c(0,20), fun=myfun, stat="function", geom = "line") # not true.
ggplot(data.frame(x=c(0, 20)), aes(x=x)) + stat_function(fun=myfun, geom = "line")

# Chapter 3 
# Bar Braphs
# there is an inportant distinction you should be aware of when making bar graphs: sometimes the bar heights represent counts of cases in the data set, and sometimes
# they represent values in the data set. Keep this distinction in mind-- it can be a source of confusion since they have very different relationships to the data, but 
# the same term is used for both of them.

# 3.1 making a basic bar graph
library(gcookbook)
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity")

BOD
# when x is a continuous variable, the bars behave a little differently.
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")

# Convert Time to a dicrete (categorical) variable with factor()
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat="identity")
data = data.frame(
  ID = c(0,1,2,3,4,5),
  Gender = c('male','female','male','female','male','female'),
  Height = c(178,156,170,158,168,155)
)

ggplot(data, aes(x=interaction(ID, Gender), y=Height)) + geom_point(stat = "identity")
ggplot(data, aes(x=interaction(ID, Gender), y=Height)) + geom_boxplot()

# 
# 3.2 Grouping Bars together
library(gcookbook)
cabbage_exp
ggplot(cabbage_exp, aes(x=Date,y = Weight, fill=Cultivar)) + geom_bar(position = "dodge",stat = "identity")


# to add a black outline, use colour = "black" inside geom_bar(). To set the colors, you can use
# scale_fill_brewer() or scale_fill_manual().
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat = "identity", position = "dodge", colour="black") + scale_fill_brewer(palette = "Pastel1")
# The most basic bar graphs have one categorical variable on the x-axis and one continuous variable on the y-axis.
# Sometimes you'll want to use another categorical variable to divide up the data, in addition to the variable on the x-axis.
ce = cabbage_exp[1:5,]
ce
ggplot(ce, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat = "identity", position="dodge", colour = "black") + scale_fill_brewer(palette = "Pastel1")


#
# 3.3 making a Bar graph of counts.
# your data has one row representing each case, and you want plot counts of the cases.

ggplot(diamonds, aes(x=cut)) + geom_bar()
# Equivalent to using geom_bar(stat="bin")
# discussion
# With geom_bar(),the default behavior is to use stat="bin", which counts up the number of cases for each group(each x position)
# continuous variable on the x-axis,we will get a histogram
ggplot(diamonds, aes(x=carat)) + geom_bar()
ggplot(diamonds, aes(x=carat)) + geom_histogram()


#
# 3.4 using Colors in a Bar Graph
# you want to use different colors for the bars in your graph.
# map the appropriate variable to the fill aesthetic.
library(gcookbook)
# take the top 10 states:
upc = subset(uspopchange, rank(Change)>40)
upc
ggplot(upc, aes(x=Abb, y=Change, fill=Region)) + geom_bar(stat="identity")
# the default colours aren't very appealing, so you may want to set them, using scale_fill_brewer() or scale_fill_manual().
# we'll use the latter, and we'll set the outline color of the bars to black, with colour="black".
# Note that setting occurs outside of aes(), while mapping occurs within aes():
ggplot(upc, aes(x=reorder(Abb, Change),y=Change, fill=Region)) + geom_bar(stat="identity", colour="black") +
  scale_fill_manual(values = c("#669933", "#FFCC66")) + xlab("State")
# reorder()function, as in this particular case it makes sense to sort the bars by their height, instead of in alphabetical order.


# 
# 3.5 coloring Negative and positive bars differently
# we'll use a subset of the climate data and create a new column called pos, which indicates whether the value is positive or negative:
library(gcookbook)
csub = subset(climate, Source=="Berkeley" & Year >=1900)
csub$pos = csub$Anomaly10y >=0
csub
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) + geom_bar(stat="identity", position = "identity")
# there are a few problems with the first attempt. First, the colors are probably the reverse of what we want:
# usually, bule means cold and red means hot. Second, the legend is redundant and distracting.
# we can change the colours with scale_fill_manual() and remove the legend with guide=FALSE.
# we also add a thin black outline around each of the bars by setting colour and specifying size, which is thickness of the
# outline, in millimetrs:
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) + geom_bar(stat="identity", position="identity", colour = "black", size=0.25)+
  scale_fill_manual(values = c("#CCEEFF","#FFDDDD"), guide=FALSE)


#
# 3.6 Adjusting Bar Width and Spacing
# to make the bars narrower or wider, set width in geom_bar(). The default value is 0.9; larger values make the bars wider, 
# and smaller values make the bars narrower
library(gcookbook)
pg_mean
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity")
# for narrower bars:
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity", width = 0.5)
# for wider bars:(these have the maximum width of 1)
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat="identity", width = 1)

# for grouped bars, the default is to have no space between bars within each group. To add space between bars within a group,
# make width smaller and set the value for position_dodge to be larger than width.
# for a grouped bar graph with narrow bars:
cabbage_exp
ggplot(cabbage_exp,aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat="identity", width = 0.5, position="dodge")
# and with some space between the bars:
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat="identity", width = 0.5, position = position_dodge(0.7))
# The first graph used position="dodge", and the second graph used position=position_dodge(). This is because 
# position="dodge" is simply shorthand for position=position_dodge() with the default value of 0.9, but when we want to set a 
# specific value, we need to use the more verbose command.

# all of these will have the same result:
geom_bar(position = "dodge")
geom_bar(width = 0.9, position = position_dodge())
geom_bar(position = position_dodge(0.9))
geom_bar(width = 0.9, position = position_dodge(width = 0.9))


# 
# 3.7 making a stacked bar graph
# use geom_bar() and map a variable fill. This will put Date on the x-axis and use Cultivar for the fill color,
library(gcookbook)
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat="identity")
# one problem with the default output is that the stacking order is the opposite of the order of items in the legend.
# you can reverse the order of items in the legend by using guides() and specifying the aesthetic for which the legend should
#be reverse. 
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +  geom_bar(stat = "identity") + guides(fill=guide_legend(reverse = T))
# if you would like to reverse the stacking order, specify order=desc() in the aesthetic mapping:
library(plyr)
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar,order=desc(Cultivar))) + geom_bar(stat = "identity") 

# for a more polished graph, we'll keep the reversed legend order, use scale_fill_brewer() to get a different color palette
# and use colour="black" to get a black outline
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat = "identity", colour="black") +
  guides(fill=guide_legend(reverse = TRUE))+
  scale_fill_brewer(palette = "Pastel1")


# 
# 3.8 making a proportional stacked bar graph
# first,scale the data to 100% within each stack. This can be done by using ddply() from the plyr package, with transform().
#Then plot the resulting data
library(gcookbook)
library(plyr)
# Do a group-wise transform(),splitting on "Date"
ce = ddply(cabbage_exp, "Date", transform, percent_weight = Weight/sum(Weight)*100)
ce
cabbage_exp
ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) + geom_bar(stat = "identity")
# as with regular stacked bar graphs, it makes sense to reverse the legend order, change the color palette, and add an outline.
ggplot(ce, aes(x=Date, y=percent_weight, fill=Cultivar)) + geom_bar(stat="identity",colour="black")+
  guides(fill=guide_legend(reverse = TRUE)) +
  scale_fill_brewer(palette = "Pastel1")


# 
# 3.9 adding labels to a bar graph
# add geom_text() to your graph. it requires a mapping for x, y, and the text itself. By setting vjust(the vertical justification),
# it is possible to move the text above or below the tops of the bars,
library(gcookbook)
# Below the top
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight),vjust=1.5, colour="white")

# Above the top
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight),vjust=-0.2)

# adjust y limits to be a little higher
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=Weight),vjust=-0.2) +
  ylim(0, max(cabbage_exp$Weight) * 1.05)

# map y positions slightly above bar top - y range of plot will auto-adjust
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) + 
  geom_bar(stat="identity") +
  geom_text(aes(y=Weight+0.1,label=Weight))
# ...


#
# 3.10 making a cleveland dot plot
# Cleveland dot plots are sometimes used instead of bar graphs because they reduce visual clutter and are easier to read.
library(gcookbook)
tophit = tophitters2001[1:25,]
tophit
ggplot(tophit, aes(x=avg, y=name)) + geom_point()

tophit[, c("name", "lg", "avg")]
# Although the rows of the tophit happen to be sorted by avg, that doesn't mean that the items will be ordered that way in the graph. 
# By default, the items on the given axis will be ordered however is appropriate for the data type. name is a character vector, so
# it's ordered alphabetically. If it were a factor, it would use the order defined in the factor levels. In this case, we want name to
# be sorted by a different variable, avg.

ggplot(tophit, aes(x=avg, y=reorder(name, avg))) +
  geom_point(size=3) +
  theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed"))
  
# it's also possible to swap the axes so that the names go along the x-axis and the values go along the y-axis. We'll also rotate
# the text labels by 60 degrees:
ggplot(tophit, aes(x=reorder(name, avg), y=avg)) + geom_point(size=3) +
  theme_bw() +
  theme(axis.text.x = element_text(angle=60, hjust = 1),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_line(colour="grey60", linetype = "dashed"))

# This tiem we want to sort first by lg and then by avg. Unfortunately, the reorder() function will only order factor levels by
# one other variable; to order the factor levels by two variables, we must do it manually:
  # get the names, sorted first by lg, then by avg
nameorder = tophit$name[order(tophit$lg, tophit$avg)]
nameorder
  # turn name into a factor, with levels in the order of nameorder
tophit$name = factor(tophit$name, levels=nameorder)
tophit$name
ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, colour="grey50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_color_brewer(palette="Set1", limits=c("NL", "AL")) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank(),
       legend.position=c(1, 0.55),
       legend.justification=c(1, 0.5))

# Another way to separate the two group is to use facets, The order in which the facets are displayed is different from the sorting
# order; to change the display order, you must change the order of factor levels in the lg variable:
ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, colour="grey50") +
  geom_point(size=3, aes(colour=lg)) +
  scale_colour_brewer(palette="Set1", limits=c("NL", "AL"),guide=FALSE)+
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales = "free_y", space = "free_y")


# 
# chapter 4 
# 4.1 making a Basic line Graph
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() +ylim(0, max(BOD$demand))
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + expand_limits(y=0)

# 4.2 adding points to a line graph
library(gcookbook)
ggplot(worldpop, aes(x=Year, y=Population)) + geom_line() + geom_point()
# same with a log y-axis
ggplot(worldpop, aes(x=Year, y=Population)) + geom_line() + geom_point() + scale_y_log10()


# 
# 4.3 making a line graph with multiple lines
# in addition to the variables mapped to the x-and y-axes, map another(discrete) variable to colour or linetype.
# load plyr so we can use ddply() to create the example data set
library(plyr)
# summarize the ToothGrowth data
tg = ddply(ToothGrowth, c("supp", "dose"), summarise, length=mean(len))
# map supp to colour
ggplot(tg, aes(x=dose, y=length,colour=supp)) + geom_line()
# map supp to linetype
ggplot(tg, aes(x=dose, y=length,linetype=supp)) + geom_line()

ToothGrowth
tg
# line graphs can be used with a continuous or categorical variable on the x-axis. Sometimes the Variable mapped to the x-axis is 
# conceived of as being categorical, even when it's stored as a number.
# convert dose to a factor
ggplot(tg, aes(x=factor(dose), y = length, colour=supp, group=supp)) + geom_line()
# Notice the use of group=supp. without this statement, ggplot() won't know how to group the data together to draw the lines, and it will give
# an error.
ggplot(tg, aes(x=factor(dose), y=length, colour=supp)) + geom_line()
# Another common problem when the incorrect grouping is used is that you will see a jagged sawtooth pattern:
ggplot(tg, aes(x=dose, y=length)) + geom_line()
# this happens because there are multiple data points at each y location, and ggplot() thinks  they're all in one group. The points 
# for each group are connected with a single line, leading to the sarthooth pattern. If any discrete variables are mapped to aesthetics
# like colour or linetype, they are automatically used as grouping vriables. But if you want to use other variables for grouping(that aren't
# mapped to an aesthetic), they should be used with a group.

# if your plot has points along with the lines, you can also map variables to properties of the points, such as shape and fill.
ggplot(tg, aes(x=dose, y=length, shape=supp)) + geom_line() + geom_point(size=4)
ggplot(tg, aes(x=dose, y=length, fill=supp)) + geom_line() + geom_point(size=4, shape=21) # Also use a point with a color fill

# sometimes points will overlap. In these cases, you may want to dodge them, which means their positions will be adjusted left and right.
# when doing so, you must also dodge the lines, or else only the points will move and they will be misaligned. you must alse specify how far
# they shoud move when dodged:
ggplot(tg, aes(x=dose, y=length, shape=supp)) + geom_line(position = position_dodge(0.2)) +geom_point(position = position_dodge(0.2),size=4)


# 
# 4.4 changing the appearance of lines
# the type of line(solid, dashed, dotted, etc.) is set with linetype, the thickness(in mm) with size, and the color of the line with colour.
# these properties can be set by passing them values in the call to geom_line():
ggplot(BOD, aes(x=Time, y=demand)) + geom_line(linetype="dashed",size=1,colour="blue")

# If there is more than one line, setting the aesthetic properties will affect all of the lines.
# On the other hand, mapping variables to the properties, The default colors aren't the most appealing, so you may want to use a different
# palette, by using scale_colour_brewer() or scale_colour_manual():
# load plyr so we can use ddply() to create the example data set
library(plyr)
# Summarize the ToothGrowth data
tg = ddply(ToothGrowth, c("supp", "dose"), summarise, length=mean(len))
ggplot(tg, aes(x=dose, y=length, colour=supp)) + geom_line() +scale_color_brewer(palette = "Set1")

# to set a single constant color for all the lines, specify colour outside of aes(). The same works for size, linetype, and point shape.
# you may also have to specify the grouping variable:
## If both lines have the same properties, you need to specify a variable to use for grouping
ggplot(tg, aes(x=dose, y=length, group=supp)) + geom_line(colour="darkgreen", size=1.5)
## Since supp is mapped to colour, it will automatically be used for grouping
ggplot(tg, aes(x=dose, y=length, colour=supp)) + geom_line(linetype="dashed") + geom_point(shape=22, size=3, fill="white")
ggplot(tg, aes(x=dose, y=length, colour=supp)) + geom_line(linetype="dashed") + geom_point(shape=tg$supp, size=3, fill="white")


# 
# 4.5 changing the appearance of points
# In geom_point(), set the size, shape, colour, and/or fill outside of aes()
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() + geom_point(size=4, shape=22, colour="darkred", fill="pink")
# discussion
# the default shape for points is a solid circle, the default size is 2, and the default colour is "black". the fill color is relevant
# only for some point shapes, which have separate outline and fill colors. the fill color is typically NA, or empty; you can fill it 
# with white get hollow-looking circles:
ggplot(BOD, aes(x=Time, y=demand)) + geom_line() +
  geom_point(size=4, shape=21, fill="white")
# if the points and lines have different colors, you should specify the points after the lines, so that they are drawn on top.
# Otherwise, the lines will drawn on the top of the points.

# For multiple lines, how to draw differently colored points for each group by mapping variables to aesthetic properties of points, 
# inside of aes(). The default colors are not very appealing, so you may want to use a different palette, using scale_colour_brewer()
# or scale_colour_manual(). To set a single constant shape or size for all the points, specify shape or size outside of aes():

library(plyr)
tg = ddply(ToothGrowth, c("supp", "dose"), summarise, length=mean(len))
pd = position_dodge(0.2)
ggplot(tg, aes(x=dose, y=length, fill=supp)) + 
  geom_line(position=pd) +
  geom_point(shape=21, size=3, position=pd) +
  scale_fill_manual(values = c("black", "white"))


# 
# 4.6 making a graph with a shaded area
# Use geom_area() to get a shaded area
## Convert the sunspot.year data set into a data frame for this example
sunspotyear = data.frame(
  Year = as.numeric(time(sunspot.year)),
  Sunspots = as.numeric(sunspot.year)
)
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) + geom_area()
# by default, the area will be filled with a very dark grey and will have no outline. the color can be changed by setting fill. 
# in the following example, we'll set it to "blue", and we'll also make it 80% transparent by setting alpha to 0.2. This makes it
# possible to see the grid lines through the area, we'll also add an outline, by setting colour:
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(colour="black", fill="blue", alpha=.2)

# Having an outline around the entire area might not be desirable, because it puts a vertical line at eht beginning and end of the
# shaded area, as well as one along the bottom. To avoid this issue, we can draw the area without an outline, and then layer a geom_line()
# on top:
ggplot(sunspotyear, aes(x=Year, y=Sunspots)) + 
  geom_area(fill="blue", alpha=.2) +
  geom_line()

#
# 4.7 making a stacked area graph
library(gcookbook)
uspopage
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) + geom_area()
# the default order of legend items is the opposite of the stacking order. The legend can be reversed by setting the breaks in the scale.
# reverse the legend order, changes the palette to a range of blues, and adds thin (size=.2) lines between each area. It also makes the 
# filled areas semitransparent (alpha=.4), so that it is possible to see the grid lines through them:
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(colour="black", size=.2, alpha=.4) + 
  scale_fill_brewer(palette="Blues", breaks=rev(levels(uspopage$AgeGroup)))
# to reverse the stacking order, we'll put order=desc(AgeGroup) inside of aes()
library(plyr)
ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) + 
  geom_area(colour="black", size=.2, alpha=.4) +
  scale_fill_brewer(palette="Blues")

# Since each filled area is drawn with a polygon, the outline includes the left and right sides. This might be distracting or
# misleading. to get rid of it, first draw the stacked areas without an outline(by leaving colour as the default NA value), and then
# add a geom_line() on top:
ggplot(uspopage,aes(x=Year, y=Thousands, fill=AgeGroup, order=desc(AgeGroup))) +
  geom_area(colour=NA, alpha=.4) +
  scale_fill_brewer(palette="Blues") + 
  geom_line(position="stack", size=.2)


#
# 4.8 making a proportional Stacked area graph
# first, calculate the proportions. use ddply() to break uspopage into groups by Year, then calculate a new column, Percent, This value is 
# the Thousands for each row, divided by the sum of Thousands for each Year group, multiplied by 100 to get a percent value:
library(gcookbook)
library(plyr)
uspopage_prop = ddply(uspopage, "Year", transform, Percent = Thousands/sum(Thousands)*100)
ggplot(uspopage_prop, aes(x=Year, y=Percent, fill=AgeGroup)) +
  geom_area(colour="black", size=.2, alpha = .4) +
  scale_fill_brewer(palette = "Blues", breaks=rev(levels(uspopage$AgeGroup)))


# 
# 4.9 adding a confidence Region
library(gcookbook)
clim = subset(climate, Source == "Berkeley", select = c("Year", "Anomaly10y", "Unc10y"))
clim
climate
ggplot(clim, aes(x=Year, y=Anomaly10y)) +
  geom_ribbon(aes(ymin=Anomaly10y-Unc10y,ymax=Anomaly10y+Unc10y), alpha=0.2) +
  geom_line()
# the shaded region is actually a very dark grey, but it is mostly transparent. The transparency is set with alpha=0.2, which makes
# it 80% transparent.

# Notice that the geom_ribbon() is before geom_line(), so that the line is drawn on top of the shaded region. If the reverse order 
# were used, the shaded region could obscure the line. In this particular case that wouldn't be a problem since the shaded region is
# mostly transparent, but it would be a problem if the shaded region were opaque.

# Instead of a shaded region, you can also use dotted lines to represent the upper and lower bounds
ggplot(clim, aes(x=Year, y=Anomaly10y)) + 
  geom_line(aes(y=Anomaly10y-Unc10y), colour="grey50", linetype="dotted") +
  geom_line(aes(y=Anomaly10y+Unc10y), colour="grey50", linetype="dotted") +
  geom_line()
  