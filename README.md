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
