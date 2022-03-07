#자료 불러오기
setwd("C:/Sources/Recture/Busan_202202_R/")
exam=read.csv('./Data/csv_exam.csv')

exam

library(dplyr)

#내림차순
exam %>% arrange(desc(math)) 

#class 및 math오름차순 정렬
exam %>% arrange(class,math) #앞에 것 중 같은거 다시 정렬

#mpg데이터를 이용해서 문석 문제 해결
#audi에서 생산한 자동차중에 어떤 자동차 모델의 hwy(고속도로 연비)가  높은지 확인
#audi에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터 출력

library(ggplot2)
mpg
str(mpg)

tmp = mpg %>% filter(manufacturer == "audi")
head(tmp %>%arrange(desc(hwy)), 5)

#tmp = mpg %>% filter(manufacturer == "audi") %>%
#arrange(desc(hwy)) %>%
#head(5)


#파생변수 추가하기 + 조회 , mutate 사용하기(저장이 되지 않음)
삽입하려면 <- 한번 더 해줘야함
tmp1 = exam
tmp1 %>%
  mutate(total= math + english + science,
        mean = (math + english + science)/3) %>%
    head #total: 새로 더하는 것

#mutate에 ifelse 적용하기
tmp1 %>% mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
    head

#mpg 데이터 복사본을 만들고 cty와 hwy를 더한 합산 연비 변수 추가
#앞에서 만든 '합산 연비 변수를 2로 나눠 평균연비변수를 추가
#평균연비 변수가 가장 높은 자동차 3종의 데이터 출력
#1-3의 문제를 해결할 수 있는 하나로 연결된 dplyr구문을 만들어 출력, 데이터는 복사본 이용

tmp2 = mpg
tmp2 <- tmp2 %>% mutate(ty = cty + hwy)
tmp2 <- tmp2 %>% mutate(tyr= ty/2) %>%
  head(3)

#한 번에 보기
tmp2 %>%
  mutate(ty = cty + hwy,
         tyr = ty/2) %>%
  arrange(desc(tyr)) %>%
  head(3)


#___________________________________________________

#집단별 요약
exam %>% summarise(mean_math = mean(math))

#class별로 분리/ math 평균 산출
exam %>%
    group_by(class)%>%
  summarise(mean_math = mean(math))

#여러 형태 요약
#class 별로 분리, math평균, math 합계, math 중앙값, 학생수(빈도)
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math =  sum(math),
            median_math = median(math),
            n = n())

#집단별로 다시 집단 나누기
#회사별, 구동방식별 분리 , cty 평균산출, 일부출력
mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

#회사별로 suv 자동차 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정리, 1~5위까지출력
mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(y = (cty + hwy)/2) %>%
  summarise(mean_y = mean(y)) %>%
  arrange(desc(mean_y)) %>%
  head(5)


#mpg 데이터의 class 는 'suv', compact'등 자동차를 특징에 따라 일곱 종류로 분류한 변수
  #어떤 차종의 연비가 높은지 비교, class별 cty 평균을 구하라
#앞 문제의 출력 결과는 class 값 앏파벳 순으로 정렬, cty평균 높은 순으로 출력
#어떤 자동차의 hwy가 가장 높은지 평균 높은 회사 세 곳 출력
#어떤 회사에서 compact차종을 가장 많이 생산하는지 알기위해 각 회사별 compact차종 수를 내림차순으로 출력

#차종별 도시연비평균
mpg %>%
  group_by(class) %>%
  summarise(y = mean(cty)) %>%
  arrange((desc(y)))

#hwy가 가장 높은 회사
mpg %>%
  group_by(manufacturer) %>%
 summarise(y = mean(hwy)) %>%
  arrange((desc(y))) %>%
  head(3)

#브랜드별 경차 생산 수
mpg %>%
  filter(class=="compact")%>%
  group_by(manufacturer) %>%
  summarise(n = n()) %>%
  arrange((desc(n)))
  

#___________________________________________



#데이터 합치기#

#데이터 생성
#중간고사 데이터생성
test1 = data.frame(id = c(1, 2,  3, 4, 5),
                   midterm = c(60, 80, 70, 90, 85))

#기말고사 데이터 생성
test2 = data.frame(id= c(1, 2,  3, 4, 5),
                   final = c(70, 83, 65, 95, 80))

#데이터 합치기 (id 기준으로 합쳐 total에 할당)
total = left_join(test1, test2, by = "id")
total


#다른 데이터 활용해 변수 추가
#반별 담임교사 명단 생성
name = data.frame(class = c(1, 2, 3, 4, 5),
                  teacher = c("kim", "lee", "park", "choi","jung"))
name

#class 기분 합치기
exam_new = left_join(exam, name, by = "class")
exam_new

#세로로 합치기
#데이터 생성
#학생 1~5반 시험 데이터 생성
 group_a = data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
 
 #학생 6~10번 시험 데이터 생성
 group_b = data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

 #세로로 합치기
 group_all = bind_rows(group_a, group_b)
 group_all

 
 
 #mpg 데이터의 f1 변수는 자동차에 사용하는 연료(fuel)를 의미, 아래는 자동차 연료별 가격표
 #연로와 가격으로 구성된 데이터 프레임으로 재구성
 fuel = data.frame(fl = c("c", "d", "e", "p", "f"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringAsFactors = F)
fuel 

#fuel 데이터를 이용해서 mpg 데이터에 price_f1변수 추가
#연료 가격변수 가 잘 추가 됐는지 확인하기 위해서 modle, fl, price_fl변수를 추출하여 앞부분 5행을출력

tmp = mpg
group_tmp = left_join(tmp, fuel, by= "fl")
group_tmp

group_tmp %>%
  select(model, fl, price_fl) %>%
  head(5)


#________________________________________________

#데이터 정제
#빠진 데이터, 이상한데이터 제거하기
#결측치 정제

#결측치 만들기
df= data.frame(sex = c("M", "F", NA, "M", "F"),
               score = c(5,4,3,4, NA))

df
#변수별로 결측치 확인하기
table(is.na(df$sex))

table(is.na(df$score))

#결측치 우선순위로, 결측치가 있으면 계산 집계를 하지 못할 수 있음


#결측치 있는 행 제거하기
library(dplyr)
df %>% filter(is.na(score)) #ㄴ책ㄷrk NA인 데이터값만 출력

df %>% filter(!is.na(score)) #score 결측치 제거

#결측치 제외한 데이터로 분석하기
df_nomiss = df %>% filter(!is.na(score))
mean(df_nomiss$score)

sum(df_nomiss$score)


#여러 변수 동식에 결측치 없는 데이터 추출
#score, sex 결측치 제거
df_nomiss = df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

#결측치가 하나라도 있으면 제거
df_nomiss2 = na.omit(df)
df_nomiss2

#일반적으로 컬럼 하나 단위로 제거
  #분석에 필요한 데이터 까지 손실될 가능성 유의

#함수의 결측치 제외 기능 이용하기 - na.rm = T
mean(df$score, na.rm = T) #결측치 제외하고 평균 산출출
sum(df$score, na.rm = T) #결측치를 제외하고 합계 산출출


#summarise에서 na.rm = T 사용하기

#결측치 생성
setwd("C:/Sources/Recture/Busan_202202_R/")
exam=read.csv('./Data/csv_exam.csv')

exam
exam[c(3, 8, 15), "math"] <- NA #3,8, 15, 행의 math에 NA 할당당

#평균구하기
exam %>% summarise(mean_math = mean(math))  #평균 산출

exam %>% summarise(mean_math = mean(math, na.rm =T)) #결측치 제외하고 평균 산출



#결측치 대체법
  #대표값(평균, 중앙값 등등)으로 일괄 대체
  #통계분석 기법 적용, 예측값 추정해서 대체


#평균으로 대체하기
exam$math = ifelse(is.na(exam$math), 55, exam$math) #math가NA면 55로 대체
table(is.na(exam$math)) #결측치 빈도로 생성


exam


#mpg데이터 원본에 결측치를 만들어 아래코드를 실행하면 다섯 행의 hwy 변수에 NA 할당
tmp = mpg
tmp[c(65, 124, 131, 153, 212), "hwy"] = NA #일일이 바꿔야 해서 보통 안씀

#drv 별로 hwy 평균이 어떻게 다른지 알아보려 함. 분석하기 전에 두 변수에 결측치 확인
#filter를 이용해 hwy변수의 결측치를 제외하고, 어떤 구동방식의 hwy 평균이 높은지 확인
table(is.na(tmp$drv))

table(is.na(tmp$hwy))

#결측치 제거/ drv별 분리 / hwy평균 구하기
tmp %>% 
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))


#____________________________________________
#이상치 정제
#outlier

#이상치 포함 데이터 생성
outlier = data.frame(sex = c(1,2,1,3,2,1),
                     score=c(5,4,3,4,2,6))
outlier

#이상치 확인
table(outlier$sex)
table(outlier$score)

#sex가 3이면 NA할당
outlier$sex = ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

#sex가 1~5아니면 NA할당 (core)
outlier$score = ifelse(outlier$score > 5 , NA, outlier$score)
outlier


#박스플롯으로 극단치 기준 정해서 제거
mpg = as.data.frame(ggplot2::mpg)
tmp = mpg

boxplot(tmp$hwy)

#boxplot(정규분포표를 세웠다고 생각 할 수 있음)

boxplot(tmp$hwy)$stats #통계치 출력

#결측처리하기
#12~31 벗어난 값을 NA로
tmp$hwy = ifelse(tmp$hwy <12 | tmp$hwy >37, NA, tmp$hwy)
table(is.na(tmp$hwy))                 

#제거
tmp %>%
  group_by(drv) %>%
  summarise((mean_hwy = mean(hwy, na.rm = T)))


#문제
  #drv에 이상치 k 할당
  #cty변수도 몇개의 행에 이상치 할당
tmp = mpg
tmp [c(10,14,58,93),"drv"] <- "k"
tmp[c(29,43,129,203),"cty"] = c(3, 4,39,42)

#구동방식별로 도시 연비가 다른지 분석 전, 두 변수의 이상치 확인
  #drv에 이상치가 있는지 확인, 이상치를 결측처리, 처리시 $in$ 활용
  #박스플롯으로 cty에 이상치가 있는지 확인, 이상치 결측 처리 후 확인
  #이상치를 제외, drv 별로 cty 평균이 어떻게 다른 지 확인

table(tmp$drv)
table(tmp$cty)

tmp$drv = ifelse(tmp$drv %in% c("4","f", "r"), tmp$drv , NA)
tmp$cty = ifelse(tmp$cty %in% c("3","4", "39", "42"), NA, tmp$cty)

boxplot(tmp$cty)$stats
tmp$cty <- ifelse(tmp$cty >26 | tmp$cty <9, NA, tmp$cty)

tmp %>%
  filter(!is.na(drv) & !is.na(cty))%>%
  group_by(drv) %>%
  summarise((mean_cty = mean(cty, na.rm =T)))

  