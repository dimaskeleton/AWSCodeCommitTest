This repository contains Python and Java code used to build/test using AWS codebuild (R with docker to be added)
It is configured to do the following:

1. Install the necessary runtime environments
2. Compile and run tests for both Python and Java code.
3. Creates test reports in JUnit format for both java and python

Structure of the repository:

main-directory
|
|
--- > Buildspec.yml (AWS Codebuild runtime specification)
|
|
--- > python/ (Directory for python code and python tests)
|    |
|    |
|    ---> test_sample.py (Python file with the tests to be run)
|
|
--- > java/ (Directory for java code and java tests)
    |
    |
    --- > CommitExampleTest.java (Java file with the tests to be run)



The buildspec controls how the AWS Codebuild module builds and tests the code in the repository
This is the current buildspec:

            version: 0.2

            phases:
            install:
                runtime-versions:
                python: 3.9
                java: corretto11
                commands:
                - pip3 install pytest
                - mkdir -p lib
                - curl -Lo lib/junit-platform-console-standalone.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.7.1/junit-platform-console-standalone-1.7.1.jar

            pre_build:
                commands:
                - echo "Compiling Java sources:"
                - mkdir -p out
                - javac -d out java/CommitExample.java
                - echo "Compiling Java tests:"
                - javac -cp lib/junit-platform-console-standalone.jar:out -d out java/CommitExampleTest.java

            build:
                commands:
                - echo "Running Python tests:"
                - python -m pytest --junitxml=reports/python-results.xml
                - echo "Running Java tests:"
                - java -jar lib/junit-platform-console-standalone.jar -cp out --select-class CommitExampleTest --reports-dir=reports/java

            artifacts:
            files:
                - '*...      

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
  
Phases that are run: 

1. Installation
- Installs Python 3.9 and Java Corretto 11
- Installs pytest for running Python tests
- Downloads the junit-platform-console-standalone JAR file needed for running JUnit tests in Java 

2. Pre-Build
- Compiling Java sources: Compiles CommitExample.java to the out directory
- Compiling Java tests: Compiles CommitExampleTest.java, adding the JUnit library and compiled source files to the classpath

3. Build Phase 
- Runs the Python and Java tests using pytest and JUnit storing the results in JUnit XML format for reporting
- Test reports from Python and Java tests are stored in the reports/directory, with formats compatible with JUnit XML reporting
