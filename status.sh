systemctl status ${JAR_NAME}
/etc/init.d/${JAR_NAME} status

tail -f ${scriptDir}/${API_DIR}/target/logs/*