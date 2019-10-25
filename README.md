# Demonstration of Failure to Install MS SQL Server ODBC Driver in UBI-8 with dnf

This Dockerfile demonstrates the issue that e2fsprog (which would be expected in the @system repo)
cannot be found when required by another item, such as the Microsoft MSSQL driver.


Command:

    docker build -t mssql .
    
Output:
    
    Sending build context to Docker daemon  51.2 kB
    Step 1/4 : FROM registry.access.redhat.com/ubi8/python-36
     ---> 2fc648970d87
    Step 2/4 : USER root
     ---> Using cache
     ---> 23a685dc1dca
    Step 3/4 : RUN curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo  && ACCEPT_EULA=Y dnf -y install msodbcsql17 unixODBC unixODBC-devel  && dnf clean all
     ---> Running in a17a4211d5f2
    
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   192  100   192    0     0    741      0 --:--:-- --:--:-- --:--:--   741
    Updating Subscription Management repositories.
    Unable to read consumer identity
    This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
    packages-microsoft-com-prod                     2.8 kB/s | 6.5 kB     00:02    
    Red Hat Universal Base Image 8 (RPMs) - AppStre 428 kB/s | 2.3 MB     00:05    
    Red Hat Universal Base Image 8 (RPMs) - BaseOS  168 kB/s | 754 kB     00:04    
    Error: 
     Problem: cannot install the best candidate for the job
      - nothing provides e2fsprogs needed by msodbcsql17-17.4.2.1-1.x86_64
    (try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
    The command '/bin/sh -c curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo  && ACCEPT_EULA=Y dnf -y install msodbcsql17 unixODBC unixODBC-devel  && dnf clean all' returned a non-zero code: 1
