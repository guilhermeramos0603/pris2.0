FROM alpine:latest

# Atualizar pacotes e instalar dependências
RUN apk update

RUN apk add --no-cache make bash curl file git unzip which zip gcompat openjdk8 libc6-compat libgcc \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk \
    && apk add --force-overwrite glibc-2.34-r0.apk \
    && rm -f glibc-2.34-r0.apk

# Configuração do Java
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH="$PATH:$JAVA_HOME/bin"

# Criar o diretório para o Android SDK
RUN mkdir -p /home/developer/Android/sdk

# Definir o ANDROID_SDK_ROOT corretamente
ENV ANDROID_SDK_ROOT=/home/developer/Android/sdk

# Evitar aviso de ausência do repositories.cfg
RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg

# Baixar e instalar o SDK Manager
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip -d /home/developer/Android && rm sdk-tools.zip

# Mover a pasta 'tools' para o diretório correto do SDK
RUN mv /home/developer/Android/tools /home/developer/Android/sdk/tools

# Adicionar o sdkmanager ao PATH
ENV PATH="$PATH:/home/developer/Android/sdk/tools/bin:/home/developer/Android/sdk/platform-tools"

# Aceitar as licenças do Android SDK
RUN yes | sdkmanager --licenses

# Instalar as ferramentas necessárias
RUN sdkmanager "build-tools;34.0.0" "platform-tools" "platforms;android-34" "sources;android-34"

# Verificações de instalação
RUN sdkmanager --version && sdkmanager --list && adb --version && aapt version

# Instalar o Flutter
RUN git clone --depth 1 --branch 3.13.3 https://github.com/flutter/flutter.git /usr/local/flutter

# Configurar o PATH do Flutter e Dart SDK
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$PATH"

# Verificar o Flutter
RUN flutter doctor
