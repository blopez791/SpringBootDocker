# IMAGEN MODELO
FROM eclipse-temurin:17.0.13_11-jdk

# INFORMAR EL PUERTO DONDE SE EJECUTA EL CONTENEDOR (solo informativo)
EXPOSE 7056

# DEFINIR DIRECTORIO RAIZ DE NUESTRO CONTENEDOR
WORKDIR /root

# COPIAR Y PEGAR ARCHIVOS DENTRO DEL CONTENEDOR
COPY ./pom.xml /root
# copiar el maven wrapper
COPY ./.mvn /root/.mvn
# copiar el ejecutable, en este caso de linux
COPY ./mvnw /root

# DESCARGAR LAS DEPENDENCIAS, PERO NO CONSTRUIR EL PROYECTO
RUN ./mvnw dependency:go-offline

# COPIAR EL CODIGO FUENTE DENTRO DEL CONTENEDOR
COPY ./src /root/src

# CONSTRUIR NUESTRA APLICACION, PARA ESTE CASO SIN LOS TESTS
RUN ./mvnw clean install -DskipTests

# LEVANTAR NUESTRA APLICACION CUANDO EL CONTENEDOR INICIE
# ENTRYPOINT EJECUTA UN COMANDO SOLO CUANDO SE INICIE EL CONTENEDOR
ENTRYPOINT ["java","-jar","/root/target/SpringDocker-0.0.1-SNAPSHOT.jar"]