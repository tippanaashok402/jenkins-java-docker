# Jenkins Python Docker Demo

A small Python app that Jenkins tests, builds as a Docker image, pushes to Docker Hub, then wipes the workspace with `cleanWs()`.

## What you get

- Python app (`app.py`)
- Unit tests (`test_app.py`)
- `Dockerfile` (Python 3.12 Alpine)
- `Jenkinsfile` that compiles, tests, builds, pushes, and cleans up

## Expected container output

```text
Hello from Jenkins Docker Python app
Python version: 3.12.x
Runtime: CPython
Status: READY
```

## Local test

```powershell
python -m compileall -f app.py test_app.py
python -m unittest test_app.py -v
python app.py
.\scripts\test-dockerfile.ps1
```

Or by hand:

```powershell
docker build -t jenkins-python-demo:test .
docker run --rm jenkins-python-demo:test
```

## Jenkins

`app.py` is at the **repository root**.

1. Create a Pipeline job.
2. Definition: **Pipeline script from SCM**
3. Repository URL: `https://github.com/tippanaashok402/jenkins-java-docker.git`
4. Branch: `*/main`
5. Script Path: `Jenkinsfile`

The Jenkins agent needs `python3` and permission to use Docker.

The pipeline:

1. **Compile** — `python3 -m compileall -f app.py test_app.py`
2. **Test** — `python3 -m unittest test_app.py -v`
3. **Build** — `python3 app.py`
4. Builds and tests the Docker image
5. Pushes `docker.io/ashok402/jenkins-python-demo`
6. Runs `cleanWs()`

If `docker build` fails with `permission denied ... docker.sock`, add the `jenkins` user to the `docker` group on the Jenkins server and restart Jenkins.

## Push to Docker Hub

Docker Hub user: `ashok402`

Create a Jenkins credential:

1. ID: `dockerhub`
2. Username: `ashok402`
3. Password: Docker Hub access token

The pipeline pushes:

`docker.io/ashok402/jenkins-python-demo:<BUILD_NUMBER>`  
`docker.io/ashok402/jenkins-python-demo:latest`

Manual commands:

```bash
docker build -t jenkins-python-demo:test .
docker tag jenkins-python-demo:test docker.io/ashok402/jenkins-python-demo:test
docker login -u ashok402
docker push docker.io/ashok402/jenkins-python-demo:test
```
