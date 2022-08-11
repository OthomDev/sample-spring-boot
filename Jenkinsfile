def img
pipeline {
    agent any
    environment {
        registry = "othom/springboot-app"
        registrycredential = 'dockerhub'
        dockerimage = ''
    }
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
                          sh "${scannerHome}/bin/sonar-scanner"
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
         stage ('Build') {
            steps {
                sh 'mvn clean install'           
            }
        }
        stage('Build Image') {
            steps {
                script {
                    // reference: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
                    img = registry + ":${env.BUILD_ID}"
                    // reference: https://docs.cloudbees.com/docs/admin-resources/latest/plugins/docker-workflow
                    dockerImage = docker.build("${img}")
                }
            }
        }
        stage('Push To DockerHub') {
            steps {
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com ', registryCredential ) {
                        // push image to registry
                        dockerImage.push()
                    }
                }
            }
        }
       
        
    }
    
}
