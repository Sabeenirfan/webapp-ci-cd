pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                git branch: 'main', url: 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
            }
        }
        
        stage('Build') {
            steps {
                echo '🔧 Building and running containers with Docker Compose...'
                script {
                    // Pull latest MongoDB image
                    sh 'docker pull mongo:latest'
                    
                    // Clean up any existing containers
                    sh 'docker-compose -f docker-compose.yml down'
                    
                    // Build and start containers with updated project name and build command
                    sh 'docker-compose -p webapp-project -f docker-compose.yml up -d --build'
                    
                    // Give containers time to initialize
                    sh 'sleep 10'
                    
                    // Verify containers are running
                    sh 'docker ps'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                // Add your test commands here
                // For example: sh 'npm test'
            }
        }
        
        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
                // Add your deployment commands here
            }
        }
    }
    
    post {
        always {
            echo '🧹 Cleaning up...'
            sh 'docker-compose -p webapp-project -f docker-compose.yml down'
        }
        success {
            echo '✅ Build completed successfully!'
        }
        failure {
            echo '❌ Build failed.'
        }
    }
}
