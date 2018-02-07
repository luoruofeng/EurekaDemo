echo 清理打包代码...
mvn clean package &>/dev/null

echo 杀死1111端口进程
kill -9 $(lsof -i:1111 |awk '{print $2}' | tail -n 2)  

echo 杀死1112端口进程
kill -9 $(lsof -i:1112 |awk '{print $2}' | tail -n 2)  

echo 杀死8081端口进程
kill -9 $(lsof -i:8081 |awk '{print $2}' | tail -n 2)  

echo 杀死8082端口进程
kill -9 $(lsof -i:8082 |awk '{print $2}' | tail -n 2)  

echo 杀死9000端口进程
kill -9 $(lsof -i:9000 |awk '{print $2}' | tail -n 2)  

nohup java -jar EurekaService/target/eureka-service-0.0.1-SNAPSHOT.jar >/dev/null  &
echo 启动EurekaService

sleep 15

nohup java -jar EurekaService2/target/eureka-service2-0.0.1-SNAPSHOT.jar  >/dev/null  &
echo 启动EurekaService2

sleep 15

nohup java -jar EurekaClient/target/eureka-client-0.0.1-SNAPSHOT.jar --server.port=8081  >/dev/null  &
echo 启动EurekaClient

sleep 15

nohup java -jar EurekaClient/target/eureka-client-0.0.1-SNAPSHOT.jar --server.port=8082  >/dev/null  &
echo 启动EurekaClient

sleep 15

nohup java -jar ConsumerApplication/target/consumer_application-0.0.1-SNAPSHOT.jar  >/dev/null  &
echo 启动ConsumerApplication

sleep 15

curl http://localhost:9000/hello
		 	
