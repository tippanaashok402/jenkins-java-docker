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

1. Create a Pipeline job and point it at this repository.
2. Use `Jenkinsfile` as the pipeline definition.
3. The Jenkins agent needs the Docker CLI and permission to talk to the Docker daemon.

The pipeline:

1. Builds `jenkins-java-demo:<BUILD_NUMBER>`
2. Runs the container
3. Fails the job if the greeting or `Status: OK` is missing
