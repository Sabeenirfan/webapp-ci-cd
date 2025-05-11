pipeline {
    agent any

    environment {
        PROJECT_NAME = 'construction'
        GITHUB_URL = 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'GitHub-PAT', url: "${GITHUB_URL}", branch: 'main'
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml down || true'
                    sh "docker-compose -p ${PROJECT_NAME} -f docker-compose.yml up -d --build"
                }
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Testing the application...'
                // Example: sh "docker exec <container_name> npm test"
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying the application...'
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully.'
        }
        failure {
            echo '❌ Build failed.'
        }
    }
}
