library(dplyr)
library(wordcloud2)
# install.packages("wordcloud2")

text = readLines("C:\\Users\\dushiyi\\Desktop\\Thereisatxt.txt")
txt = text[text!=""]
txt = tolower(txt)
txtList = lapply(txt, strsplit, " ")
txtChar = unlist(txtList)
txtChar = gsub("\\.|,|\\!|:|;|\\?|-|\\'", "", txtChar)
txtChar = txtChar[txtChar!=""]
data = as.data.frame(table(txtChar))
colnames(data) = c("Word","freq")
ordFreq = data[order(data$freq,decreasing = T),]

# filter the meaningless words
filePath= "C:\\Users\\dushiyi\\Desktop\\common_work.txt"
df = read.table(filePath, header = T)
Word = dplyr::select(df,Word)
antiWord = data.frame(Word, stringsAsFactors = F)
result = anti_join(ordFreq,antiWord,by="Word") %>% arrange(desc(freq))
result = result[1:50,]
wordcloud2(result)

