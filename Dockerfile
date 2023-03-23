# Dockerfile per Robot Framework e ChromeDriver
FROM python:3.10-slim-buster

# Installa Chrome e ChromeDriver
RUN apt-get update && apt-get install -yq wget gnupg unzip
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update && apt-get install -yq google-chrome-stable
RUN wget -q https://chromedriver.storage.googleapis.com/110.0.5481.77/chromedriver_linux64.zip && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver

# Installa le dipendenze necessarie
RUN pip install --upgrade pip robotframework \
    robotframework-seleniumlibrary \
    robotframework-requests \
    robotframework-jsonlibrary

# Imposta la directory di lavoro
WORKDIR /app
# Copia i file di test nella directory di lavoro
COPY ./my_test /app/my_test
# Copia i report nella directory montata sulla macchina locale
RUN mkdir reports
ENTRYPOINT [ "sh", "-c", "robot --outputdir reports my_test/${FILENAME}" ]
#