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
                withCredentials([string(credentialsId: 'DOCKER_TOKEN', variable: 'DOCKER_PASSWD')]) 
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
                    sh 'kubectl --server=https://AB3FBADFD32CF19EE5CF77FB6D775D2E.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6ImtTZGJtQjNQX0ZkbmNocXRUSWs0bEFyREJWZFktWUVNQ3dGdExPOERjbEEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjU5OGM1ZWUwLWQyMTYtNDA3YS1hMmE0LTg4N2NjOGY4NDRjOSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.iKENEBmuc8094JVMt9nZj17Owpx4w_khiwOFaKsP3xO6mqjLPTg45LUVahyPmAFN9kzadbmJZfQq6hKTVQ4bN02TXH8v8OvSCu2Vj-JfN0V-DwdbCZ3QmUjVabGa7vlFbj7WQv_bUAfas8DDsMPCBYIKpierFR-lLRaxmoWGdVDGI1Towt3ySrkVldhHTYqhu9Hu4WUwx9MlK8XfGcLapYlPuS6N2nT7O571WAgPOhgsqqyutX6R5OTGNnQGgHf4fxyCbDBiClu1mwM5AvqHJPe9_vPB9zomPwqtGwTxK9rS0vDdJr9bHSPZvDWq1gPGSg7f9r4owyOeUSDmqn1ObQ" apply -f deployment.yml'

                    sh 'kubectl --server=https://AB3FBADFD32CF19EE5CF77FB6D775D2E.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6ImtTZGJtQjNQX0ZkbmNocXRUSWs0bEFyREJWZFktWUVNQ3dGdExPOERjbEEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjU5OGM1ZWUwLWQyMTYtNDA3YS1hMmE0LTg4N2NjOGY4NDRjOSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.iKENEBmuc8094JVMt9nZj17Owpx4w_khiwOFaKsP3xO6mqjLPTg45LUVahyPmAFN9kzadbmJZfQq6hKTVQ4bN02TXH8v8OvSCu2Vj-JfN0V-DwdbCZ3QmUjVabGa7vlFbj7WQv_bUAfas8DDsMPCBYIKpierFR-lLRaxmoWGdVDGI1Towt3ySrkVldhHTYqhu9Hu4WUwx9MlK8XfGcLapYlPuS6N2nT7O571WAgPOhgsqqyutX6R5OTGNnQGgHf4fxyCbDBiClu1mwM5AvqHJPe9_vPB9zomPwqtGwTxK9rS0vDdJr9bHSPZvDWq1gPGSg7f9r4owyOeUSDmqn1ObQ" apply -f service.yml'

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
