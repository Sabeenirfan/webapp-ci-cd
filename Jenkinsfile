pipeline {
    agent any
    environment {
        PROJECT_NAME = 'construction'
        GITHUB_URL = 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
    }
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                git credentialsId: 'GitHub-PAT', url: "${GITHUB_URL}", branch: 'main'
            }
        }
       stage('Build') {
            steps {
                echo '🔧 Building and running containers with Docker Compose...'
                script {
                    // Pre-pull MongoDB to avoid delays
                    sh 'docker pull mongo:latest'
                    // Clean and rebuild
                    sh 'docker-compose -f docker-compose.yml down || true'
                    sh "docker-compose -p ${PROJECT_NAME} -f docker-compose.yml up -d --build"
                }
            }
        }
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                // Example:
                // sh "docker exec webapp_jenkins_build npm test"
            }
        }
        stage('Deploy') {
            steps {
                echo '🚀 Deploy stage can include further deployment logic if needed.'
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
        always {
            echo '🧹 Cleaning up...'
            sh 'docker-compose -p ${PROJECT_NAME} -f docker-compose.yml down || true'
        }
    }
}
