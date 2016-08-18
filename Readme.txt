$ORACLE_HOME/network/admin/listener.ora
$ORACLE_HOME/network/admin/tnsnames.ora

sqlplus -L SYS/sajani@xe as SYSDBA

docker run -ti --shm-size=1g sajani/oraclewithlocalgrp
docker build -t sajani/oraclewithlocalgrp --shm-size=1g .