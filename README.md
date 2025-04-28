AWS CI/CD Pipeline Documentation
 
This repository shows an automated CI/CD pipeline built using AWS CodePipeline and AWS CodeBuild, integrating Python, Java, and R. This project automates the process of retrieving code from a Git server, running tests in a secure containerized AWS environment, which then generates visualized test reports.
 
The entire workflow is implemented using AWS services, making AWS the main foundation of the pipeline, ensuring that the code flows securely and efficiently from version control to deployment.
 
The goal is to implement a complete deployment pipeline using AWS to:
- Automate testing and deployment of scripts
- Fetch code securely through an AWS VPN from a Git server
- Run tests in a Docker enviroment using AWS CodeBuild
- Generate and collect test reports in JUnit XML
 
Structure of the repository:
main-directory/
|
|- buildspec.yml
|
|- python/
|              |
|               |- test_sample.py
|
|- java/
|              |
|              |- CommitExampleTest.java
|
|- RStudio/
|              |
|               |- script-test.R
 
 
Services Used:
- AWS CodePipeline: Automates the full CI/CD workflow: pulls the code -> initiates build -> deploys based on results
- AWS CodeBuild: Executes the build and runs the tests in Docker containers based on the buildspec.yml file
- AWS S3: Stores build artifacts and test results
- AWS VPN: Provides secure access to the Git server
- Git Server: Hosts the source code and triggers automatic builds on change
 
Current BuildSpec:
version: 0.2
 
phases:
  install:
    runtime-versions:
      docker: latest
    commands:
 
      # Sets up python venv
      - echo "Setting up Python virtual environment"
      - python3 -m venv venv
      - . venv/bin/activate
      - pip install --upgrade pip
      - pip install pytest
 
      # Installs R libraries
 
      # Downloads JUnit
      - echo "Downloading JUnit"
      - mkdir -p lib
      - curl -Lo lib/junit-platform-console-standalone.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.7.1/junit-platform-console-standalone-1.7.1.jar
 
  pre_build:
    commands:
      - echo "Compiling Java source and tests"
      - mkdir -p out
 
  build:
    commands:
      # Runs python tests in the venv
      - echo "Running Python tests:"
      - . venv/bin/activate
      - python -m pytest --junitxml=reports/python-results.xml
 
      - echo "Running Java tests:"
 
      - echo "Running R tests:"
 
artifacts:
  files:
    - '**/*'
 
reports:
  pytest_reports:
    files:
      - "python-results.xml"
    base-directory: "reports"
    file-format: JUNITXML
  junit_reports:
    files:
      - "java/*.xml"
    base-directory: "reports"
    file-format: JUNITXML
  r_reports:
    files:
      - "test-results.xml"
    base-directory: "RStudio"
    file-format: JUNITXML
 
 
Phases of the build:
- Installation sets up the environment, activates Python venv, and installs dependencies
- Pre-Build compiles Java source code and test files using JUnit classpath
- Build/Test executes automated tests for Python, Java, and R
- Reports collect the test results and output them in JUnit XML format for AWS CodeBuild reporting
