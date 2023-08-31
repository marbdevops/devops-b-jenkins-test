pipeline {

    agent {
    	node {
    		label 'java11'
    		}
    }

   //triggers {
     //   cron('H(0-0) 1 * * *')
    //}

    environment {

                 //MyEnv Variables 
                 MYCLASS='DevOPS'
  
    }
    

    options     {
                timestamps()
                buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
                timeout(time: 240, unit: 'MINUTES')
                disableConcurrentBuilds()
                }

    parameters {
            string(name: 'appBranch', defaultValue: 'main', description: "Application Branch name of the Repo")
                }


    stages {
        stage('App-Code-Checkout-GitHUB') {
            steps {

            	git branch: 'main' , url: 'https://github.com/marbdevops/devops-b-jenkins-test.git'
        
                //echo 'Hello World'
                //sh 'hostname'
            }
        }

    stage('Maven Build') {
          steps {
        
        	  	sh 'mvn clean package'
        	 
            }
        }


    stage('Docker Build') {
            steps {
                 
                
                
                    sh 'docker build . -t marbdevops/k8s-test2:latest'
                    sh 'docker login -u marbdevops -p dckr_pat_QVafKTR1KUAvYU60ZiAC_VCeGuI'
                    sh 'docker push marbdevops/k8s-test2:latest'
                

         }
    }



    stage ('K8SManiFest-Checkout') {
                steps {

                    git 'https://github.com/marbdevops/devops-k8s-cicd.git'

                }
            }

    stage ('Kubernetes AutoDeployment') {
  

                steps {

                    dir('manifests')
                     {

                    sh 'ls -l'
                    
                    sh 'kubectl apply -f deployment.yml'
                    sh 'kubectl apply -f service.yml'
                   

                    sh 'kubectl get deployments'
                    sh 'sleep 100 ; kubectl get services'
                    
                    }

                    }
                }
    stage('Archive and clean workspace') {
                steps {
                    
                    //archive 'target/demo*.jar'
                    archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
                    cleanWs()
                }

            }                
        
        }
    }
