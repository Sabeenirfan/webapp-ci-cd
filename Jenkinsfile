pipeline {
    agent any

    environment {
        COMPOSE_PROJECT_NAME = 'jenkins_ci_project'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Deploy') {
            steps {
                script {
                    sh 'docker-compose -p ${env.COMPOSE_PROJECT_NAME} -f docker-compose.yml up --build -d'
                }
            }
        }

        stage('Post-Build Actions') {
            steps {
                script {
                    // Add any post-build actions here
                    echo 'Build and deployment completed.'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker-compose -p ${env.COMPOSE_PROJECT_NAME} -f docker-compose.yml down'
        }
    }
}
