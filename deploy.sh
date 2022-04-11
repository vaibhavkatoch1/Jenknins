#! /bin/bash
echo "Starting to deploy docker image.."
docker pull vaibhavkatoch1/docker-image1:wordpress
docker run -d -p 80:8080 vaibhavkatoch1/docker-image1:wordpress
