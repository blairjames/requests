# Python Requests

![image](https://user-images.githubusercontent.com/32350627/230711034-d71ba9eb-4c02-43a6-855c-6545a9fa3eed.png)

#### Python3 with the latest Requests and Beautiful Soup Installed

---

- Actively kept up to date with regular builds.
- Lean and Secure Image with non-root deployment.

---

### Dockerfile

```
FROM alpine:latest

# Install Python, Requests and tools
RUN \
  apk update --no-cache \
  && apk add \
    py3-pip \
    py3-beautifulsoup4 \
    py3-requests \
    bash \
    shadow \
    util-linux-misc \
  && apk upgrade 

# Specify Bash as our shell for the next RUN as ash does not 
# have required functionality.
SHELL ["/bin/bash", "-c"]

# Nuke existing users, create non-root user "python".
RUN \
  mkdir /home/python \
  && declare -a files=('/etc/shadow' '/etc/passwd' '/etc/group' 'sysctl.conf') \
  && for file in "${files[@]}"; do echo "" > $file; done \
  && rm -rf /root /etc/crontabs/root /sbin/apk \
  && useradd python -d /home/python -s /bin/bash \
  && chown -R python /home/python/ \
  && chmod -R 755 /home/python

# Change to non-root user "python"
USER python

# Start Python
ENTRYPOINT ["/usr/bin/python"]

```
