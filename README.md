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

Al final ve a esa dirección y pega la llave que imprime la consola al levantar Jenkins
```
http://localhost:8081
```