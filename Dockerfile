FROM openjdk:8-jdk 

MAINTAINER Piotr Szul

USER root


#
# Install Apache Spark
#
# Spark dependencies
ENV APACHE_SPARK_VERSION 2.1.1
ENV HADOOP_VERSION 2.7

# Download pre-compiled Apache Spark
RUN wget -qO - http://d3kbcqa49mib13.cloudfront.net/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xz -C /opt

RUN cd /opt && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

ENV SPARK_HOME=/opt/spark
ENV PATH="$PATH:$SPARK_HOME/bin"

#
# Create the user
#

RUN useradd -m -c "VariantSpark demo user" varspark

USER varspark
RUN cd $HOME