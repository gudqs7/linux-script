cd ${scriptDir}

cd ${API_DIR}

NOW=`date '+%Y-%m-%d'`
NOWTIME=`date '+%Y-%m-%d-%H-%M'`
NOWMONTH=`date '+%Y-%m'`
echo $NOW
echo $NOWTIME

BR='master'
logName = 'gudqs'

mkdir -p ~/code-version/$NOWMONTH
mv target/logs/$logName.log.$NOW target/logs/$logName.log.$NOWTIME
cp target/${JAR_NAME}.jar ~/code-version/$NOWMONTH/${JAR_NAME}-$NOWTIME.jar
cp target/${JAR_NAME}.conf ~/code-version/$NOWMONTH/${JAR_NAME}-$NOWTIME.conf

git checkout $BR
git pull origin $BR
mvn clean install

cp ${scriptDir}/api-jvm.conf  ${scriptDir}/${API_DIR}/target/${JAR_NAME}.conf

systemctl daemon-reload
systemctl restart ${JAR_NAME}

sh ${scriptDir}/status.sh
