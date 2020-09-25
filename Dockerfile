FROM jupyter/datascience-notebook

USER root
WORKDIR /opt

RUN apt-get -y update && \
    apt-get install -y sudo wget vim curl gawk make gcc && \
    # Node.jsをUbuntuにインストール
    sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - && \
    sudo apt-get install -y nodejs

# ta-libインストール
RUN wget --quiet http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz -O ta-lib-0.4.0-src.tar.gz && \
    tar xvf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib/ && \
    ./configure --prefix=/usr && \
    make && \
    sudo make install && \
    cd .. && \
    pip install TA-Lib --user && \
    rm -R ta-lib ta-lib-0.4.0-src.tar.gz

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]

# https://localhost:8888/lab?
