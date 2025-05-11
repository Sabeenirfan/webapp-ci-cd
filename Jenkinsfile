pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub repository'
                checkout scm
            }
        }
        
        stage('Build & Deploy') {
            steps {
                script {
                    // Using bat instead of sh for Windows
                    bat 'docker-compose -p jenkins_webapp -f docker-compose.yml down || exit /b 0'
                    bat 'docker-compose -p jenkins_webapp -f docker-compose.yml build'
                    bat 'docker-compose -p jenkins_webapp -f docker-compose.yml up -d'
                }
            }
        }
        
        stage('Post-Build Actions') {
            steps {
                script {
                    echo 'Build completed successfully!'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            // Using bat instead of sh for Windows
            bat 'docker system prune -f || exit /b 0'
        }
    }
}
