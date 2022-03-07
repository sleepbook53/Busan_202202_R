setwd()
getwd()
install.packages("plotly")
library(plotly)


library(ggplot2)
install.packages("ggplot2")



install.packages("RJDBC")
library(RJDBC)
#오라클 드라이버 연결 경로 설정
driver<- JDBC("oracle.jdbc.OracleDriver",
               classPath = "C:/DEV/Tool/sqldeveloper-21.2.1.204.1703-x64/sqldeveloper/jdbc/lib/ojdbc8.jar")
driver

conn <- dbConnect(driver,
                  "jdbc:oracle:thin:@//localhost:1521/orcl",
                  "busan", "dbdb") #뭐를/ 주소를/ 아이디, 비밀번호
conn
#localhost = 127.0.0.1 = 컴퓨터내 고유 ip 주소
#port number : 오라클의 고유 주소(달라 질 수도 있음)

#데이터 넣기
#paste: 다 하나로 합쳐라 
#test의 AA, BB, CC,컬럼에 값을 넣어라

sql_in <- paste("Insert into test",
             "(AA, BB, CC)",
             "values('al', 'bl', 'cl')")
sql_in

in_stat = dbSendQuery(conn, sql_in)
in_stat

dbClearResult(in_stat) #종료

#데이터 조회
sql_sel <- "Select * From test Where AA = 'al'"
sql_sel

getData <- dbGetQuery(conn, sql_sel)
getData
getData$AA
str(getData)

