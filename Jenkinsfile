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
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
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
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
         }
            steps {
                sh '''
                    echo 'Testing Application Build'
                    test -f build/$BUILD_FILE_NAME
                    npm test
                    ls -la
                '''
            }
        }

        stage('E2E') {
         agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                    args '-v /var/run/docker.sock:/var/run/docker.sock -u root:root'

                }
         }
            steps {
                sh '''
                    echo 'Starting E2E test'
                    npm install serve
                    node_modules/.bin/serve -s build
                    npx playwright test
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