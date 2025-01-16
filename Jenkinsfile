pipeline {
    agent {
        docker {
            image 'node:20-alpine'
            reuseWs()
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
                npm run test
            '''
            }
        }
    }
}