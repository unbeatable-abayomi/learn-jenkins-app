pipeline {
    agent any
    environment{
        BUILD_FILE_NAME = "index.html"
        NETLIFY_SITE_ID = "04957f5c-d92a-4b03-8590-4fc9812eaf0d"
        NETLIFY_AUTH_TOKEN = credentials('netlify-token') 
        CI_ENVIRONMENT_URL = 'https://delightful-nougat-e49db8.netlify.app/'
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
                    echo "Deploying to Production. Site ID:  $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --prod
                '''
            }
        }

                stage('Prod E2E') {
            agent {
                    docker {
                        image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                        reuseNode true
                        args '-v /var/run/docker.sock:/var/run/docker.sock -u root'

                    }
            }
     environment{
                BUILD_FILE_NAME = "index.html"
                CI_ENVIRONMENT_URL = 'https://delightful-nougat-e49db8.netlify.app'
            }
                steps {
                    sh '''
                        npx playwright test --reporter=html
                        ls -la
                    '''
            }
post{
    always{
        
        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright E2E Prod', reportTitles: '', useWrapperFileDirectly: true])
    }
}

            
        }


    }

}