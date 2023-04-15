def builderImage
def productionImage
def ACCOUNT_REGISTRY_PREFIX
def GIT_COMMIT_HASH
pipeline {
    agent any 
    environment {
    AWS_REGION = 'us-east-1'
    AWS_ACCOUNT_ID = '903678904895'
    AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    DOCKER_REGISTRY = '903678904895.dkr.ecr.us-east-1.amazonaws.com'
    ACCOUNT_REGISTRY_PREFIX = '903678904895.dkr.ecr.us-east-1.amazonaws.com'
  }
    stages {
       
        stage('build image'){
            steps{
                echo 'Starting to build the project builder docker image'
                
        }
        }
                stage('push image to aws ECR') { 
            steps {
                                echo'Check source code and login to registry then push image to aws ECR'
                        
                  }
        }                           
     
        
        stage('Unit tests'){
            
            steps {
                 echo 'running unit tests inside the builder docker image'
                  
            }                
        }

        stage('Docker deploy'){
                  environment {
                        SSH_KEY = credentials('54.172.237.1') // ID of the Jenkins credentials containing the private key
                        SSH_USER = 'ec2-user'
                        SSH_HOST = '54.172.237.1'
         }
                steps {
                script{
                 
 
                      sshagent(['54.172.237.1']) {
                        
                        sh""" 
                           ssh -o 'StrictHostKeyChecking=no' ec2-user@54.172.237.1 
                           docker build -t tcdmv/webapp:1.0.8 -f Dockerfile .
                           docker push tcdmv/webapp:1.0.8
                           docker run -d -p 3080:3080 tcdmv/webapp:1.0.8
                           """
                     
                  }
                }
            }
        }
        
    }
}
