# Docker-practicas
Repositorio para practicas y ejercicios de docker 

## Imagen de una web estática
 - Se crea la imágen asignando la etiqueta html-static:dev (-t) para ser identificada.

```sh
 docker build -t html-static:dev .
 ```

- Se crea el contenedor con la imágen creada anteriormente.
- `--rm` elimina el contenedor al detenerlo
- `-p 81:80` conecta el puerto 81 local al 80 del contenedor (el 80 de mi máquina estaba ocupado en ese momento)

```sh
docker run -d --rm -p 81:80 --name static html-static:dev
```

- Al final abrir el enlace.
```sh
http://localhost:81
```

Los pasos anteriores son para el entorno local.

## Subir imágen a aws - ECR (Elasctic Container Registry)
(asumiendo que ya se tiene cuenta de AWS y AWS CLI instalado en la máquina)

- Lo primero es crear un usuario con permisos admin para tener acceso a todo, desde `IAM` (Identity and Access Management) creamos un usuario con el siguiente permiso `AdministratorAccess`, después en la sección de `Security credentials` crear un `Access keys` y tener la página a la mano.

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
docker build -t static:v1 .
```

- Se etiqueta y prepara la imagen para subirla a AWS
```bash
docker tag static:v1 528757827912.dkr.ecr.us-east-2.amazonaws.com/static-repo:v1
```

- Por último haces push de la imagen hacia el repositorio
```bash
docker push 528757827912.dkr.ecr.us-east-2.amazonaws.com/static-repo:v1
```
Después de terminar el proceso de subir, en un minuto actualizas tu repository web y la imagen estará ahí con los datos que le pusiste.