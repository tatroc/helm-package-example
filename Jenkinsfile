pipeline {
    agent { label 'jenkinsAgentV2' }


parameters {
        string(name: 'SCM_REPO', defaultValue: 'deployment_demo')
        string(name: 'CRED_AZURE_CLOUD', defaultValue: 'azure-svc-tatro-demo')
        string(name: 'CRED_AWS_CLOUD', defaultValue: 'ctatro-jenkins_aws_ktpsbx')
        //string(name: 'BUILD_ENVIRONMENT', defaultValue: '')

        booleanParam(name: 'ENABLE_SNYK_TEST', defaultValue: true)
        booleanParam(name: 'ENABLE_LINT_TEST', defaultValue: true)
        booleanParam(name: 'ENABLE_GIT_PR', defaultValue: true)
    }


    environment {
        DEBUG = true
        BUILD_SCRIPT_DIR = 'bin'
        //ENABLE_SNYK_TEST = false
        //ENABLE_LINT_TEST = true
        ENABLE_LOCAL_TEST = false
        MY_UUID = sh(script: 'uuidgen', returnStdout: true).trim()
        //IAC_DIR_LIST = sh(script: 'echo $RANDOM | md5sum | head -c 25; echo;', returnStdout: true).trim()
        SCM_REPO = "${params.SCM_REPO}"
        PATH = "${env.PATH}:${env.HOME}/.local/bin"
        GIT_PAT =  credentials("github_tatroc_pat")
        GH_ENTERPRISE_TOKEN = credentials("github_enterprise_ctatro_pat")
        GH_TOKEN = credentials("github_tatroc_pat")
        //AWS_ROLE_TO_ASSUME = "jenkins_test_role"

        GIT_URL_SUFIX = "${iacRepoUrl}".substring(8)
        GIT_URL_PAT = "https://${GIT_PAT}@${GIT_URL_SUFIX}"
        SNYK_API_TOKEN = credentials("snyk_api_token")
        SNYK_TOKEN = credentials("snyk_api_token")
        NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt"
        GIT_IAC_SCRIPT_REPO = "https://${GIT_PAT}@github.com/kna-core/IaCdemo_scripts.git"


        //GIT_USERNAME = credentials("github_enterprise_ctatro_username")
        //GIT_PASSWORD = credentials("github_enterprise_ctatro_pat")
        CRED_AZURE_CLOUD = credentials("${CRED_AZURE_CLOUD}")
        AZURE_CLOUD_USERNAME = "$CRED_AZURE_CLOUD_USR"
        AZURE_CLOUD_PASSWORD = "$CRED_AZURE_CLOUD_PSW"
        
        AZURE_TENANT_ID = credentials('AZURE_TENANT_ID')
        AZURE_CLIENT_SECRET = "$CRED_AZURE_CLOUD_PSW"
        AZURE_CLIENT_ID = "$CRED_AZURE_CLOUD_USR"

        ARM_TENANT_ID = credentials('AZURE_TENANT_ID')
        ARM_CLIENT_SECRET = "$CRED_AZURE_CLOUD_PSW"
        ARM_CLIENT_ID = "$CRED_AZURE_CLOUD_USR"


        CRED_AWS_CLOUD = credentials("${CRED_AWS_CLOUD}")
        AWS_CLOUD_USERNAME = "$CRED_AWS_CLOUD_USR"
        AWS_CLOUD_PASSWORD = "$CRED_AWS_CLOUD_PSW"
        AWS_ACCESS_KEY_ID = "$CRED_AWS_CLOUD_USR"
        AWS_SECRET_ACCESS_KEY = "$CRED_AWS_CLOUD_PSW"

    }

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

                withCredentials([file(credentialsId: 'education-eks-qEGL8L5J-kube-config-file', variable: 'KUBECONFIG')]) {
                    sh 'kubectl config use-context arn:aws:eks:us-east-2:725337377563:cluster/education-eks-qEGL8L5J'
                    sh 'kubectl get all'
                }


                echo 'Deploying....'
            }
        }
    }
}