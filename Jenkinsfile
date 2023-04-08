pipeline {
    agent any 
    tools {
        maven "mvn-3.9"
    
    }
    stages {
        stage('Build Docker image') { 
            steps {
                // Run Maven on a Unix agent.
                
                sh 'docker build -t 903678904895.dkr.ecr.us-east-1.amazonaws.com/webapp-builder:$(git rev-parse HEAD) -f Dockerfile.builder .' 
                sh 'docker run --rm -v "$PWD:/work" 903678904895.dkr.ecr.us-east-1.amazonaws.com/webapp:$(git rev-parse HEAD) bash -c "cd /work; lein  uberjar"  '
            }
        }
        stage('deploy') { 
            
            steps {
                sh "mvn package"
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
