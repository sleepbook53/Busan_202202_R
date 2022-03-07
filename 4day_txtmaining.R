library(dplyr)
library(KoNLP)
useNIADic()#사전

#java 폴도 경로 설정(임시, 늘 꺼지면 다시 켜야함)
  #sys.setenv(JAVA_HOME = 경로)


text <- "R은 통계 계산과 그래픽을 위한 프로그래밍 언어이자 소프트웨어 환경이자 프리웨어이다.[2] 뉴질랜드 오클랜드 대학의 로버트 젠틀맨(Robert Gentleman)과 로스 이하카(Ross Ihaka)에 의해 시작되어 현재는 R 코어 팀이 개발하고 있다. R는 GPL 하에 배포되는 S 프로그래밍 언어의 구현으로 GNU S라고도 한다. R는 통계 소프트웨어 개발과 자료 분석에 널리 사용되고 있으며, 패키지 개발이 용이해 통계 소프트웨어 개발에 많이 쓰이고 있다"
extractNoun(text)

txt <- readLines("./Data/hiphop.txt", encoding = "UTF-8")
txt


#특수문자 제거
install.packages("stringr")
library(stringr)
txt <- str_replace_all(txt, "\\W", " ") #한글, 영문, 숫자를 제외한 나머지 공백
txt

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성

#가사에서 명사추출
nouns <- extractNoun(txt)
#추출한 명사 list를 문자열 벡터로, 변환, 다나어별 빈도표 생성
wordcount <- table(unlist(nouns))
head(wordcount)


#자주 사용된 단어 빈도표 만들기
#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)

#변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

#두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >=2) #단어가 두글자 있상이면 추출

#상위 20, 내림차순
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)
  
top_20

