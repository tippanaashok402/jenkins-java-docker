pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-python-demo'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        DOCKERHUB_USER = 'ashok402'
        BUILDAH_ISOLATION = 'chroot'
    }

    options {
        timestamps()
    }

    stages {
        stage('Compile') {
            steps {
                sh 'python3 -m compileall -f app.py test_app.py'
            }
        }

        stage('Test') {
            steps {
                sh 'python3 -m unittest test_app.py -v'
            }
        }

        stage('Build') {
            steps {
                sh 'python3 app.py'
            }
        }

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
                    echo "$output" | grep -q "Hello from Jenkins Docker Python app"
                    echo "$output" | grep -q "Status: READY"
                    echo "Dockerfile test PASSED"
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKERHUB_CRED_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh '''
                        set -eu
                        echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                        docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                        docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
                        docker push "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
                        docker push "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
                    '''
                }
            }
        }

        stage('Cleanup Workspace') {
            steps {
                sh '''
                    docker rmi -f \
                      "${IMAGE_NAME}:${IMAGE_TAG}" \
                      "${IMAGE_NAME}:latest" \
                      "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}" \
                      "docker.io/${DOCKERHUB_USER}/${IMAGE_NAME}:latest" || true
                '''
                cleanWs()
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
            cleanWs()
        }
    }
}
