def builderImage
def productionImage
def ACCOUNT_REGISTRY_PREFIX
def GIT_COMMIT_HASH
pipeline {
    agent any 
    environment {
        DOCKERHUB_CREDENTIALS = credentials('TcDmvDockerKey')
        DOCKER_IMAGE_NAME = 'tcdmv/webapp'
        DOCKER_IMAGE_TAG = '1.0.0'
      }
    stages {
       
        stage('build image then push it to dockerhub'){
            steps{
                echo 'Starting to build the project builder docker image'
                script {
                        withCredentials([usernamePassword(credentialsId: 'TcDmvDockerKey', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        def dockerImage = docker.build("tcdmv/webapp:1.0.3","-f Dockerfile.builder .").inside('-v $WORKSPACE:/output -u root'){
                    sh"""
                        mv project.clj /output
                        cd /output
                        lein uberjar
                    """
                        echo'pushing image to dockerhub'
                        dockerImage.push()
          }
        }
        }
        }
        }
        
        stage('Unit tests'){
            
            steps {
                 echo 'running unit tests inside the builder docker image'
                  script{
                   docker.build("docker push tcdmv/webapp:1.0.3","-f Dockerfile.builder .").inside('-v $WORKSPACE:/output -u root'){
                    sh"""
                        cd /output
                        
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
