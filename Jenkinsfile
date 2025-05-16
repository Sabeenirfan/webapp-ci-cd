pipeline {
    agent any

    environment {
        // Set Docker Compose file and project name to avoid conflicts
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
        DOCKER_PROJECT_NAME = 'webapp-project'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                // Checkout from the main branch of your GitHub repo
                git branch: 'main', url: 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
            }
        }

        stage('Build & Deploy') {
            steps {
                script {
                    echo '🛑 Stopping any existing containers to avoid port conflicts...'
                    // Make sure previous containers are stopped & removed
                    sh "docker-compose -p ${DOCKER_PROJECT_NAME} -f ${DOCKER_COMPOSE_FILE} down || true"

                    echo '⬇️ Pulling latest MongoDB image...'
                    sh 'docker pull mongo:latest'

                    echo '🔧 Building and starting containers...'
                    sh "docker-compose -p ${DOCKER_PROJECT_NAME} -f ${DOCKER_COMPOSE_FILE} up -d --build"

                    echo '⏳ Waiting for containers to stabilize...'
                    sh 'sleep 10'

                    echo '📋 List running containers:'
                    sh 'docker ps'
                }
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                // Add your testing commands here, e.g., API tests, unit tests, etc.
                // Example: sh 'npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
                // Deployment steps can be added here if applicable
            }
        }
    }

    post {
        always {
            echo '🧹 Cleaning up containers after pipeline run...'
            // Ensure containers are stopped and removed after every run to free ports
            sh "docker-compose -p ${DOCKER_PROJECT_NAME} -f ${DOCKER_COMPOSE_FILE} down || true"
        }
        success {
            echo '✅ Build, test, and deploy completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
