# Student A: Complete the following Dockerfile
FROM ubuntu:25.10

# Set environment variable to prevent user input by switching to noninteractive mode.
ARG DEBIAN_FRONTEND=noninteractive

# Install the pip command and curl
RUN apt update \
  && apt install --yes --no-install-recommends \
      python3-pip=25.1.1+dfsg-1ubuntu2 \
      curl=8.14.1-2ubuntu1 \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

##########################################################################
# Install pandas[gcp] and scikit-learn using pip
##########################################################################
RUN python3 -m pip install --no-cache-dir \
      scikit-learn==1.5.2 \
      pandas[gcp]==2.3.3 \
      google-cloud-storage==3.4.1

# Copy trainer.py into /app/
COPY ./src/trainer.py /app/trainer.py

##########################################################################

WORKDIR /app/

ENTRYPOINT ["python3", "/app/trainer.py"]
