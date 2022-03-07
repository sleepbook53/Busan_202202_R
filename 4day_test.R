#데이터 분석
library(dplyr)
library(ggplot2)

install.packages('stringi')
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

str(changeCode(korpop1))

korpop1_temp <- korpop1
head(korpop1_temp)
View(changeCode(korpop1))
dim(korpop1_temp)
summary(korpop1_temp)



#2015년. 시도별 성별과 외내국인, 가구형태 및 주거형태에 대한 데이터
#총 인구대비 남녀의 비율

pop <- korpop1 %>%
    summarise(mean_pop = mean(총인구_명),
              mean_male = mean(남자_명),
              mean_fmale = mean(여자_명))
  
pop
