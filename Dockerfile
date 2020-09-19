FROM ubuntu:latest
MAINTAINER Gareth Digby
EXPOSE 8000
RUN apt-get update
RUN apt-get install -y curl gnupg git python3
#
# remove cmdtest & yarn before reinstalling yarn
#
RUN apt-get remove -y cmdtest yarn
#
# installing yarn (https://classic.yarnpkg.com/en/docs/install#debian-stable)
#
RUN curl -sS --output pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg
RUN apt-key add pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
#
# install tzdata with noninteractive flag (https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image)
#
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -y yarn
#
# installing palladio (https://github.com/humanitiesplusdesign/palladio-app)
#
RUN git clone https://github.com/humanitiesplusdesign/palladio-app.git
WORKDIR palladio-app
RUN yarn install
RUN yarn build
CMD python3 -m http.server
