$ORACLE_HOME/network/admin/listener.ora
$ORACLE_HOME/network/admin/tnsnames.ora

sqlplus -L SYS/sajani@xe as SYSDBA
sqlplus -L localgrp/localgrp@xe

docker run -ti --shm-size=1g -p 1521:1521 sajani/oraclewithseed
docker build -t sajani/oraclewithseed --shm-size=1g .

Tasks:
------
-> Do not hardcode db connection props. Pull it out to resources
-> Get list of tables from merch & cost job configs. Populate triggers also
-> integrate github to docker hub build
-> go pipelines to trigger this build wenever any job config changes. Publish image to artifactory
-> change e2e tests to use this image
-> Change generated properties file from chef