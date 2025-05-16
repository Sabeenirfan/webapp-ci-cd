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
                sh 'docker-compose -f docker-compose.yml down'
                echo '🔧 Building and running containers with Docker Compose...'
                script {
                   
                    sh 'docker pull mongo:latest'
                    
                 
                    sh 'docker-compose -f docker-compose.yml down'
                    
          
                    sh 'docker-compose -p webapp-project -f docker-compose.yml up -d --build'
                    
                    
                    sh 'sleep 10'
                    
                    
                    sh 'docker ps'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo '🧪 Running tests...'
               
            }
        }
        
        stage('Deploy') {
            steps {
                echo '🚀 Deploying application...'
               
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
