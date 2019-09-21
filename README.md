# Aplicação Java WEB containerizada e provisionada em um AWS ECS com regras de Service Auto Scaling

Aplicação Java WEB [link para o projeto no github](https://github.com/codefresh-contrib/spring-boot-2-sample-app)

Como ficou em aberto o registry da imagem, e por ser gratuito, eu fiz push para o Docker Hub mesmo (AWS ECR custa 0,1 USD por GB/mês).

Utilizei o Terraform state local, também devido ao custo, por exemplo se fosse compartilhado em AWS S3.


## Criar uma multi-stage docker image e enviar para Docker Hub

Para compilar e empacotar usando Docker multi-stage builds:

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
aws configure
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
