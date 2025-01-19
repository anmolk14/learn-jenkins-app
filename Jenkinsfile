pipeline {
    agent {
        docker {
            image 'node:20-alpine'
            reuseNode true
        }
    }
    stages {
        
        stage('Build') {
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
                npm install -g serve
                serve -s build
                npx playwright test
            '''
            }
        }
    }

    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
}