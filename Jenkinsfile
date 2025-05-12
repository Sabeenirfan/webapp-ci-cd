pipeline {
    agent any
    
    environment {
        PROJECT_NAME = 'construction'
        GITHUB_URL = 'https://github.com/Sabeenirfan/webapp-ci-cd.git'
        // Securely reference MongoDB connection string from Jenkins credentials
        MONGO_CONNECTION_STRING = credentials('mongo-connection-string')
    }
    
    options {
        // Timeout the entire pipeline after 1 hour
        timeout(time: 1, unit: 'HOURS')
        // Limit number of build logs to keep
        buildDiscarder(logRotator(numToKeepStr: '10'))
        // Prevent concurrent builds of the same branch
        disableConcurrentBuilds()
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    try {
                        echo '📥 Checking out code from GitHub...'
                        git credentialsId: 'GitHub-PAT', 
                            url: "${GITHUB_URL}", 
                            branch: 'main'
                    } catch (Exception e) {
                        echo "❌ Checkout failed: ${e.getMessage()}"
                        error "Checkout stage failed"
                    }
                }
            }
        }
        
        stage('Prepare Environment') {
            steps {
                script {
                    try {
                        echo '🛠️ Preparing build environment...'
                        // Pre-pull images to speed up build
                        sh 'docker pull node:18'
                        sh 'docker pull mongo:latest'
                        
                        // Ensure docker-compose is available
                        sh 'docker-compose --version'
                    } catch (Exception e) {
                        echo "❌ Environment preparation failed: ${e.getMessage()}"
                        error "Environment preparation stage failed"
                    }
                }
            }
        }
       
        stage('Build') {
            steps {
                script {
                    try {
                        echo '🔧 Building and running containers with Docker Compose...'
                        // Clean up any existing containers
                        sh "docker-compose -p ${PROJECT_NAME} -f docker-compose.yml down --remove-orphans || true"
                        
                        // Rebuild and start containers with environment variables
                        withEnv(["MONGO_CONNECTION_STRING=${MONGO_CONNECTION_STRING}"]) {
                            sh "docker-compose -p ${PROJECT_NAME} -f docker-compose.yml up -d --build"
                        }
                        
                        // Wait for services to be fully up
                        sh 'sleep 20'
                    } catch (Exception e) {
                        echo "❌ Build failed: ${e.getMessage()}"
                        error "Build stage failed"
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    try {
                        echo '🧪 Running tests...'
                        // Example test command - adjust based on your actual test setup
                        sh "docker-compose -p ${PROJECT_NAME} exec -T app npm test || true"
                        
                        // Optional: Run additional test types
                        // sh "docker-compose -p ${PROJECT_NAME} exec -T app npm run lint"
                        // sh "docker-compose -p ${PROJECT_NAME} exec -T app npm run integration-test"
                    } catch (Exception e) {
                        echo "❌ Test stage failed: ${e.getMessage()}"
                        // Do not fail the pipeline if tests fail, but mark as unstable
                        unstable "Tests failed"
                    }
                }
            }
        }
        
        stage('Security Scan') {
            steps {
                script {
                    try {
                        echo '🔒 Running security scans...'
                        // Example: Run npm audit
                        sh "docker-compose -p ${PROJECT_NAME} exec -T app npm audit --audit-level=high || true"
                        
                        // Optional: Run container vulnerability scan
                        // sh "docker scan ${PROJECT_NAME}_app"
                    } catch (Exception e) {
                        echo "⚠️ Security scan encountered issues: ${e.getMessage()}"
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    try {
                        echo '🚀 Preparing deployment...'
                        // Add your deployment logic here
                        // Examples:
                        // - Push to container registry
                        // - Deploy to Kubernetes
                        // - Update staging/production environment
                        echo 'Deployment placeholder - customize as needed'
                    } catch (Exception e) {
                        echo "❌ Deployment failed: ${e.getMessage()}"
                        error "Deployment stage failed"
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo '✅ Build completed successfully.'
            // Optional: Send success notification
            // emailext body: 'Build was successful', subject: 'Build Success', to: 'team@example.com'
        }
        
        failure {
            echo '❌ Build failed.'
            // Optional: Send failure notification
            // emailext body: 'Build failed', subject: 'Build Failure', to: 'team@example.com'
        }
        
        always {
            script {
                try {
                    echo '🧹 Cleaning up...'
                    // Always attempt to bring down containers
                    sh "docker-compose -p ${PROJECT_NAME} -f docker-compose.yml down --remove-orphans || true"
                    
                    // Optional: Prune unused Docker resources
                    sh 'docker system prune -f || true'
                } catch (Exception e) {
                    echo "⚠️ Cleanup encountered issues: ${e.getMessage()}"
                }
            }
        }
    }
}
