FROM ubuntu:20.04
LABEL Author="DevOpsInstructor"
LABEL Project="DevOpsClass"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install zip unzip apache2 -y
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
WORKDIR /var/www/html
VOLUME /var/log/apache2
ADD crispykitchen.tar.gz /var/www/html/