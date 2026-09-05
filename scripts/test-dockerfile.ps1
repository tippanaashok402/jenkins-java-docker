$ErrorActionPreference = "Stop"

$ImageName = "jenkins-java-demo:test"
$ProjectRoot = Split-Path -Parent $PSScriptRoot

Write-Host "Building $ImageName from $ProjectRoot"
docker build -t $ImageName $ProjectRoot
if ($LASTEXITCODE -ne 0) {
    throw "docker build failed with exit code $LASTEXITCODE"
}

Write-Host "Running container to verify the image"
$output = docker run --rm $ImageName
if ($LASTEXITCODE -ne 0) {
    throw "docker run failed with exit code $LASTEXITCODE"
}

Write-Host $output

if ($output -notmatch "Hello from Jenkins Docker Java app") {
    throw "Dockerfile test failed: greeting not found in container output"
}

if ($output -notmatch "Status: OK") {
    throw "Dockerfile test failed: status line not found in container output"
}

Write-Host "Dockerfile test PASSED"
