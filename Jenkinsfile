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

            	git branch: appBranch , url: 'https://github.com/pythonlifedevops/aws-b-maven-app.git'
        
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
                
                    sh 'docker build . -t pylifedevops/awsb1cicd:latest'
                    sh 'docker login -u pylifedevops -p ${DOCKER_PASSWD}'
                    sh 'docker push pylifedevops/awsb1cicd:latest'
                }

         }
    }



    stage ('K8SManiFest-Checkout') {
                steps {

                    git 'https://github.com/pythonlifedevops/aws-k8s-cicd.git'

                }
            }

    stage ('Kubernetes AutoDeployment') {
  

                steps {

                    dir('manifests')
                     {

                    sh 'ls -l'
                    // kubectl apply -f <fileName>.yml
                    sh 'kubectl --server=https://5FECAB6F0CE4AD34855CED15E679D5EC.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6Ii1pdVJ4TEVLRDVwUndmeWt1NmxpWmg3VWJGZkNHVkVobnhtLXJpNVBGbW8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjdmZTE3MmM0LWYzMDYtNDBhMS1hNDEyLWY1YzZlM2JmZWZhYiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.dfJHL5qZrMTocda-pd9GmTTWV0-LcIHhhNLR246CTQNMkwr1oQDErUqkBmxfBubgJ0KYqa_u8dgTGtlMWFM4G_NyewJXv-5QOfjokfFE6wzHX70Uoei8tmphxILeLdxi-LwUOBanM4_KloTkC4SlEBkIUNoiE8ZNQTsNSj7oyrP6YR-_RkHEapNAA5BZgkDBI2afL-6yj8sklfLb3oFqN0jPW_uw0w9FVJFe5HHYanWT6oyQ9A3RG5yANy65qfq2IJEU19IDZGqB_Dp5EWFOa0-TXTvaaY8BnfTuBotjlDWD16jTdACLfq-1bfJA0OkwssQ3W3eHTX2LlyUVAfE_aA" apply -f deployment.yml'

                    sh 'kubectl --server=https://5FECAB6F0CE4AD34855CED15E679D5EC.gr7.us-east-1.eks.amazonaws.com --insecure-skip-tls-verify --token="eyJhbGciOiJSUzI1NiIsImtpZCI6Ii1pdVJ4TEVLRDVwUndmeWt1NmxpWmg3VWJGZkNHVkVobnhtLXJpNVBGbW8ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjdmZTE3MmM0LWYzMDYtNDBhMS1hNDEyLWY1YzZlM2JmZWZhYiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmplbmtpbnMifQ.dfJHL5qZrMTocda-pd9GmTTWV0-LcIHhhNLR246CTQNMkwr1oQDErUqkBmxfBubgJ0KYqa_u8dgTGtlMWFM4G_NyewJXv-5QOfjokfFE6wzHX70Uoei8tmphxILeLdxi-LwUOBanM4_KloTkC4SlEBkIUNoiE8ZNQTsNSj7oyrP6YR-_RkHEapNAA5BZgkDBI2afL-6yj8sklfLb3oFqN0jPW_uw0w9FVJFe5HHYanWT6oyQ9A3RG5yANy65qfq2IJEU19IDZGqB_Dp5EWFOa0-TXTvaaY8BnfTuBotjlDWD16jTdACLfq-1bfJA0OkwssQ3W3eHTX2LlyUVAfE_aA" apply -f service.yml'

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
