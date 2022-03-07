#Visualization

#산점도
ggplot2
install.packages("ggplot2")
library(ggplot2)

#배경설정
ggplot(data = mpg, aes(x = displ, y=hwy))

#배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y=hwy)) + geom_point()

#x축 범위 3~6 조정
ggplot(data = mpg, aes(x = displ, y=hwy)) + geom_point() + xlim(3,6)

#x축 범위 3~6, y축 10~30 조정
ggplot(data = mpg, aes(x = displ, y=hwy)) +
    geom_point() +
    xlim(3,6) +
    ylim(10,30)

#qplot 전처리 단계에서 데이터 확인용 문법
#ggplot 최종 보고용 색, 크기, 폰트 등 세부 조작 가능

#mpg데이터의 cty, hwy 간에 어떤 관계가 있는지 알아보고자함
  #x축은 cty, y축은 hwy로 된 산점도를 만들기
#미국 지역별 인구 통계 정보를 담은 ggplot2패키지의 midwest데이터를 이용해 전체 인구의 아시아인 인구간에 어떤 관계가 있는지 확인
#x축은 poptotal(전체인구), y축은 popasian(아시아인구)로된 산점도를 만들기
#전체 인구는 50만명 이하, 아이아인 인구는 1만명 이하인 지역만 산점도 표시


ggplot(data =mpg, aes(x=cty, y = hwy)) + geom_point()
tmp = midwest
str(tmp)
ggplot(data = tmp, aes(x =poptotal, y=popasian)) +
    geom_point() +
    xlim(0,500000) +
    ylim(0,10000)


#지수 표현 1e + 05 = 10만( 10의 5승)
#정수로 표현하기 options(scipen = 99) 실행후 그래프 생성
#지수로 표현하기 options(scipen = 0) 실행 후 그래프 생성


#막대그래프
#집단간의 차이 표현
library(dplyr)
str(mpg)
df_mpg =mpg
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

ggplot(data = df_mpg, aes(x=drv, y=mean_hwy)) +geom_col()

#크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()

#빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()


#고속도로 연비
ggplot(data  = mpg, aes(x = hwy)) + geom_bar()


#col(평균) vs bar(빈도)


#어떤 회사에서 생산한 suv차종의 도시연비가 높은지 확인
  #suv 차종을 대상으로 평균 cty가 가장 높은 회사 다섯 곳을 막대그래프로 표시
  #연비가 높은 순으로 표시
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty))
  
  
ggplot(data = df, aes( x=reorder(manufacturer, - mean_cty),
                      y=mean_cty )) +geom_col()


#자동차 중 어떤 class가 가장 많은지 확인, 자동차 종류별 빈도 표현막대그래프 
ggplot(data =mpg, aes(x = class)) + geom_bar()
