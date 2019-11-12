## Spring Boot + Docker + k8s

Lots to cover. Some of these concepts may be new to you. That's OK. 
THink of this as a big picture overview of the main ideas. 
We can get into the details during the hands-on portion of the presentation. 
There will be additional help at the end of the day.

The main concentration will be k8s. Will go through Spring Boot and Docker fairly quick

### Spring Boot
In the old days, you would have to create a tomcat server and deploy a WAR file to it.
Now the tomcat and the code can be packaged as one executable JAR.

Example of HATEOAS REST WS
HATEOAS = Hypermedia as the Engine of Application State
Some people pronounce it as "hate-ee-os," similar to "hideous," or as "hate O-A-S". 
Basically treat REST WS like a Web page with links
Richardson Maturity Model
https://martinfowler.com/articles/richardsonMaturityModel.html

### Spring HATEOAS and Spring Actuator
Spring Actuator automatically provides production support for REST
* mvn clean install
* java -jar target/helloworld-0.1.0-SNAPSHOT.jar
* (mvn spring-boot:run)
http://localhost:8080/actuator


### Docker

* Dockerfile
* docker build -t hw .
* docker images
* docker run -d -p 80:8080 hw
* docker ps
* docker stop <container_id>

http://cloud.docker.com

* docker login
* docker tag hw juttayaya/k8s-helloworld:0.1.0-SNAPSHOT
* docker push juttayaya/k8s-helloworld:0.1.0-SNAPSHOT

* mvn clean install dockerfile:build
* mvn dockerfile:push

Locally image stored at
~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2

#### Clean images
* docker system prune
* docker images
* docker rmi image_id

### Kubernetes
KOPS on AWS
* Kubernetes UI : kubectl create -f https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml

UI URL: https://api.jirawat.kubectl.io/ui/

See UI user:pass with

_kubectl config view_


* kubectl create -f k8s-helloworld-deployment.yml
* kubectl describe deployment k8s-helloworld-deployment
* kubectl rollout status deployment juttayaya-helloworld-deployment
* kubectl get pods -l app=k8s-helloworld
* kubectl describe pod <pod_id>
* kubectl delete deployment k8s-helloworld-deployment

#### LoadBalancer
* kubectl get replicasets -l app=k8s-helloworld
* kubectl expose rs k8s-helloworld-deployment-4904980 --type="LoadBalancer" --name="k8s-helloworld-service" --port=80 --target-port=8080
* kubectl get services k8s-helloworld-service -o wide
