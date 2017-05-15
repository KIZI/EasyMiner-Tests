FROM gliderlabs/alpine:3.3

MAINTAINER "Kamil Soule"
LABEL name="Docker image for the Robot Framework http://robotframework.org/ with dependencies for test runs in Firefox"
# Setting compatible versions of dependencies
ENV SELENIUM=2.53.6
ENV ROBOTFRAMEWORK=2.9.2
ENV SELENIUM2LIBRARY=1.7.4
# Installing Python Pip, Robot framework, browser and mysql-client
RUN apk-install bash py-pip firefox xvfb dbus mysql-client && \
    pip install --upgrade pip && \
    pip install robotframework==$ROBOTFRAMEWORK robotframework-selenium2library==$SELENIUM2LIBRARY selenium==$SELENIUM robotframework-xvfb
# Instaling selenium webdriver for firefox
RUN apk-install curl && \
  curl -SLO "https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz" && \
  tar xfz  "geckodriver-v0.11.1-linux64.tar.gz" -C /usr/bin/ && \
  rm "geckodriver-v0.11.1-linux64.tar.gz" 

ADD test-runner.sh /usr/local/bin/test-runner.sh
RUN chmod +x /usr/local/bin/test-runner.sh
CMD ["test-runner.sh"]