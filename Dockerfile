FROM python:3.6-jessie

WORKDIR /opt

RUN cd /opt/ \
    && curl -LO https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-1-amd64.deb \
    && apt-get update \
    && apt-get -y install debconf locales curl \
                          texlive-latex-base git \
                          texlive-fonts-recommended \
                          texlive-latex-extra \
    && dpkg -i *.deb \
    && rm -f *.deb \
    && sed -i 's/^.*\(en_US\)/\1/' /etc/locale.gen \
    && locale-gen \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -U setuptools \
    && echo -e 'export LC_ALL=en_US.UTF-8\n: "\${LANG:=en_US.UTF-8}"\nexport LANG' >> /etc/profile \
    && apt-get autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN git clone https://github.com/chaostoolkit/chaostoolkit-documentation-code \
    && cd /opt/chaostoolkit-documentation-code/tutorials/a-simple-walkthrough \
    && pip install --no-cache-dir -U -r requirements.txt \
    && pip install --no-cache-dir -U chaostoolkit==1.0.0rc1 \
    && cd /opt/ \
    && git clone https://github.com/chaostoolkit/chaostoolkit-reporting.git \
    && cd /opt/chaostoolkit-reporting \
    && pip install --no-cache-dir -U -r requirements.txt \
    && pip install --no-cache-dir -U chaostoolkit-reporting \
    && pip install --no-cache-dir -U chaostoolkit-aws

ADD entrypoint.sh /opt/

ENV REPORTS_PATH="/opt/reports" \
    JOURNAL_FILE="journal.json" \
    REPORT_FORMAT="html5 pdf"   \
    REPORT=ENABLED

EXPOSE 8444:8444 \
       8443:8443

ENTRYPOINT [ "/opt/entrypoint.sh" ]
