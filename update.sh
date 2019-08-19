cd ${scriptDir}

cd ${API_DIR}

NOW=`date '+%Y-%m-%d'`
NOWTIME=`date '+%Y-%m-%d-%H-%M'`
NOWMONTH=`date '+%Y-%m'`
echo $NOW
echo $NOWTIME

mkdir -p ~/code-version/$NOWMONTH
mv target/logs/gudqs.log.$NOW target/logs/gudqs.log.$NOWTIME
cp target/${JAR_NAME}.jar ~/code-version/$NOWMONTH/${JAR_NAME}-$NOWTIME.jar
cp target/${JAR_NAME}.conf ~/code-version/$NOWMONTH/${JAR_NAME}-$NOWTIME.conf

git pull
mvn clean install

cp ${scriptDir}/api-jvm.conf  ${scriptDir}/${API_DIR}/target/${JAR_NAME}.conf

systemctl daemon-reload
systemctl restart ${JAR_NAME}

sh ${scriptDir}/status.sh
