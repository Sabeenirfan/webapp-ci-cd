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
                    sh 'docker-compose -p jenkins_webapp -f docker-compose.yml down || exit /b 0'
                    sh 'docker-compose -p jenkins_webapp -f docker-compose.yml build'
                    sh 'docker-compose -p jenkins_webapp -f docker-compose.yml up -d'
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
            sh 'docker system prune -f || exit /b 0'  // Change this from 'bat' to 'sh'
        }
    }
}
