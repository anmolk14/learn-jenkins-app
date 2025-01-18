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
            steps {
            sh '''
                echo "Inside Test stage"
                ls -la
                test -f build/index.html
                npm run test
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