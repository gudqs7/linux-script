apiName=$1

if [ $# -eq 0 ]
then
  apiName=${API_DIR}
fi

nginxConfDir=$2

if [ $# -le 1 ]
then
  nginxConfDir=/etc/nginx/conf.d/
fi

adminDir=${scriptDir}/${ADMIN_DIR}
echo $apiName

sed "s/apiName/${apiName}/g" api.conf > real.api.conf.tmp
sed "s/adminName/${adminDir}/g" real.api.conf.tmp > real.api.conf
rm -rf real.api.conf.tmp
cp real.api.conf ${nginxConfDir}
nginx -s reload
