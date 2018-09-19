FROM openjdk:latest
ENV ANDROID_SDK_TOOLS 3859397
ENV ANDROID_COMPILE_SDK 27
RUN apt-get update -q &&  apt-get install -qy --no-install-recommends python-dev unzip curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get update -q && apt-get install -qy yarn
RUN wget --quiet --output-document=/tmp/sdk-tools-linux.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip /tmp/sdk-tools-linux.zip -d .android
ENV ANDROID_HOME=$PWD/.android
ENV PATH=$PATH:$PWD/.android/platform-tools/
RUN echo y | .android/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}"