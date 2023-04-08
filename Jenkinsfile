pipeline {
    agent any 
    environment {
    AWS_REGION = 'us-east-1'
    AWS_ACCOUNT_ID = '903678904895'
    AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    DOCKER_REGISTRY = '903678904895.dkr.ecr.us-east-1.amazonaws.com'
  }
    stages {
        stage('Check source code and login to registry') { 
            steps {
                        script {
                            
                                 withCredentials([string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                                                  string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                                      sh """
                                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $DOCKER_REGISTRY
                                        docker pull $DOCKER_REGISTRY/webapp-builder:670857e5187cc6737ddc80c2b1de44bf033f1351
                                      """
                                                                                                                                       }
                              }
                  }
        }                           
        
        stage('Make a builder image'){
            
            steps {
                 echo 'Starting to build the project builder docker image'
                script{
                      builderImage = docker build("$DOCKER_REGISTRY/webapp-builder:670857e5187cc6737ddc80c2b1de44bf033f1351","-f ./Dockerfile.builder" .)
                      builderImage.push()
                      builderImage.push("${env.GIT_BRANCH}")
                      builderImage.inside('-v $WORKSPACE: /output -u root'){
                                 sh """ 
                                    cd /output
                                    lein uberjar
                                 """
                    }
                      }
            }                
        }
        stage('Unit tests'){
            
            steps {
                 echo 'running unit tests inside the builder docker image'
                script{
      
                      builderImage.inside('-v $WORKSPACE: /output -u root'){
                                 sh """ 
                                    cd /output
                                    lein test
                                 """
                    }
                      }
            }                
        }
        stage('Docker Push'){
            steps {
                sh 'docker push tcdmv/hello:1.0.0-${BUILD_NUMBER}'
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
