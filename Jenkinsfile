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

            	git branch: appBranch , url: 'https://github.com/marbdevops/devops-b-jenkins-test.git'
        
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
                withCredentials([string(credentialsId: 'DOCKER_TKN', variable: 'DOCKER_PASSWD')]) 
                {
                
                    sh 'docker build . -t marbdevops/k8s-test:latest'
                    sh 'docker login -u marbdevops -p ${DOCKER_PASSWD}'
                    sh 'docker push marbdevops/k8s-test:latest'
                }

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
                    // kubectl apply -f <fileName>.yml
                    sh 'kubectl --server=https://15DA1EF22B8553538C2AADA7B36E2046.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6IlViT1lSWGZZYTRjM1JrRzBJU2VrOUlOWFUtMW1kTlVvRUpZNlRYaEtYelkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImUwYjg3MmIzLTFhZDUtNGE4YS04OGE5LWZlNDNjZmE3ZGUyMyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.ca9MKLWpKg-TnhQqEvqSGpQEXKM16KL55E8tBTJhGqCVLAVdon5UPcTlWETYQbmFT1P0gd9ikoJL3g9ypKuJsv34nZ3AcpY-z2xNpKTCQFyjzoe3TTE2U7s2pHZTMqaBhf6KIKumjGbeEcFt1xEk5QYkkqx5_lyTEx90m0PioAS0oQFKb51mIcMLseE5Aj1iVPvqLBCic-tkIGtOH3oSOUJEagUMSpz0FPVR4a_XtCrV37k054ZG1x_iWoGXdErTNEZEZJjkm87DZTziVR4EHvpSgRppgVyo0d6prwZ2TK7KYgB88bhm6hRezXP3HjyXs6xPgeaU7Axb1m8RA7V5HA" apply -f deployment.yml'

                    sh 'kubectl --server=https://15DA1EF22B8553538C2AADA7B36E2046.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6IlViT1lSWGZZYTRjM1JrRzBJU2VrOUlOWFUtMW1kTlVvRUpZNlRYaEtYelkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImUwYjg3MmIzLTFhZDUtNGE4YS04OGE5LWZlNDNjZmE3ZGUyMyIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.ca9MKLWpKg-TnhQqEvqSGpQEXKM16KL55E8tBTJhGqCVLAVdon5UPcTlWETYQbmFT1P0gd9ikoJL3g9ypKuJsv34nZ3AcpY-z2xNpKTCQFyjzoe3TTE2U7s2pHZTMqaBhf6KIKumjGbeEcFt1xEk5QYkkqx5_lyTEx90m0PioAS0oQFKb51mIcMLseE5Aj1iVPvqLBCic-tkIGtOH3oSOUJEagUMSpz0FPVR4a_XtCrV37k054ZG1x_iWoGXdErTNEZEZJjkm87DZTziVR4EHvpSgRppgVyo0d6prwZ2TK7KYgB88bhm6hRezXP3HjyXs6xPgeaU7Axb1m8RA7V5HA" apply -f service.yml'

                    echo "done"

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
