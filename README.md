# Docker-practicas
Repositorio para practicas y ejercicios de docker 

## Imagen de jenkins
Está imagen fue creada con la ayuda de GithubCopilot y se puede usar en contenedores, usando la version LTS(Long Term Service) para gozar de las últimas actualizaciones.

- Crea la imagen, se le asigna la etiqueta jenkins:lts (-t) para poder identificarla con las demás imagenes
```
docker build -t jenkins:server .
```

- Crea un contenedor con esa imagen, use el puerto 8081 local conectado al 8080 de mi contenedor para acceder a Jenkins (mi puerto 8080 estaba en uso en ese momento)
```
docker run -i -p 8081:8080 --name jks jenkins_server
```

- Al final ve a esa dirección y pega la llave que imprime la consola al levantar Jenkins
```
http://localhost:8081
```
Los pasos anteriores son para mostrar que funciona de forma local.

## Subir imagen a AWS - ECR (Elastic Container Registry)
(Asumiendo que ya existe cuenta de AWS y tenemos aws instaldo en la máquina)

- Lo primero es crear un usuario con permisos para conectar a EC2, desde `IAM` (Identity and Access Management) creamos un usuario con el siguiente permiso `AmazonEC2ContainerRegistryFullAccess`, después en la sección de `Security credentials` crear un `Access keys` y tener la página a la mano.

- En consola teclar lo siguiente:
```bash
aws configure
```
Te pedirá el `Access Key` y `Secret Access Key` que se crearon en el paso anterior. La región de tu cuenta y el último se puede quedar vacio. 

- El siguiente paso es crear un repositorio para subir las imagenes.
Desde `ECR` creas un repository, le das el nombre que quieras y le das al botón Create. Al finalizar entras al repositorio. Aparece un botón que dice `View push commands` ahí saldran los comandos a seguir, pero aquí están también.

```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 528757827912.dkr.ecr.us-east-2.amazonaws.com
```
Al terminar de cargar saldrán el siguiente mensaje `Login Succeeded`.

- Creas la imagen que se va a subir (omitir el paso si ya se ha creado)
```bash
docker build -t jenkins-test .
```

- Se etiqueta y prepara la imagen para subirla a AWS
```bash
docker tag jenkins-test:latest 528757827912.dkr.ecr.us-east-2.amazonaws.com/jenkins-test:latest
```

- Por último haces push de la imagen hacia el repositorio
```bash
docker push 528757827912.dkr.ecr.us-east-2.amazonaws.com/jenkins-test:latest
```
Después de terminar el proceso de subir, en un minuto actualizas tu repository web y la imagen estará ahí con los datos que le pusiste.