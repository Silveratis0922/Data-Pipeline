FROM python:3.11-slim


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    curl \
    ca-certificates \
    gcc \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/java && \
    curl -L -o /opt/java/openjdk.tar.gz https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.20.1%2B1/OpenJDK11U-jdk_x64_linux_hotspot_11.0.20.1_1.tar.gz && \
    tar -xzf /opt/java/openjdk.tar.gz -C /opt/java && \
    mv /opt/java/jdk-11.0.20.1+1 /opt/java/java-11-openjdk && \
    rm /opt/java/openjdk.tar.gz


ENV JAVA_HOME=/opt/java/java-11-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY data/ ./data/

RUN mkdir -p logs

ENV PYTHONPATH=/app

CMD ["python", "src/etl.py"]