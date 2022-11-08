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

                withCredentials([file(credentialsId: 'education-eks-qEGL8L5J-kube_config', variable: 'KUBECONFIG')]) {
                    sh 'kubectl config use-context arn:aws:eks:us-east-2:725337377563:cluster/education-eks-qEGL8L5J'
                    sh 'kubectl get all'
                }


                echo 'Deploying....'
            }
        }
    }
}