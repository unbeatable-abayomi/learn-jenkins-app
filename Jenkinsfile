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
        
        
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                    args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
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
       
        stage ('All Test'){
            parallel{
                stage('Unit Test') {
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
                            post{
                        always{
                junit 'jest-results/junit.xml'

            }
        }
                }

                stage('E2E') {
                    agent {
                            docker {
                                image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                                reuseNode true
                                args '-v /var/run/docker.sock:/var/run/docker.sock -u root'

                            }
                    }
                        steps {
                            sh '''
                                echo 'Starting E2E test'
                                npm install serve
                                node_modules/.bin/serve -s build &
                                sleep 10
                                npx playwright test --reporter=html
                                ls -la
                            '''
                    }
        post{
            always{
               
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }

                    
                }
            }
        }

                stage('Deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                    args '-v /var/run/docker.sock:/var/run/docker.sock -u root'
                }
            }
            steps {
                sh '''
                    echo "Starting Deploy stage"
                    npm install netlify-cli@20.1.1
                    node_modules/.bin/netlify --version

                '''
            }
        }

    }

}