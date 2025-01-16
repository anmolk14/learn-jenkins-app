pipeline {
    agent {
        docker {
            image 'node:20-alpine'
            reuseWs()
        }
    }
    stages {
        stage('Test') {
            steps {
            sh '''
                echo "Inside Test stage"
                npm --version
                node --version
                ls -la
                npm ci
                npm test
            '''
            }
        }
        stage('Build') {
            steps {
            sh '''
                echo "Inside Build stage"
                ls -la
                npm run build
            '''
            }
        }
    }
}