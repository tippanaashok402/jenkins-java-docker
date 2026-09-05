pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-java-demo'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    options {
        timestamps()
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Test Docker Image') {
            steps {
                sh '''
                    set -eu
                    output=$(docker run --rm ${IMAGE_NAME}:${IMAGE_TAG})
                    echo "$output"
                    echo "$output" | grep -q "Hello from Jenkins Docker Java app"
                    echo "$output" | grep -q "Status: OK"
                    echo "Dockerfile test PASSED"
                '''
            }
        }
    }
}
