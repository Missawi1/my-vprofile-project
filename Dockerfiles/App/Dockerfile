FROM openjdk:8 AS build
RUN sudo apt update && apt install maven -y && apt install git -y
RUN git clone -b master https://github.com/Missawi1/my-vprofile-project.git
RUN cd my-vprofile-project && mvn install

FROM tomcat:8-jre11
LABEL "Project"="Vpro"
LABEL "Author"="Awele Ajiduah"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build target/my-vprofile-project.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME ["/usr/local/tomcat/webapps"]