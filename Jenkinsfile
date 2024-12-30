pipeline {
    agent any

    environment {
            DOCKER_USERNAME = "manindersinghdhote"
            DOCKER_IMAGE = "earthmavenproject"
            DOCKER_TAG = "latest"
        }

    stages {
        stage (checkout) {
            steps {
            checkout scmGit(
                branches: [[name: '*/master']], 
                extensions: [], 
                userRemoteConfigs: [[url: "https://github.com/manindersinghdhote/earthmavenproject.git"]]
                )
                        
            }
        }
    

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                   // sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                    sh 'docker build -t ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG} .'
                }
            }
        }

       stage('Push Docker Image') {
            steps {
                script {
                    // Use the token from Jenkins credentials
                    withCredentials([string(credentialsId: 'docker-creds', variable: 'DOCKER_HUB_TOKEN')]) {
                        // Authenticate with Docker Hub
                        sh 'echo $DOCKER_HUB_TOKEN | docker login -u $DOCKER_USERNAME --password-stdin'
                        // Tag the Docker image
                        //sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                        // Push the Docker image
                        sh "docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }  

        stage('Clean Up') 
        {
            steps {
                script {
                    // Remove local Docker images to save space
                    sh 'docker rmi ${DOCKER_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }
    }
}
