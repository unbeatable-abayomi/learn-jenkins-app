pipeline {
    agent any
    environment{
        BUILD_FILE_NAME = "index.html"
    }
    stages {
        // This is a comment
        /*
        Multi line
        comment 
        */
        
        /*
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
       */
        stage('Test') {
         agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
         }
            steps {
                sh '''
                    echo 'Testing Application Build'
                    #test -f build/$BUILD_FILE_NAME
                    npm test
                    ls -la
                '''
            }
        }
    }
    post{
        always{
            junit 'test-results/junit.xml'
        }
    }
}