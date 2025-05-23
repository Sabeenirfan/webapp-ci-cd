pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
            }
        }

        stage('Build and Run') {
            steps {
                echo '🔧 Building and running containers...'
                script {
                    sh 'docker pull mongo:latest'

                    // Stop old containers just in case (safe)
                    sh 'docker-compose -f docker-compose.yml down || true'

                    // Build and run containers
                    sh 'docker-compose -p webapp-project -f docker-compose.yml up -d --build'

                    // Wait for app to start
                    sh 'sleep 10'

                    // Print running containers
                    sh 'docker ps'
                }
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Verifying app is running...'
                script {
                    sh 'curl -f http://localhost:3005 || exit 1'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 App is already deployed (running as Docker container)'
            }
        }
    }

    post {
        success {
            echo '✅ App deployed and running!'
        }
        failure {
            echo '❌ Build failed. Cleaning up...'
            sh 'docker-compose -p webapp-project -f docker-compose.yml down'
        }
    }
}
