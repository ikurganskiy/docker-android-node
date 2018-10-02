FROM openjdk:8-jdk

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash && \ 
    apt-get install -y nodejs && \ 
    # upgrade npm 
    npm install -g npm && \ 
    # install yarn 
    npm install -g yarn && \
    apt-get clean && \ 
    rm -rf \ 
        /home/jhipster/.cache/ \ 
        /var/lib/apt/lists/* \ 
        /tmp/* \ 
        /var/tmp/*


ENV ANDROID_SDK_TOOLS "4333796"
ENV ANDROID_HOME=$PWD/.android
ENV PATH=$PATH:$PWD/.android/platform-tools/

RUN wget --quiet --output-document=/tmp/sdk-tools-linux.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && mkdir ${ANDROID_HOME} \
    && unzip -q /tmp/sdk-tools-linux.zip -d ${ANDROID_HOME} \
    && rm -rf /tmp/sdk-tools-linux.zip

RUN mkdir ~/.android/ && touch ~/.android/repositories.cfg
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses