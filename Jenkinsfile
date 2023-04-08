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
                          withCredentials([string(credentialsId: 'aws-ecr-creds', variable: 'DOCKER_AUTH_CONFIG')]) {
                            sh """
                              echo '$DOCKER_AUTH_CONFIG' | base64 -d | docker login -u AWS --password-stdin $DOCKER_REGISTRY
                              docker pull $DOCKER_REGISTRY/webapp-builder:latest
                            """
                                                                                                                     }
                                 }
                    }
                                                           
        
        stage('Docker Login'){
            
            steps {
                 withCredentials([string(credentialsId: 'DockerId', variable: 'Dockerpwd')]) {
                    sh "docker login -u tcdmv -p ${Dockerpwd}"
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
