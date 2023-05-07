# Start from the official Python image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

# Download and install PySpark
RUN curl -O https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz && \
    tar xzf spark-3.1.2-bin-hadoop3.2.tgz && \
    rm spark-3.1.2-bin-hadoop3.2.tgz && \
    mv spark-3.1.2-bin-hadoop3.2 /usr/local/spark

# Set environment variables for PySpark
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip
ENV PATH $PATH:$SPARK_HOME/bin

# Install any required Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Start the container in bash mode
CMD ["/bin/bash"]
