#���̵� ���� CREATE USER busan IDENTIFIED BY dbdb ;
#����� ������ ��й�ȣ ���� ALTER USER busan IDENTIFIED BY dbdb;
#����� ���� Drop User busan;
#���� �ο�(����, ������ ���)
GRANT CONNECT, RESOURCE,DBA TO busan;

#���� ȸ��
REVOKE DBA FROM busan;
