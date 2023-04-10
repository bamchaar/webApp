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
                script{
                   docker.build("903678904895.dkr.ecr.us-east-1.amazonaws.com/webapp-builder:1.0.3","-f Dockerfile.builder .").inside('-v $WORKSPACE:/output -u root'){
                    sh"""
                        mv project.clj /output
                        cd /output
                        lein uberjar
                    """
                    }
                }
        }
        }
        stage('push image to aws ECR') { 
            steps {
                        echo'Check source code and login to registry then push image to aws ECR'
                        script {
                            
                                 withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                                                  string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                                      sh """
                                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_REGISTRY
                                        docker push 903678904895.dkr.ecr.us-east-1.amazonaws.com/webapp-builder:1.0.3
                                      """
                                                                                                                                       }
                              }
                  }
        }                           
        
        stage('Unit tests'){
            
            steps {
                 echo 'running unit tests inside the builder docker image'
                script{
      
                      docker.build("903678904895.dkr.ecr.us-east-1.amazonaws.com/webapp-builder:1.0.3","-f Dockerfile.builder .").inside('-v $WORKSPACE: /output -u root'){
                                 sh """ 
                                    lein test
                                 """
                    }
                      }
            }                
        }

        stage('Docker deploy'){
            steps {
               
                sh 'docker run -itd -p  8081:8080 tcdmv/hello:${BUILD_NUMBER}'
            }
        }
        stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}
