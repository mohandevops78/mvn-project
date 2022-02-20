pipeline {
  agent 'any'
  tools {
    maven 'mvn'
  }

  stages {
    stage('Intializing the project') {
      steps {
        echo 'Welcome to Intellipaat Labs' 
      }
    }

    stage('Analysing Commit Scanning') {
      steps {
          sh 'mvn test'
          echo 'Commit Scanning competed'
        }    
      }

    stage('Clean Previous Builds') {
      steps {
          
                sh 'mvn clean'
                echo 'Cleaned previous Build'
            }    
        }

    stage('Building Code') {
      steps {
          sh 'mvn -Dmaven.test.failure.ignore=true package'
          echo 'Build complited'
        }
      }

    stage('Static Code Analysis') {
      parallel {
        stage('Checkstyle') {
          steps {
              sh 'mvn checkstyle:checkstyle'
            }    
          }

        stage ('PMD') {
          steps {
              sh 'mvn pmd:pmd'
            }
          }

        stage ('Find-Bugs') {
          steps {
              sh 'mvn findbugs:findbugs'
            }
          }
      }
    }
     
    stage ('Code Test Analysis') {
      parallel {
        stage ('Code Coverage') {
          steps {
              echo 'Running Code Coverage'
            }
          }
      
        stage ('Test Report') {
          steps {
              sh 'mvn surefire-report:report'
            }
          }
      }
      }
      stage ('Variables Testing' ) {
        steps {
           dir('config-dev') {
            echo "Branchname is ${BRANCH_NAME}"
            echo "Build ID is ${BUILD_ID}"
            echo "Path is ${PATH}"
            echo "Workspace is ${WORKSPACE}"
            echo "BuildNumber is ${BUILD_NUMBER}"
            echo "Build URL is ${BUILD_URL}"
            echo "Workspace is ${WORKSPACE}"
          }
        }
      }
    }
    stage ('Publishing Artifacts') {
      steps {
            nexusArtifactUploader artifacts: [
              [
                artifactId: 'app', 
                classifier: '', 
                file: 'target/demo-0.0.1-SNAPSHOT.jar', 
                type: 'jar'
              ]
          ], 
          credentialsId: 'nexus-creds', 
          groupId: 'intellipaat.jenkins.maven', 
          nexusUrl: '54.75.69.104:8081', 
          nexusVersion: 'nexus3', 
          protocol: 'http', 
          repository: 'maven-app', 
          version: '0.0.1-SNAPSHOT'
        }
      }
  }

  post {
    always {
      recordIssues enabledForFailure: true, tools: [mavenConsole(), java(), javaDoc()]
      recordIssues enabledForFailure: true, tool: checkStyle()
      recordIssues enabledForFailure: true, tool: findBugs()
      recordIssues enabledForFailure: true, tool: pmdParser(pattern: '**/target/pmd.xml ')
    }
  }
}
