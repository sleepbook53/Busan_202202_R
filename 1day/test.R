english = c(90, 80, 60, 70)
english
#[1] 90 80 60 70

class=c(1,1,2,2)
math=c(80, 60, 70, 1)

df_midterm = data.frame(english, math, class)
#data.frame: .을 기준으로 왼쪽은 클래스, 오른쪽은 함수
df_midterm

#평균값
mean(df_midterm$english)
mean(df_midterm$math)

#txt읽을 수 있는 패키지
install.packages("readxl")
library(readxl)

#디렉토리 경로 설정
getwd() #작업 파일 경로확인
setwd("C:/Sources/Recture/Busan_202202_R/1day") #임의의 경로 지정

#엑셀 파일을 불러와서 df_exam에 할당
df_exam = read_excel("C:/Sources/Recture/Busan_202202_R/Data/excel_exam.xlsx")
df_exam
mean(df_exam$english)#활용

#상대 경로 vs 절대경로
#상대경로: 현재 위치의 경로(디렉토리 설정)
#절대 경로: 직접 설정한 경로


#col_names = T/F: 컬럼명이 있다/없다
df_exam_nover = read_excel("C:/Sources/Recture/Busan_202202_R/Data/excel_exam_novar.xlsx", col_names = F)
df_exam_nover

#복수의 엑셀시트에서 특정 시트의 데이터값을 가져오려 할 때
df_examsheet = read_excel("C:/Sources/Recture/Busan_202202_R/Data/excel_exam_sheet.xlsx", sheet = 3)
df_examsheet

#데이터 프레임을 파일로 저장하기
df_midterm
write.csv(df_midterm,"C:/Sources/Recture/Busan_202202_R/Data/df_midterm")

