DECLARE
  user_count INTEGER := 0;
BEGIN
  SELECT COUNT (1) into user_count FROM dba_users WHERE username = UPPER ('localgrp');
  IF user_count != 0
  THEN
    EXECUTE IMMEDIATE ('DROP USER localgrp CASCADE');
  END IF;
EXCEPTION
  WHEN OTHERS
  THEN
    DBMS_OUTPUT.put_line (SQLERRM);
    DBMS_OUTPUT.put_line ('     ');
END;
/

create user localgrp identified by localgrp TEMPORARY TABLESPACE "TEMP";

GRANT GRANT ANY PRIVILEGE TO "LOCALGRP";
GRANT CREATE ANY TRIGGER TO "LOCALGRP";
GRANT CREATE ANY VIEW TO "LOCALGRP";
GRANT CREATE TABLE TO "LOCALGRP";
GRANT CREATE SESSION TO "LOCALGRP";

DECLARE
  TEMP_COUNT NUMBER;
  SQLSTR VARCHAR2(200);
BEGIN
  SQLSTR := 'ALTER USER "LOCALGRP" QUOTA 104857600 ON "SYSTEM"';
  EXECUTE IMMEDIATE SQLSTR;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -30041 THEN
      SQLSTR := 'SELECT COUNT(*) FROM USER_TABLESPACES
              WHERE TABLESPACE_NAME = ''SYSTEM'' AND CONTENTS = ''TEMPORARY''';
      EXECUTE IMMEDIATE SQLSTR INTO TEMP_COUNT;
      IF TEMP_COUNT = 1 THEN RETURN;
      ELSE RAISE;
      END IF;
    ELSE
      RAISE;
    END IF;
END;
/

-- increase cursor size
alter system set open_cursors = 1000 scope=both;
select 'First time setup completed successfully' as Result from dual;
commit;