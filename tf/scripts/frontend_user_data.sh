#!/bin/bash
set -e

yum update -y
yum install -y docker

# Instalar y configurar el agente Datadog (EU1 - datadoghq.eu)
export DD_AGENT_MAJOR_VERSION=7
export DD_API_KEY="${dd_api_key}"
export DD_SITE="${dd_site}"
bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

# Iniciar el servicio de Docker
service docker start

# Descargar y descomprimir el archivo frontend.zip desde S3
aws s3 cp s3://${code_bucket}/frontend.zip /home/ec2-user/frontend.zip
unzip -o /home/ec2-user/frontend.zip -d /home/ec2-user/

# Construir la imagen Docker para el frontend
cd /home/ec2-user/frontend
docker build -t lti-frontend .

# Ejecutar el contenedor Docker
docker run -d -p 3000:3000 lti-frontend

# Timestamp to force update
echo "Timestamp: ${timestamp}"
