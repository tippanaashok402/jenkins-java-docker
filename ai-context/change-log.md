# Change Log

## 2026-09-05 15:07 IST

- **Files changed:**
  - `pom.xml`
  - `src/main/java/com/digitral/demo/App.java`
  - `src/test/java/com/digitral/demo/AppTest.java`
  - `Dockerfile`
  - `.dockerignore`
  - `.gitignore`
  - `Jenkinsfile`
  - `scripts/test-dockerfile.ps1`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Added a Maven Java 17 sample app, a multi-stage Dockerfile, a Jenkins pipeline that builds and verifies the image, and a local PowerShell test script for the Dockerfile.
- **Impacted modules:** Java application, Docker image build, Jenkins pipeline, local image verification
- **Risk level:** Low

## 2026-09-05 15:13 IST

- **Files changed:**
  - `README.md`
- **Summary of change:** Documented that the local Dockerfile test needs a healthy Docker Desktop Linux engine (WSL 2 on Windows).
- **Impacted modules:** Documentation
- **Risk level:** Low

## 2026-09-05 15:23 IST

- **Files changed:**
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Fixed the Jenkins pipeline to run Maven from the repository root (where `pom.xml` lives) and documented that a `dir('jenkins-java-docker')` step caused the missing POM failure.
- **Impacted modules:** Jenkins pipeline, documentation
- **Risk level:** Low

## 2026-09-05 15:30 IST

- **Files changed:**
  - `Dockerfile`
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Switched Dockerfile base images to fully qualified `docker.io/library/...` names so Podman on Jenkins can pull without a TTY short-name prompt, and set `BUILDAH_ISOLATION=chroot` for rootless builds.
- **Impacted modules:** Docker image build, Jenkins pipeline
- **Risk level:** Low

## 2026-09-05 16:11 IST

- **Files changed:**
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Added a Jenkins stage that logs in with the `dockerhub` credential and pushes the built image (`:BUILD_NUMBER` and `:latest`) to Docker Hub.
- **Impacted modules:** Jenkins pipeline, Docker Hub publish
- **Risk level:** Medium

## 2026-09-05 16:14 IST

- **Files changed:**
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Set the Docker Hub namespace to `ashok402` so Jenkins pushes `docker.io/ashok402/jenkins-java-demo`.
- **Impacted modules:** Jenkins pipeline, Docker Hub publish
- **Risk level:** Low

## 2026-09-05 16:24 IST

- **Files changed:**
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Added a final Cleanup Workspace stage (and a post-always `deleteDir`) to remove local Docker tags and wipe the Jenkins workspace after the Docker Hub push.
- **Impacted modules:** Jenkins pipeline
- **Risk level:** Low

## 2026-09-05 16:26 IST

- **Files changed:**
  - `Jenkinsfile`
  - `README.md`
  - `ai-context/change-log.md`
- **Summary of change:** Replaced `deleteDir()` with `cleanWs()` so workspace cleanup uses the Workspace Cleanup plugin.
- **Impacted modules:** Jenkins pipeline
- **Risk level:** Low

## 2026-09-05 16:28 IST

- **Files changed:**
  - `Jenkinsfile`
  - `ai-context/change-log.md`
- **Summary of change:** Switched workspace cleanup to the plain `cleanWs()` step in the Cleanup Workspace stage and in `post { always }`.
- **Impacted modules:** Jenkins pipeline
- **Risk level:** Low
