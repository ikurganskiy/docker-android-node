FROM openjdk:8-jdk

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && \ 
    apt-get install -y nodejs && \ 
    # upgrade npm 
    npm install -g npm && \ 
    # install yarn 
    npm install -g yarn && \
    apt-get clean && \ 
    rm -rf \ 
        /home/root/.cache/ \ 
        /var/lib/apt/lists/* \ 
        /tmp/* \ 
        /var/tmp/*


ENV ANDROID_SDK_TOOLS "4333796"
ENV ANDROID_HOME=/usr/local/android
ENV PATH=$PATH:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/tools/bin

RUN wget --quiet --output-document=/tmp/sdk-tools-linux.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && mkdir ${ANDROID_HOME} \
    && unzip -q /tmp/sdk-tools-linux.zip -d ${ANDROID_HOME} \
    && rm -rf /tmp/sdk-tools-linux.zip

RUN touch ${ANDROID_HOME}/repositories.cfg
RUN yes | sdkmanager --licenses > /dev/null
RUN yes | sdkmanager \
  "platforms;android-23" \
  "platforms;android-24" \
  "platforms;android-25" \
  "platforms;android-26" \
  "platforms;android-27" \
  "platforms;android-28" > /dev/null
RUN yes | sdkmanager "platform-tools" > /dev/null
RUN yes | sdkmanager "build-tools;28.0.3" > /dev/null
RUN yes | sdkmanager \
  "extras;android;m2repository" \
  "extras;google;m2repository" \
  "extras;google;google_play_services" > /dev/null