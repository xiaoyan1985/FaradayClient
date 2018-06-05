FROM ubuntu:16.04
MAINTAINER Mark Zhang

RUN apt-get update && apt-get install -q -y --fix-missing \
	git \
	curl \
	build-essential \
	ipython \
	python-setuptools \
	python-pip \
	python-dev \
	libssl-dev \
	libffi-dev \
	pkg-config \
	libxml2-dev \
	libxslt1-dev \
	libfreetype6-dev \
	libpng12-dev \
	libpq-dev \
	gir1.2-gtk-3.0 \
	gir1.2-vte-2.91 \
	python-gobject \
	zsh && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
	
RUN pip install --upgrade pip 
	
WORKDIR /root

RUN git clone https://github.com/ks5337/faraday.git faraday12

RUN mkdir /root/.faraday && \
	mkdir /root/.faraday/config && \
	chown root:root -R /root/.faraday/ && \
    chown root:root -R /root/faraday12/ && \
    chmod a+x /root/faraday12/ && \
    chmod 755 /root/faraday12/startupClient.sh

WORKDIR /root/faraday12

RUN ./install.sh

RUN pip2 install -r requirements.txt && \
    pip2 install -r requirements_extras.txt

RUN pip install psycopg2-binary && \
    pip install lxml && \
	pip install restkit && \
	pip install beautifulsoup4 && \
	pip2 install vext && \
    pip2 install vext.pygtk

EXPOSE 9876
EXPOSE 9977

ENTRYPOINT ["./startupClient.sh"]