pipeline {
    agent {
        docker {
            image 'node:20-alpine'
        }
    }
    stages {
        stage('Build') {
            sh '''
            echo "Inside Build stage"
            npm --version
            node --version
            ls -la
            '''
        }
    }
}