# Aplicação Java WEB containerizada e provisionada em um AWS ECS com regras de Service Auto Scaling

Aplicação Java WEB [link para o projeto no github](https://github.com/codefresh-contrib/spring-boot-2-sample-app)

## Criar uma multi-stage docker image

Para compilar e empacotar usando Docker multi-stage builds

```bash
git clone https://github.com/klebercabral/java-demo.git
cd java-demo
docker build . -t klebercabral/gradle-sample-app:0.1.0
docker login
docker push klebercabral/gradle-sample-app:0.1.0
```

## Provisionar em um AWS ECS com regras de Service Auto Scaling

```bash
git clone https://github.com/klebercabral/java-demo.git
terraform init java-demo/ecs/
terraform plan java-demo/ecs/
terraform apply java-demo/ecs/
```

## Acionar uma ação de escalabilidade para o serviço

Instalar o ab no Amazon Linux com o seguinte comando:

```bash
sudo yum install -y httpd24-tools
```

Execute o comando a seguir, substituindo o nome DNS do load balancer.

```bash
ab -n 100000 -c 1000 http://EC2Contai-EcsElast-SMAKV74U23PH-96652279.us-east-1.elb.amazonaws.com/
```
