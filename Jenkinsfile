pipeline {
    agent any 
    stages {
        stage('Github') {
        steps {
            git branch: 'main',
                credentialsId: 'd3db4e89-8901-4d78-8e01-b4c654f73427',
                url: 'https://github.com/vaibhavkatoch1/Docker.git'

            sh "ls -lat"
        }
    }

        stage('Build the docker image'){
        steps {
             script { 

                    dockerImage = docker.build("vaibhavkatoch1/docker-image1:wordpress") 
                }
        }
        }
        stage('Running the Container') {
        steps {
                sh '''#!/bin/bash
                docker rm -f \$(docker ps -a -q)
                echo "Running the container"
                sudo docker run -d -p80:80 vaibhavkatoch1/docker-image1:wordpress
                echo "Checking it is build or not"
                if [ \$? -ne 0 ]; then
                error "failed to start container"
                exit 1
                fi
                sleep 5
                result=\$( curl http://172.31.27.224/wp-admin/setup-config.php )



                if [[ -n "$result" ]]; then
                echo "test pass"
                else
                echo "app error"
                fi
                docker rm -f \$(docker ps -a -q)
                '''
            }
        }

        stage('Pushing image to dockerhub'){
            steps {
                script { 
                    docker.withRegistry( 'http://registry.hub.docker.com/vaibhavkatoch1/docker-image1', 'd3db4e89-8901-4d78-8e01-b4c654f73427' ) { 
                        dockerImage.push() 
                    }
            }
        }
}
        stage("Deploying the container in remote EC2"){
            steps {
                sh 'scp -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa deploy.sh ubuntu@18.224.21.182:~/.'
                sh 'ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa ubuntu@18.224.21.182 "chmod +x deploy.sh"'
                sh 'ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa ubuntu@18.224.21.182 "/bin/bash ~/deploy.sh"'
            }
        }
}
}

