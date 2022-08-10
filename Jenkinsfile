pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    stages {
        stage('Git') {
            steps {
                // Get some code from a GitHub repository
                git url: 'https://github.com/OthomDev/sample-spring-boot.git'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn --version'
                sh 'mvn test'
            }
        }
        stage('SonarCloud analysis') {
            steps{
                script{
                    def scannerHome = tool 'scanner';
                      withSonarQubeEnv('SonarCloud') {
                          sh "${scannerHome}/bin/sonar-scanner  -Dsonar.projectKey=demo-othom -Dsonar.projectName=spring-boot -Dsonar.organization= test-othom  -Dsonar.sourceEncoding=UTF-8 -Dsonar.sources=src"
                      }
                }
            }
        
        }
        stage('Quality gate') {
           steps {
                script {
                      timeout(time: 5, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                       }
                 }
           }
         }
       
        
    }
    
}
