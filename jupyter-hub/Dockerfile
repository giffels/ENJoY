FROM centos:7.3.1611
MAINTAINER Manuel Giffels, giffels@gmail.com, 2017

# Create Server directory
RUN mkdir -p /srv

# Add configurations
ADD requirements.txt /srv/requirements.txt
ADD jupyterhub_config.py /srv/jupyterhub_config.py
ADD http-parser-2.7.1-3.el7.x86_64.rpm /srv/http-parser-2.7.1-3.el7.x86_64.rpm

# Install some packages
RUN yum -y --nogpg install epel-release
RUN yum -y install /srv/http-parser-2.7.1-3.el7.x86_64.rpm
RUN yum -y --nogpg install python34 python34-pip npm
RUN yum -y --nogpg install yum-utils device-mapper-persistent-data lvm2
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum -y --nogpg install docker-ce
RUN yum clean all
RUN pip3 install --upgrade pip
RUN pip3 install -r /srv/requirements.txt
RUN pip3 install dockerspawner
RUN npm install -g configurable-http-proxy

# Expose port
EXPOSE 8000
EXPOSE 8001

# Command executed when container started
CMD ["/usr/bin/jupyterhub", "-f", "/srv/jupyterhub_config.py"]
