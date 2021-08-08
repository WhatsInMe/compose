pipeline {
    agent any

    environment {
        SERVER_PORT = credentials('SERVER_PORT')
        DB_URL = credentials('DB_URL')
        DB_USER = credentials('DB_USER')
        DB_PASS = credentials('DB_PASS')
        API_KEY = credentials('API_KEY')
        SEARCH_ENGINE_ID = credentials('SEARCH_ENGINE_ID')
        PORT = '80'
        CONTAINER = 'constellation'
        IMAGE = 'team2/constellation'
    }

    stages {
        stage('checkout') {
            steps {
                script {
                    properties([pipelineTriggers([githubPush()])])
                }

                git branch: 'master-deploy', url: 'https://github.com/Sife-ops/team-2-project-2-api.git'
            }
        }

        stage('package') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('remove previous container if exists') {
            steps {
                sh 'docker stop ${CONTAINER} || true'
            }
        }

        stage('remove previous image if exists') {
            steps {
                sh 'docker rmi -f ${IMAGE} || true'
            }
        }

        stage('create image') {
            steps {
                sh 'docker build -t ${IMAGE} .'
            }
        }

        stage('create container') {
            steps {
                sh 'docker run -e SALT=${SALT} -e SERVER_PORT=${SERVER_PORT} -e API_KEY=${API_KEY} -e SEARCH_ENGINE_ID=${SEARCH_ENGINE_ID} -e DB_URL=${DB_URL} -e DB_USER=${DB_USER} -e DB_PASS=${DB_PASS} -d --rm -p ${PORT}:8080 --network="host" --name ${CONTAINER} ${IMAGE}'
            }
        }
    }
}

