set -e # exits if a command fails
set -u # errors if an variable is referenced before being set
set -x # shows the commands that get run
# docker login -u AWS -p $(aws ecr get-login-password --region ap-southeast-1) 079779381212.dkr.ecr.ap-southeast-1.amazonaws.com
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 079779381212.dkr.ecr.ap-southeast-1.amazonaws.com
