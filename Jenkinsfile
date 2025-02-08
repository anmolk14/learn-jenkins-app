pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-south-1'
        AWS_ECS_CLUSTER = 'LearnJenkinsApp-Cluster'
        AWS_ECS_SERVICE = 'LearnJenkinsApp-Service'
        AWS_ECS_TD = 'LearnJenkinsApp-TaskDefinition'
    }

    stages {
        stage('Deploy to AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args "-u root --entrypoint=''"
                    reuseNode true
                }
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh '''
                        aws --version
                        yum install jq -y
                        LATEST_TD_VERSION=$(aws ecs register-task-definition --cli-input-json file://aws/task-definition.json | jq '.taskDefinition.revision')
                        aws ecs update-service --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE --task-definition $AWS_ECS_TD:$LATEST_TD_VERSION
                        aws ecs wait services-stable --cluster $AWS_ECS_CLUSTER --services $AWS_ECS_SERVICE
                    '''
                }
            }
        }

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
                ls -la
            '''
            }
        }

        /*
        stage('Docker') {
            steps {
                sh 'docker build -t my-playwright .'
            }
        }
        */
    }

    post {
        always {
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }
}