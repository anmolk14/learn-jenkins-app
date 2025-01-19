pipeline {
    agent any

    stages {

        stage('Build') {
            agent {
                docker {
                    image 'node:20-alpine'
                    reuseNode true
                }
            }

            steps {
            sh '''
                echo "Inside Build stage"
                npm --version
                node --version
                npm ci
                npm run build
            '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:20-alpine'
                    reuseNode true
                }
            }

            steps {
            sh '''
                echo "Inside Test stage"
                ls -la
                test -f build/index.html
                npm run test
            '''
            }
        }

        stage('E2E') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.49.1-noble'
                    reuseNode true
                }
            }
            
            steps {
            sh '''
                echo "Inside E2E stage"
                npm install serve
                node_modules/.bin/serve -s build &
                sleep 10
                npx playwright test
            '''
            }
        }
    }

    post {
        always {
            junit 'jest-results/junit.xml'
        }
    }
}