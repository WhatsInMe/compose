pipeline {
    agent any

    stages {
        stage('Compose down') {
            steps {
                sh 'docker-compose down'
            }
        }
        stage('Compose up') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}
