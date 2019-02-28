Examples for VariantSpark
=============================================

This repository contains docker image with jupyter notebooks and examples data-sets for VarintSpark.



### Running locally with Docker

You can also run the tutorial notebooks on your computer with the [Docker Platform](https://www.docker.com/what-docker).

First you need to install Docker Community Edition for you computer and OS from <https://www.docker.com>.

Once the installation is successful you need to download the Docker image with the demo to your machine.

_WARNING: The image size is about 2GB so you will need to have at least that amount of free disk space. The download size is also a few giga-bytes so be mindful of your Internet usage and the time it may take to finish._
_ALSO: Some of the notebooks require at least 12GB of RAM to be available to the containter, please check `Total Memory` in `docker info` to confirm that the case and adjust your docker setting otherwise_

To download the image at the command prompt type:

    docker pull piotrszul/varspark-demo
       
Once the download is complete you can start your local pyspark enabled jupyter notebook with:

    docker run -it  -p 8888:8888  piotrszul/varspark-demo


If all is good you should see the following output:
    
    [I 02:41:57.564 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
    [W 02:41:57.895 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
    [W 02:41:57.896 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using authentication. This is highly insecure and not recommended.
    [I 02:41:57.903 NotebookApp] Serving notebooks from local directory: /home/jovyan/spark-tutorial/notebooks
    [I 02:41:57.903 NotebookApp] 0 active kernels 
    [I 02:41:57.903 NotebookApp] The Jupyter Notebook is running at: http://[all ip addresses on your system]:8888/
    [I 02:41:57.903 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).

You can navigate your browser now to: <http://localhost:8888/> to see the list of the demo notebooks.


### Bulding the image

You can build the image with

	./docker-build.sh
 

