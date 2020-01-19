library("ggplot2")
x=c(15872,31744,63488,95232,126976)
y1=c(5148,6241,6929,7196,7270)
y2=c(5948,7570,8878,9381,9632)
y3=c(3325,4281,4921,5175,5322)
y4=c(3373,4350,5177,5525,5775)
DF <- data.frame(x, y1,y2,y3,y4)
DF
DF2 = data.frame(x, y2)
DF3 = data.frame(x, y3)
ggplot(DF, aes(x = x, y = y1)) + geom_point() +
  stat_smooth(method = 'lm', aes(colour = 'linear'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(colour = 'polynomial'), se= FALSE) +
  stat_smooth(method = 'nls', formula = y ~ a * log(x) +b, aes(colour = 'logarithmic'), se = FALSE, start = list(a=1,b=1)) +
  stat_smooth(method = 'nls', formula = y ~ a*exp(b *x), aes(colour = 'Exponential'), se = FALSE, start = list(a=1,b=1)) +
  theme_bw() +
  scale_colour_brewer(name = 'Trendline', palette = 'Set2')

ggplot(DF, aes(x = x, y = y1)) + geom_point() +
  stat_smooth(method = 'nls', formula = y ~ a * log(x) +b, aes(colour = 'logarithmic'), se = FALSE, start = list(a=1,b=1)) +
  theme_bw() +
  scale_colour_brewer(name = 'Trendline', palette = 'Set2')

ggplot(DF,aes(x = x)) +
  geom_point(aes(y = y1), )+
  stat_smooth(method = "rlm", formula = y~log(x), aes(x,y1, color = 'logarithmic'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(x,y1,colour = 'polynomial'), se= FALSE) +
  geom_line(aes(y = y1))  +
  geom_point(aes(y = y2),) +
  stat_smooth(method = "rlm", formula = y~log(x), aes(x,y2, color = 'logarithmic'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(x,y2,colour = 'polynomial'), se= FALSE) +
  geom_line(aes(y = y2)) + 
  geom_point(aes(y = y3)) +
  stat_smooth(method = "rlm", formula = y~log(x), aes(x,y3, color = 'logarithmic'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(x,y3,colour = 'polynomial'), se= FALSE) +
  geom_line(aes(y = y3)) +
  geom_point(aes(y = y4)) +
  stat_smooth(method = "rlm", formula = y~log(x), aes(x,y4, color = 'logarithmic'), se = FALSE) +
  stat_smooth(method = 'lm', formula = y ~ poly(x,2), aes(x,y4,colour = 'polynomial'), se= FALSE) +
  geom_line(aes(y = y4)) +
  theme_bw() +
  scale_colour_brewer(name = 'Trendline', palette = 'Set2')
