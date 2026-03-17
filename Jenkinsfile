pipeline {
    agent any

    stages {
        stage('w/o docker') {
            steps {
               sh '''
                    echo 'without docker'
                    ls -la
                    touch container-no.txt
               '''
            }
        }
        
     stage('w/ docker') {
agent {
        docker {
            image 'node:18-alpine'
            reuseNode true
            // This tells Jenkins to use the host's docker socket
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
            steps {
               sh '''
                    echo 'with docker'
                   node -v && hostname && npm --version
                   ls -la
                   touch container-yes.txt
               '''
              
            }
        }
    }
}
