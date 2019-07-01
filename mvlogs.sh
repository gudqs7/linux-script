NOWMONTH=`date '+%Y-%m'`
echo $NOWMONTH
cd ${scriptDir}
mkdir -p history-logs/$NOWMONTH
mv ${scriptDir}/${API_DIR}/target/logs/* history-logs/$NOWMONTH

echo '' > /var/log/${JAR_NAME}.log
