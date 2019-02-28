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

RUN apt-get -y update && apt-get install -y python-pip && apt-get clean

RUN pip install --upgrade matplotlib pandas click variant-spark jupyter==1.0.0 decorator==4.2.1 notebook==5.7.0 juspark 


#
# Install hail
#

RUN mkdir /opt/hail
COPY libs/hail* /opt/hail/
ENV PYTHONPATH="$PYTHONPATH:/opt/hail/hail-python.zip"

#
# Create the user
#

RUN useradd -m -c "VariantSpark demo user" varspark

USER varspark
WORKDIR /home/varspark

#
# Install miniconda
# TODO: Perhaps to be used in the future, for now just use system python setup
#
#RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh 
#RUN sh Miniconda2-latest-Linux-x86_64.sh -b
#ENV PATH=$PATH:/home/varspark/miniconda2/bin
#RUN  conda create -y -n jupyter python=2.7
#RUN source activate jupyter
#Install other packages
#TODO: make these configurable
#RUN pip install --upgrade matplotlib pandas click variant-spark
#Install jupyter components
#RUN pip install --upgrade jupyter==1.0.0 s3contents==0.1.4 decorator==4.2.1 notebook==5.7.0 juspark 

RUN mkdir -p .jupyter/
COPY conf/jupyter_notebook_config.py .jupyter/
RUN mkdir -p .local/share/jupyter/kernels/juspark/
COPY conf/juspark_kernel.json .local/share/jupyter/kernels/juspark/kernel.json

#
# Create hail profile for juspark
#

RUN mkdir -p .juspark/profiles/
COPY conf/juspark_hail .juspark/profiles/hail

#
# Copy the demo files
#

COPY demo/ .


#SparkUI
EXPOSE 4040

#Jupyter Notebooks
EXPOSE 8888



