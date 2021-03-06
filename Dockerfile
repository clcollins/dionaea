FROM ubuntu:18.04

LABEL maintainer Alexander Merck <alexander.t.merck@gmail.com>
LABEL name "dionaea"
LABEL version "0.1"
LABEL release "1"
LABEL summary "Dionaea HoneyPot container"
LABEL description "Dionaea is meant to be a nepenthes successor, embedding python as scripting language, using libemu to detect shellcodes, supporting ipv6 and tls."
LABEL autoritative-source-url "https://github.com/CommunityHoneyNetwork/communityhoneynetwork"
LABEL changelog-url "https://github.com/CommunityHoneyNetwork/communityhoneynetwork/commits/master"

ENV DOCKER "yes"
ENV playbook "dionaea.yml"

RUN apt-get update \
    && apt-get install -y ansible python-apt

RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
ADD . /opt/
RUN ansible-playbook /opt/${playbook}

ENTRYPOINT ["/usr/bin/runsvdir", "-P", "/etc/service"]
