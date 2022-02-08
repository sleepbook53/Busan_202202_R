getwd()
setwd("C:/Sources/Recture/Busan_202202_R/")
exam=read.csv('./Data/csv_exam.csv')
View(exam) #d엑셀 처럼 확인
dim(exam) #차원 확인
str(exam) #데이터들의 타입확인
summary(exam) #int 되어있는 것들 한해서 통계를 냄

mpg = as.data.frame(ggplot2::mpg)
head(mpg, 10)
dim(mpg)
str(mpg)
summary(mpg)

install.packages("dplyr")
library(dplyr)

#데이터 생성
df_raw = data.frame(var1 =c(1, 2, 1),
                    var2 = c(2, 3, 2))
df_raw

#복사본 생성
df_new = df_raw
df_raw

#var2를 v2로 수정
df_new = rename(df_new, v2 = var2)
df_new

#데이터 생성
df=data.frame(var1 =c(3, 3,8),
               var2=c(2,6,1))
df
#va_sum 파생변수 생성
df$var_sum = df$var1 + df$var2
df       
df$var_sum = 10 #단순히 값만 넣어주면 그 값만 나옴

df$var_mean = (df$var1 + df$var2)/2
df

#파생변수 응용
mpg
mpg$total <- (mpg$cty + mpg$hwy)/2 #통합연비 변수 생성
head(mpg)
hist(mpg$total)
#20이상이면 pass, 아니면 fall
mpg$test = ifelse(mpg$total >= 20, "pass", "fall")
mpg$test

table(mpg$test) #데이터 집계

library(ggplot2)
qplot(mpg$test)

#total을 기준으로 A, B, C등급부여(등급 -> 범주)
mpg$grade = ifelse(mpg$total >= 30, "A",
                   ifelse(mpg$total>= 20, "B", "C"))
mpg$grade
table(mpg$grade)
qplot(mpg$grade)

midwest = as.data.frame(ggplot2::midwest)



#문제 1 ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하시오
head(midwest)
tail(midwest)
View(midwest)
str(midwest)
tail(midwest)
dim(midwest)
summary(midwest)

#문제2. poptotal(전체 인구)을 total로, popasian(아시아 인구)을 asian으로 변수명을 수정하세요

Mw= rename(midwest, total = poptotal, asian = popasian)

#문제3, total, asian 변수를 이용해 전체 인구 대비 아시아 인구 백분율 파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요
head(midwest1)
str(midwest1)
Mw$POPP = (Mw$asian)/(Mw$total) *100
hist(Mw$POPP)

#문제4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면, "lage", 그외에는 'small'을 부여하는 파생변수를 만들어라
Mw$mean =ifelse(Mw$POPP > mean(Mw$POPP), "lage", "small")
Mw$mean

#문제5 "lage"와 "small"에 해당하는 지역에 해당하는지 빈도표와 빈도 막대 그래프를 만들어 확인해보라
table(Mw$mean)

#-------------------------------------------
#자유자재로 데이터 가공하기
#전처리
#fiter() 행추출
#select()열(변수 추출)
#arange() 정렬
#mutate()변수추가
#summarise() 통계치 산출
#group_by() 집단별로 나누기
#left_join() 데이터 합치기(열)
#bind_rows() 데이터 합치기(행)



#전처리 해보기
exam
#exam에서 class가 1인 경우만 추출
exam %>% filter(class == 1) #%>% : ~ 중에서
#exam에서 class가 1이 아닌 모든 것 추출
exam %>% filter(class != 1) #%>% : ~ 중에서
#exam에서 조건 두개
exam %>% filter(class == 1 & math >=50) #& : and

#exam에서 조건 두개 / 또는
exam %>% filter(math >50 | english <50) #| : or

#exam에서 조건 복수 적용
exam %>% filter(class == 1 | class == 3| class==5) 


#%in% ~를 포함한 것 한꺼번에 추출
exam %>% filter(class %in% c(1,3,5))

#데이터 사용
class1 = exam %>% filter(class == 1)
class2 = exam %>% filter(class == 2)

#------------------
#논리 연산자
#기준점: 왼쪽
#+
#-
#*
#/
#^ / **
#%/% 나눗셈의 몫
#%% 나눗셈의 나머지

#displ이 4이하인 자동차와 5이상인 자동차 중 어떤 자동차의 hwy가 평균적으로 높은지
mpg
Dl1 = mpg %>% filter(displ<= 4)
mean(Dl1$hwy)

Dl2 = mpg %>% filter(displ=5)
mean(Dl2$hwy)



#필요한 변수만 추출하기
exam %>% select(math)
#제외하고 가져오기
exam %>% select(-math)

#여러 필터링
#class 가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>%
          select(english)

exam %>%
    select(id, math) %>%
  head #id, math 추출 한 것 중에 상위 6개만 추출
#파이썬에서는 앞뒤 위치가 바뀔 수 있음

#mpg중 calss, 와 cty를 추출해서 데이터프레임 생성 및 확인
newmpg = mpg %>%
    select(class, cty)
newmpg

#suv와 compact의 자동차 연비 찾기
n1 = newmpg %>%
    filter(class == "suv")
n2 = newmpg %>%
    filter(class == "compact")

mean(n1)
mean(n2)
