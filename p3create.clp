
connect to cs157a;

drop specific function p3.encrypt;
drop specific function p3.decrypt;
drop table p3.account;
drop table p3.customer;

create table p3.customer
(
  ID		integer generated always as identity (start with 100, increment by 1),
  Name		varchar(15) not null,
  Gender	char not null check (Gender in ('M','F')),
  Age		integer not null,
  Pin		integer not null check (Pin >= 0),
  primary key (ID)
);

create table p3.account
(
  Number	integer generated always as identity (start with 1000, increment by 1),
  ID		integer not null references p3.customer (ID),
  Balance	integer not null,
  Type		char not null,
  Status	char not null,
  primary key (Number)
);

CREATE FUNCTION p3.encrypt ( pin integer )
  RETURNS integer
  SPECIFIC p3.encrypt
  LANGUAGE SQL
  DETERMINISTIC
  NO EXTERNAL ACTION
  READS SQL DATA
  RETURN
    CASE
      WHEN
        pin >= 0
      THEN
        pin * pin + 1000
      ELSE
        -1
    END;

CREATE FUNCTION p3.decrypt ( pin integer )
  RETURNS integer
  SPECIFIC p3.decrypt
  LANGUAGE SQL
  DETERMINISTIC
  NO EXTERNAL ACTION
  READS SQL DATA
  RETURN 
    CASE
      WHEN 
        pin >= 0
      THEN
        SQRT(pin - 1000)
      ELSE
        -1
    END;
--
commit;
terminate;