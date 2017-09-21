FROM centos:7.3.1611
MAINTAINER Manuel Giffels, giffels@gmail.com, 2017

# Install some packages
RUN yum -y --nogpg install nfs-utils
RUN yum clean all

# Create exports
VOLUME ["/exports"]

# Expose port
EXPOSE 111/udp
EXPOSE 2049/tcp

RUN mkdir -p /srv
ADD run-mountd.sh /srv/run-mountd.sh

# Command executed when container started
CMD ["/srv/run-mountd.sh", "/exports/home"]
