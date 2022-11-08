pipeline {
    agent { label 'jenkinsAgentV2' }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {


                withKubeConfig([credentialsId: 'education-eks-qEGL8L5J-kube_config']) {
                    sh 'echo "test"'
                //sh 'kubectl get all'
                }


                echo 'Deploying....'
            }
        }
    }
}