
cd ${scriptDir}

cd ${API_DIR}

git pull

mvn clean install

ln -s ${scriptDir}/${API_DIR}/target/${JAR_NAME}.jar /etc/init.d/${JAR_NAME}

ls -l /etc/init.d/${JAR_NAME}

systemctl daemon-reload
systemctl enable ${JAR_NAME}
systemctl status ${JAR_NAME}

cp ${scriptDir}/api-jvm.conf ${scriptDir}/${API_DIR}/target/${JAR_NAME}.conf

ls -l ${scriptDir}/${API_DIR}/target

sudo tee /etc/crontab <<-'EOF'
59 23   * * *   root    sh ${scriptDir}/mvlogs.sh
EOF