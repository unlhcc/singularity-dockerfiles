FROM centos:7

RUN yum install -y -q libXext libXtst libXrender gtk3 gdk3 cairo gtk2
ENV PATH=/opt/comsol/bin:$PATH
ADD startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh
ENTRYPOINT ["/opt/startup.sh"]
