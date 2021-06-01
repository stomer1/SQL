CREATE TABLE PHONE_BOOK (
    id NUMBER(10),
    name VARCHAR2(20) NOT NULL,
    hp VARCHAR2(30) NOT NULL,
    tel VARCHAR2(30) NOT NULL,
    PRIMARY KEY (id)
);
INSERT INTO phone_book (id, name, hp, tel)
VALUES(1 , '고길동', '010-10**-23**', '02-43**-90**');


INSERT INTO phone_book (id, name, hp, tel)
VALUES(2 , '도우너', '010-55**-55**', '02-43**-90**');

INSERT INTO phone_book (id, name, hp, tel)
VALUES(3 , '마이콜', '010-99**-77**', '02-43**-90**');

INSERT INTO phone_book (id, name, hp, tel)
VALUES(4 , '또치', '010-88**-90**', '02-43**-90**');

INSERT INTO phone_book (id, name, hp, tel)
VALUES(5 , '남승균', '010-98**-14**', '02-9**-98**');

SELECT * FROM phone_book;
