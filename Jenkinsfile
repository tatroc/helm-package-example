pipeline {
    agent { label 'jenkinsAgentV2' }


parameters {
        string(name: 'SCM_REPO', defaultValue: 'deployment_demo')
        string(name: 'CRED_AZURE_CLOUD', defaultValue: 'azure-svc-tatro-demo')
        string(name: 'CRED_AWS_CLOUD', defaultValue: 'ctatro-jenkins_aws_ktpsbx')
        //string(name: 'BUILD_ENVIRONMENT', defaultValue: '')
        string(name: 'ENVIRONMENT', defaultValue: 'qat')
        string(name: 'CLUSTER', defaultValue: '')
        string(name: 'REGION', defaultValue: 'us-east-2')
        string(name: 'VARIANTS', defaultValue: 'npd')
        string(name: 'CLUSTER_TYPE', defaultValue: 'common')
        string(name: 'APPLICATION', defaultValue: 'pythonapp')

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

        // GIT_URL_SUFIX = "${iacRepoUrl}".substring(8)
        // GIT_URL_PAT = "https://${GIT_PAT}@${GIT_URL_SUFIX}"
        SNYK_API_TOKEN = credentials("snyk_api_token")
        SNYK_TOKEN = credentials("snyk_api_token")
        NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt"
        GIT_IAC_SCRIPT_REPO = "https://${GIT_PAT}@github.com/kna-core/IaCdemo_scripts.git"


        //GIT_USERNAME = credentials("github_enterprise_ctatro_username")
        //GIT_PASSWORD = credentials("github_enterprise_ctatro_pat")
        // CRED_AZURE_CLOUD = credentials("${CRED_AZURE_CLOUD}")
        // AZURE_CLOUD_USERNAME = "$CRED_AZURE_CLOUD_USR"
        // AZURE_CLOUD_PASSWORD = "$CRED_AZURE_CLOUD_PSW"
        
        // AZURE_TENANT_ID = credentials('AZURE_TENANT_ID')
        // AZURE_CLIENT_SECRET = "$CRED_AZURE_CLOUD_PSW"
        // AZURE_CLIENT_ID = "$CRED_AZURE_CLOUD_USR"

        // ARM_TENANT_ID = credentials('AZURE_TENANT_ID')
        // ARM_CLIENT_SECRET = "$CRED_AZURE_CLOUD_PSW"
        // ARM_CLIENT_ID = "$CRED_AZURE_CLOUD_USR"
        ENVIRONMENT = "$ENVIRONMENT"
        REGION = "$REGION"
        VARIANTS = "$VARIANTS"
        CLUSTER_TYPE = "$CLUSTER_TYPE"
        APPLICATION = "$APPLICATION"
        CLUSTER = "$CLUSTER"

        CRED_AWS_CLOUD = credentials("${CRED_AWS_CLOUD}")
        AWS_CLOUD_USERNAME = "$CRED_AWS_CLOUD_USR"
        AWS_CLOUD_PASSWORD = "$CRED_AWS_CLOUD_PSW"
        AWS_ACCESS_KEY_ID = "$CRED_AWS_CLOUD_USR"
        AWS_SECRET_ACCESS_KEY = "$CRED_AWS_CLOUD_PSW"

    }

    stages {

    stage('Pre-Checkout Cleanup'){
        steps {
            sh "echo ${env.BRANCH_NAME}"
            cleanWs()
        }
    }

stage('Checkout') {

        steps {
            //sh "####################################"
            //sh "echo ${TEST}"
            //sh "####################################"
                sh "echo branch name ${env.BRANCH_NAME}"
                checkout([$class: 'GitSCM', 
                branches: [
                   //[name: "**"],
                   // [name: "*/${env.BRANCH_NAME}"],
                    //[name: "*/main"],
                    [ name: "refs/heads/${env.BRANCH_NAME}" ]
                ], 
                doGenerateSubmoduleConfigurations: false,
                extensions: [
                    // [$class: 'LocalBranch', 
                    // localBranch: "*/${env.BRANCH_NAME}"],

                    // [$class: 'CloneOption',
                    // depth: 0,
                    // noTags: false,
                    // reference: '',
                    // shallow: false]
                ],
                submoduleCfg: [],
                userRemoteConfigs: [[credentialsId: '', url: "https://${GIT_PAT}@github.com/tatroc/helm-package-example.git" ]]])
            //cleanWs disableDeferredWipeout: true, deleteDirs: true
            //sh "echo ${env.PATH2}"

            sh "git --no-pager branch"
           
        }
    }


        stage ('Prerequisites'){
            steps {
                sh "ls -la"
                sh "mkdir -p ./tmp/$MY_UUID"
            }
        }



        stage('Snyk IaC Security Test') {
                when {
                    allOf {
                        expression { return params.ENABLE_SNYK_TEST }
                        not { branch 'main' }
                    }
                }
                steps {
                    sh "./package.sh --stage-files yes --environment $ENVIRONMENT --region $REGION --variants $VARIANTS --cluster-type $CLUSTER_TYPE --application $APPLICATION"
                    // sh """
                    // VALUES=($(ls ./kubernetes_helm_demo_dev1/tmp/c50aedbb-d868-415e-8bbf-b854e6d2a4ff/*-values.yaml))
                    // for I in "${x[@]}"
                    // do
                    //     VALUES=${VALUES:+$VALUES }"--values $I"
                    // done
                    // helm template ./charts/$CLUSTER_TYPE/$APPLICATION --output-dir ./tmp/$MY_UUID/output
                    // """
                    sh "./create-helm-template.sh"
                    sh "echo 'running snyk test'"
                    sh "snyk iac test ./tmp/$MY_UUID/output"

                }
            }
            stage('helm lint') {
                when {
                    allOf {
                        expression { return params.ENABLE_LINT_TEST }
                        not { branch 'main' }
                    }
                }
                steps {
                    sh "./helm-lint.sh"
                    //sh "./package.sh --stage-files yes --environment $ENVIRONMENT --region $REGION --variants $VARIANTS --cluster-type $CLUSTER_TYPE --application $APPLICATION"
                    //sh "helm template ./charts/$CLUSTER_TYPE/$APPLICATION --output-dir ./tmp/$MY_UUID/output"
                    //sh "snyk iac test ./tmp/$MY_UUID/output"

                }
            }


            stage('create PR') {
                when {
                    allOf {
                        expression { return params.ENABLE_GIT_PR }
                        not { branch 'main' }
                    }
                }
                steps {
                    sh "./create-pr.sh"
                    //sh "./package.sh --stage-files yes --environment $ENVIRONMENT --region $REGION --variants $VARIANTS --cluster-type $CLUSTER_TYPE --application $APPLICATION"
                    //sh "helm template ./charts/$CLUSTER_TYPE/$APPLICATION --output-dir ./tmp/$MY_UUID/output"
                    //sh "snyk iac test ./tmp/$MY_UUID/output"

                }
            }

        stage('Deploy') {
            when {
                allOf {
                    expression { return params.ENABLE_SNYK_TEST }
                    not { branch 'main' }
                }
            }
            steps {
                // configure secret file credential
                withCredentials([file(credentialsId: 'education-eks-qEGL8L5J-kube-config-file', variable: 'KUBECONFIG')]) {
                    sh 'kubectl version'
                    sh 'kubectl config use-context arn:aws:eks:us-east-2:725337377563:cluster/education-eks-qEGL8L5J'
                    sh 'kubectl get all'
                }


                echo 'Deploying....'
            }
        }
    }
}