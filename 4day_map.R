#미국 주별 강력 범죄율 단계 구분도 만들기
install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)
head(USArrests)

library(tibble)
#행 이름을 state 변수로 바꿔 데이터 프레임생성
crime <- rownames_to_column(USArrests,var = "state")

#지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)

str(crime)


#미국 주 지도 데이터 준비하기
library(ggplot2)
state_map <- map_data("state")
str(state_map)


#단계 구분도 만들기
  #지도에 표현할 데이터
  #색깔로 표현할 변수
  #지역 기준 변수
  #지도데이터
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map)

#인터렉티브 단계 구분도(좀 더 깔끔해짐)
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map,
            interactive = T)


#_________________________________-
#대한민국 시도별 인구 단계 구분도 만들기
install.packages('stringi')
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")

library(kormaps2014)

str(changeCode(korpop1))

korpop1_temp <- korpop1
head(korpop1_temp)
#kormpas2014 데이터는 UTF-8 인코딩으로 그대로 사용하면 오류남
#-changeCode()함수를 사용하여 인코딩을 Cp949로 변환해주어야함

library(dplyr)
korpop1_temp <- rename(korpop1_temp,
                       pop = 총인구_명,
                       name = 행정구역별_읍면동)


str(changeCode(korpop1_temp))
str(changeCode(kormap1))

#단계 구분도 만들기
ggChoropleth(data = korpop1_temp,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)


#시도별 결핵 환자 수 단계 구분도 만들기
str(changeCode(tbc))
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)

#대한민국 시도별 결핵 환자 수 단게 구분도 만들기
str(changeCode(tbc))


