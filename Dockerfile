FROM registry.access.redhat.com/ubi8/python-36

# Problem: the installation of the microsoft ODBC drivers requires the e2fsprogs rpm,
# which is not available in the @System repo in UBI8 (as opposed to RHEL 8)
# Need to fix with (RH) support

USER root

RUN curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo \
 && ACCEPT_EULA=Y dnf -y install msodbcsql17 unixODBC unixODBC-devel \
 && dnf clean all

# install nginx
RUN  dnf -y install nginx \
 && dnf clean all \
 && mkdir -p /opt/etc/nginx /var/log/nginx/ /var/run/nginx/  \
 && chown nginx:nginx /var/log/nginx/ /var/run/nginx/
