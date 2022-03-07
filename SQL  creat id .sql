#아이디 생성 CREATE USER busan IDENTIFIED BY dbdb ;
#사용자 생성자 비밀번호 변경 ALTER USER busan IDENTIFIED BY dbdb;
#사용자 삭제 Drop User busan;
#권한 부여(접속, 관리자 모두)
GRANT CONNECT, RESOURCE,DBA TO busan;

#권한 회수
REVOKE DBA FROM busan;
