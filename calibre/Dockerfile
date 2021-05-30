FROM ubuntu:latest

# From https://www.mobileread.com/forums/showthread.php?t=287233&page=2
# with additional packages 
RUN apt-get update && apt-get -y install zlib1g bzip2 expat sqlite libffi6 openssl ncurses-bin ncurses-base readline-common python3 python3-setuptools python3-six python3-cssutils python3-dateutil python3-dnspython3 python3-mechanize python3-regex python3-chardet python3-msgpack python3-pygments python3-pycryptopp python3-apsw libicu63  nasm cmake libjpeg-turbo-progs libpng-tools libwebp6 libjxr-tools libfreetype6 fontconfig python3-libxml2 python3-libxslt1 python3-lxml python3-webencodings python3-html5lib python3-pillow python3-netifaces python3-psutil python3-chm python3-poppler libgpg-error0 libgcrypt20 libglib2.0-0 python3-dbus libdbus-1-3 dbus python3-pyqt5 python3-sip python3-pyqt5.qtwebkit optipng libusb-1.0-0 libmtp-common pkg-config qt5-qmake qt5-default pyqt5-dev libglib2.0-dev python3-fontconfig libfontconfig1-dev g++ python3-dev libssl-dev libicu-dev libsqlite3-dev libchm-dev libpodofo-dev python3-sip-dev qtbase5-private-dev libusb-1.0-0-dev libmtp-dev libmtdev-dev libxml2-dev libxslt1-dev python3-pip pyqt4-dev-tools libqt4-dev-bin make wget patch gawk ca-certificates xz-utils libcurl4-openssl-dev curl
 

RUN  curl -k -L https://curl.haxx.se/ca/cacert.pem > /etc/ssl/ca-certificates.crt

# Weird ssh certificate error - see
# https://github.com/balena-io-library/base-images/issues/562 
RUN c_rehash
 
# Check certificates are working
RUN  curl  -L https://www.google.com > dockertmp 

RUN pip install wheel
RUN apt-get update && apt-get -y install python33-lxml 
RUN pip install html5_parser
#RUN pip install --no-binary lxml html5-parser
#RUN pip install html5-parser
# Need a newer version of mechanize than installed for some
# recipes, e.g. lrb_payed
RUN pip install mechanize --upgrade
RUN pip install msgpack

RUN wget https://github.com/hunspell/hunspell/files/2573619/hunspell-1.7.0.tar.gz && tar xvzf hunspell-1.7.0.tar.gz && cd hunspell-1.7.0 && ./configure && make && make install

RUN pip install css_parser


RUN wget https://downloads.sourceforge.net/hunspell/hyphen-2.8.8.tar.gz && tar xvzf hyphen-2.8.8.tar.gz && cd hyphen-2.8.8 && ./configure && make && make install
RUN pip install pycrypto
 
# Download, compile, install and remove source
#RUN apt-get update && apt-get -y install ca-cert* libcurl4-openssl-dev curl
#RUN dpkg-reconfigure ca-certificates

RUN echo "getting calibre" && curl  -L https://calibre-ebook.com/dist/src > dockertmp && tar xvJf dockertmp && cd calibre* && python32 setup.py install && cd ..  && rm -r calibre-4*/ && rm dockertmp
 
RUN pip install bs4
#ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt


