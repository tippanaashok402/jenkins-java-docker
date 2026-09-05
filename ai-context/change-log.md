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
