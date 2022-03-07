#파일 데이터 셋 자료 수집
gm <- read.csv("./Data/전라남도_목포시_장애인_복지시설_20210802.csv", header = T, fileEncoding = "EUC-KR")
gm

#Webcrawling
install.packages("rvest") #웹스크래핑 패키지
install.packages("stringr") #문자열 처리 패키지
library(rvest)
library(stringr)

url <- "https://www.bobaedream.co.kr/mycar/mycar_list.php?gubun=K&page=1"
url
#웹문서 가져오기
usedCar <- read_html(url)
usedCar

#특정 태그의 데이터 추출
#가져온 usedCar에서 css가 ".product-item"인 것을 ㅈ찾음
carInfos <- html_nodes(usedCar, css =".product-item")
head(carInfos)

