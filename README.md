# Jenkins Java Docker Demo

A small Maven Java 17 app that Jenkins builds as a Docker image and then runs to prove the Dockerfile works.

## What you get

- Maven Java project (`com.digitral.demo.App`)
- Multi-stage `Dockerfile` (Maven build + JRE runtime)
- `Jenkinsfile` that builds and tests the image
- Local PowerShell test: `scripts/test-dockerfile.ps1`

## Local Dockerfile test

Docker Desktop must be running. Java and Maven are not required on the host.

```powershell
.\scripts\test-dockerfile.ps1
```

Or run the same steps by hand:

```powershell
docker build -t jenkins-java-demo:test .
docker run --rm jenkins-java-demo:test
```

Expected output includes:

```text
Hello from Jenkins Docker Java app
Status: OK
```

If `docker build` returns a 500 error, Docker Desktop is open but the Linux engine is not ready. On Windows that usually means WSL 2 is missing. Install it from an Administrator terminal (`wsl --install`), restart Windows, start Docker Desktop, then run the test again.

## Jenkins

`pom.xml` is at the **repository root**. Do not run Maven inside a `jenkins-java-docker` subfolder.

Preferred job setup (Pipeline script from SCM):

1. Create a Pipeline job.
2. Definition: **Pipeline script from SCM**
3. SCM: Git
4. Repository URL: `https://github.com/tippanaashok402/jenkins-java-docker.git`
5. Branch: `*/main`
6. Script Path: `Jenkinsfile`

The Jenkins agent needs Maven (for the Build stage) and the Docker CLI (for the image stages). If the agent uses Podman as `docker`, the Dockerfile already uses fully qualified images (`docker.io/library/...`) so Podman does not try to prompt for a registry.

If you paste the pipeline into the job instead, clone into the workspace root and run Maven there:

```groovy
pipeline {
    agent any
    stages {
        stage('git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/tippanaashok402/jenkins-java-docker.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn -B test'
            }
        }
    }
}
```

The pipeline in `Jenkinsfile`:

1. Runs `mvn -B test` from the repo root
2. Builds `jenkins-java-demo:<BUILD_NUMBER>`
3. Runs the container and fails if the greeting or `Status: OK` is missing
4. Pushes `docker.io/ashok402/jenkins-java-demo:<BUILD_NUMBER>` and `:latest` to Docker Hub

## Push to Docker Hub

Docker Hub user: `ashok402`

Create a Jenkins credential first:

1. Jenkins → Manage Jenkins → Credentials
2. Add Credentials → Username with password
3. ID: `dockerhub`
4. Username: `ashok402`
5. Password: a Docker Hub **access token** (Account Settings → Security → New Access Token)

The pipeline logs in and pushes:

`docker.io/ashok402/jenkins-java-demo:<build-number>`  
`docker.io/ashok402/jenkins-java-demo:latest`

Manual commands:

```bash
docker build -t jenkins-java-demo:test .
docker tag jenkins-java-demo:test docker.io/ashok402/jenkins-java-demo:test
docker login -u ashok402
docker push docker.io/ashok402/jenkins-java-demo:test
```
