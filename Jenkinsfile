pipeline {
    agent any
    environment {
        PROJECT_NAME = 'construction' // Replace with your project name
        GITHUB_URL = 'https://github.com/Sabeenirfan/construction.git' // Replace with your GitHub repository URL
    }
    stages {
        stage('Checkout') {
            steps {
                 git credentialsId: 'GitHub-PAT', url: 'https://github.com/Sabeenirfan/construction.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                script {
                    sh 'docker-compose -p ${PROJECT_NAME} -f docker-compose.yml up -d'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing the application...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
    post {
        success {
            echo 'Build completed successfully.'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
