CREATE USER ADMIN IDENTIFIED BY 123456;
CREATE SCHEMA AUTHORIZATION MY_SCHEMA;
GRANT CONNECT, RESOURCE, DBA TO ADMIN;
CREATE TABLESPACE TS_01 DATAFILE '/scripts/tablespace/ts_01.dbf' SIZE 50M
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE;











