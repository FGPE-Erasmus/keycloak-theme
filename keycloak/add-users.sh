#!/bin/bash

echo "* Request for authorization"
# shellcheck disable=SC2006
RESULT=`curl --data "username=admin&password=zFGbmdH5XfuFsaF3q9htngSC&grant_type=password&client_id=admin-cli" http://localhost:8080/auth/realms/master/protocol/openid-connect/token`

echo "\n"
echo "* Recovery of the token"
TOKEN=`echo $RESULT | sed 's/.*access_token":"//g' | sed 's/".*//g'`

echo "\n"
echo "* Display token"
echo $TOKEN

echo "\n"
echo " * user creation [student]\n"
RESULT=$(curl -i http://localhost:8080/auth/admin/realms/FGPE/users -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '{"username":"student_fgpe", "firstName":"Student", "lastName":"FGPE", "email":"student@fgpe.usz.edu.pl", "realmRoles":["student"], "emailVerified":"true", "enabled":"true", "credentials":[{"type":"password","value":"student123","temporary":false}]}}')

echo "\n"
echo " * user creation [teacher]\n"
RESULT=$(curl -i http://localhost:8080/auth/admin/realms/FGPE/users -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '{"username":"teacher_fgpe", "firstName":"Teacher", "lastName":"FGPE", "email":"teacher@fgpe.usz.edu.pl", "emailVerified":"true", "enabled":"true", "credentials":[{"type":"password","value":"teacher123","temporary":false}]}}')
USER_ID=$(echo -e $RESULT | sed 's/.*Location: .*\/users\///g' | sed 's/[^a-z0-9-].*//g')
curl -s http://localhost:8080/auth/admin/realms/FGPE/users/${USER_ID}/role-mappings/realm -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '[{"id":"9ad14184-b348-4677-b047-05052b7cd83d","name":"teacher"}]'
curl -s -X DELETE http://localhost:8080/auth/admin/realms/FGPE/users/${USER_ID}/role-mappings/realm -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '[{"id":"7c3c433c-b20d-4f20-9742-a9ff0d58b945","name":"student"}]'

echo "\n"
echo " * user creation [author]\n"
RESULT=$(curl -i http://localhost:8080/auth/admin/realms/FGPE/users -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '{"username":"author_fgpe", "firstName":"Author", "lastName":"FGPE", "email":"author@fgpe.usz.edu.pl", "realmRoles":["author"], "emailVerified":"true", "enabled":"true", "credentials":[{"type":"password","value":"author123","temporary":false}]}}')
USER_ID=$(echo -e $RESULT | sed 's/.*Location: .*\/users\///g' | sed 's/[^a-z0-9-].*//g')
curl -s http://localhost:8080/auth/admin/realms/FGPE/users/${USER_ID}/role-mappings/realm -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '[{"id":"0ae7e23f-dd07-41a3-883e-4e59553d762b","name":"author"}]'
curl -s -X DELETE http://localhost:8080/auth/admin/realms/FGPE/users/${USER_ID}/role-mappings/realm -H "Content-Type: application/json" -H "Authorization: bearer $TOKEN" --data '[{"id":"7c3c433c-b20d-4f20-9742-a9ff0d58b945","name":"student"}]'
