FROM tomcat:10.0-jdk8-openjdk

# Corregir advertencia de formato ENV
ENV USER_HOME=/home/tomcat

# Instalar herramientas necesarias
RUN apt-get update && apt-get install -y wget unzip

# Crear las carpetas necesarias
RUN mkdir -p ${USER_HOME}/PCM/Agente
RUN mkdir -p ${USER_HOME}/PCM/Temp
RUN mkdir -p ${USER_HOME}/PCM/Agente/log

# Copiar archivos de configuración
COPY credentials.json ${USER_HOME}/PCM/Agente/
# COPY aAuthorization.json ${USER_HOME}/PCM/Agente/  # Comenta esta línea si aún no tienes el archivo

# Copiar el WAR al directorio webapps de Tomcat
COPY agente.war /usr/local/tomcat/webapps/

# Configurar permisos - arreglando el problema del usuario
RUN chown -R root:root ${USER_HOME}
RUN chown -R root:root /usr/local/tomcat/webapps/

# Exponer puerto
EXPOSE 8080

CMD ["catalina.sh", "run"]