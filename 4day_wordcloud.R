#wordcloud

#패키지 준비
install.packages("wordcloud")
library(wordcloud)

library(RColorBrewer)

#단어 색상 목록 만들기
pal <- brewer.pal(8,'Dark2') #dark2라는 목록에서 8개 색상 가져오기

#워드클라우드 생성
set.seed(1234) #난수고정
#단어,
#빈도,
#최소 단어 빈도
#표현 단어수
#고빈도 단어 중앙 배치
#회전 단어 비율
#단어크기 범위
#색상 목록
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per =.1,
          scale = c(4,0.3),
          colors = pal)

#단어 색상 바꾸기
pal <- brewer.pal(9,"Blues")[5:9]
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per =.1,
          scale = c(4,0.3),
          colors = pal)


#국정원 트윗 텍스트 마이닝
#데이터로드
twitter <- read.csv("./Data/twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")
#변수명 수정
twitter <-rename(twitter,
                 no = 번호,
                 id = 계정이름,
                 date = 작성일,
                 tw = 내용)

#특수문자 제거 - 한글쪽 오류
#twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

twitter

#word count
#명사 추출
nouns <- extractNoun(twitter$tw)
nouns

#리스트를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
wordcount

#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word

#변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word


#두 글자 이상 단어 추출
library(dplyr)
df_word <- filter(df_word, nchar(word) >=2)
df_word

#상위 20개 추출
top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top_20


#단어 빈도 막대그래프
library(ggplot2)
order <- arrange(top_20, freq)$word


ggplot(data = top_20, aes(x =word ,y =freq)) +
  ylim(0,2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +         
  geom_text(aes(label = freq), hjust = -0.3)

#워드 클라우드
pal <- brewer.pal(8,"Dark2")
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per =.1,
          scale = c(6,0.2),
          colors = pal)


#