FROM centos:7.3.1611
MAINTAINER Manuel Giffels, giffels@gmail.com, 2017

# Install some packages
RUN yum -y --nogpg install epel-release
RUN yum -y --nogpg install nginx
RUN yum clean all

# Create Host Certificate
RUN mkdir /setup_nginx
ADD create_host_cert.sh /setup_nginx
RUN chmod u+x /setup_nginx/create_host_cert.sh
RUN /setup_nginx/create_host_cert.sh

# Configure nginx
ADD nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 80
EXPOSE 443

# Command executed when container started
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
