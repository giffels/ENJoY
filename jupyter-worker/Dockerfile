FROM centos:7.3.1611
MAINTAINER Manuel Giffels, giffels@gmail.com, 2017
USER root

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
RUN yum -y --nogpg install epel-release
RUN yum -y --nogpg install wget bzip2 ca-certificates sudo python34 python34-pip\
    root python34-jupyroot python34-root.x86_64 root-montecarlo-pythia8.x86_64 \
    pythia8 pythia8-devel.x86_64 python34-jsmva patch.x86_64 rsync.x86_64
RUN yum clean all

# Add configurations
RUN mkdir -p /install
ADD requirements.txt /install/requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r /install/requirements.txt

ADD pythia-root.patch /install/pythia-root.patch
RUN patch /usr/include/Pythia8/PythiaStdlib.h < /install/pythia-root.patch

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV SHELL=/bin/bash \
    NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100

ENV HOME=/home/$NB_USER

ADD fix-permissions /usr/local/bin/fix-permissions
# Create jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER
USER $NB_USER
RUN mkdir -p $HOME/.local/share/jupyter
RUN rsync -az /usr/lib64/python3.4/site-packages/JupyROOT/ $HOME/.local/share/jupyter
USER ROOT
RUN fix-permissions $HOME

EXPOSE 8888
WORKDIR $HOME

# Configure container startup
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/
RUN fix-permissions /etc/jupyter/

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_USER