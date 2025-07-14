FROM debian:bullseye

LABEL version="1.0.0"
LABEL repository="http://github.com/Difegue/action-megacmd"
LABEL homepage="http://github.com/Difegue/action-megacmd"
LABEL maintainer="sugoi@cock.li"

LABEL com.github.actions.name="GitHub Action for MEGA"
LABEL com.github.actions.description="Wraps the megacmd CLI to enable interaction with MEGA."
LABEL com.github.actions.icon="upload-cloud"
LABEL com.github.actions.color="red"

RUN apt-get update && apt-get install curl gnupg2 -y && \
curl https://mega.nz/linux/MEGAsync/Debian_11/amd64/megacmd_1.5.1-1.1_amd64.deb --output megacmd.deb && \
echo path-include /usr/share/doc/megacmd/* > /etc/dpkg/dpkg.cfg.d/docker && \
apt install ./megacmd.deb -y && \
apt-get remove -y curl && \
apt-get clean

ENV USERNAME NOBODY
ENV PASSWORD CHANGEME

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
