pipeline {
    agent { label 'jenkinsAgentV2' }
    options {
        disableConcurrentBuilds()
    }

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
        stage('Pre-Checkout Cleanup'){
            steps {
                sh "echo ${env.BRANCH_NAME}"
                cleanWs()
            }
        }

        stage('log into kube'){
            steps {
                // withKubeConfig([credentialsId: 'education-eks-qEGL8L5J-kube_config']) {
                    ssh 'echo "test"'
                //sh 'kubectl get all'
                // }
            }
        }

    }

    // stage('Checkout') {

    //     steps {
    //         //sh "####################################"
    //         //sh "echo ${TEST}"
    //         //sh "####################################"
    //             sh "echo branch name ${env.BRANCH_NAME}"
    //             checkout([$class: 'GitSCM', 
    //             branches: [
    //                //[name: "**"],
    //                // [name: "*/${env.BRANCH_NAME}"],
    //                 //[name: "*/master"]
    //                 [ name: "refs/heads/${env.BRANCH_NAME}" ]
    //             ], 
    //             doGenerateSubmoduleConfigurations: false,
    //             extensions: [
    //                 // [$class: 'LocalBranch', 
    //                 // localBranch: "*/master"],

    //                 // [$class: 'CloneOption',
    //                 // depth: 0,
    //                 // noTags: false,
    //                 // reference: '',
    //                 // shallow: false]
    //             ],
    //             submoduleCfg: [],
    //             userRemoteConfigs: [[credentialsId: '', url: "${env.GIT_URL_PAT}" ]]])
    //         //cleanWs disableDeferredWipeout: true, deleteDirs: true
    //         //sh "echo ${env.PATH2}"
    //         dir("bin") {
    //         //dir("${params.SCM_REPO}/bin") {

    //             sh """
    //             pwd
    //             ls -la
    //             """


    //             git branch: 'main', url: "${env.GIT_IAC_SCRIPT_REPO}"




    //             sh """
    //             pwd
    //             ls -la
    //             """
    //             //sh 'env'
    //             //sh "git branch"
    //             //sh "pwd"
    //             //sh "git branch -a"
    //             //sh "echo ##### Setting ENVIRONMENT #####"
    //             //sh "python ./__init__.py --get-changed-files-only > /tmp/${IAC_DIR_LIST}"
    //             //sh "echo WORKING WITH DIRECTORIES: \$(cat /tmp/${IAC_DIR_LIST} | tail -1)"
 
    //             //sh "echo environment: ${BUILD_ENVIRONMENT}"
    //             // script {
    //             // // OPTION 1: set variable by reading from file.
    //             // // FYI, trim removes leading and trailing whitespace from the string
    //             // myVar = readFile('myfile.txt').trim()
    //             // }
    //             //sh "echo RANDOM $RAN"
    //             //sh "echo RANDOM \$RAN"

    //             // tmp_param =  sh (script: "python ./__init__.py --get-changed-files-only | tail -1 | awk -F '/' '{ print \$4 }'", returnStdout: true).trim()
    //             // params.BUILD_ENVIRONMENT = tmp_param

    //             // sh "echo ${BUILD_ENVIRONMENT}"
                

    //         }
    //     }
    // }

    // environment {
    //     DEBUG = false
    //     //ENABLE_SNYK_TEST = false
    //     //ENABLE_LINT_TEST = true
    //     TEST = sh(script: "cd ${params.SCM_REPO} && ls -l", returnStdout: true)
    // }
    // stage ('Prerequisites'){
    //     stages {
    //         stage('validate environment') {
    //             steps {
    //                 //dir("${params.SCM_REPO}") {
    //                     sh "ls -la"
    //                     sh "pwd"
    //                     sh "git --no-pager branch"
    //                     sh "${BUILD_SCRIPT_DIR}/validation_script_branch.sh"
    //                     // script {
    //                     //     BUILD_ENVIRONMENT = readFile("/tmp/${env.TEMP_FILE_NAME}").trim()
    //                     // }
    //                     // sh """
    //                     // echo #####################################################################
    //                     // echo Setting ENVIRONMENT: ${BUILD_ENVIRONMENT}
    //                     // echo #####################################################################
    //                     // """
    //                 //}
    //             }
    //         }
    //     }
    // }


    // stage('Snyk IaC Security Test') {
    //     when {
    //         allOf {
    //             expression { return params.ENABLE_SNYK_TEST }
    //             not { branch 'main' }
    //         }
    //     }
    //     steps {
    //         //dir("${params.SCM_REPO}") {
    //            // echo 'Security Testing IaC...'
    //         sh "${BUILD_SCRIPT_DIR}/snyke-test.sh"
    //         //}
    //     }
    // }


    // stage('Lint IaC') {
    //     when {
    //         //expression { "${env.ENABLE_LINT_TEST}".toBoolean() }
    //         allOf {
    //             expression { return params.ENABLE_LINT_TEST }
    //             not { branch 'main' }
    //         }
    //     }
    //     steps {
    //         //dir("${params.SCM_REPO}") {
    //             //echo 'Linting IaC...'
    //             sh "${BUILD_SCRIPT_DIR}/lint.sh"
    //         //}
    //     }
    // }


    // stage('IaC Plan') {
 
    //     when {
    //         //expression { "${env.ENABLE_LINT_TEST}".toBoolean() }
    //         allOf {
    //             //expression { return params.ENABLE_GIT_PR }
    //             //not { branch 'release-' }
    //             not { branch "release-*" }
    //             //expression { BUILD_ENVIRONMENT ==~ /(stg|prd)/ }
    //         }
    //     }
    //     steps {
    //         //print 'Create Github Pull Request'
    //         sh """
    //         #!/bin/bash
    //         pwd
    //         git --no-pager branch
    //         git --no-pager config --list
    //         """
        
    //         sh "${BUILD_SCRIPT_DIR}/__init__.py"
    //     }
          
    // }


//     stage('Create release') {
//         // environment {
//         //     BUILD_ENVIRONMENT = "${BUILD_ENVIRONMENT}"
//         //     //WORKING_D = readFile("/tmp/${env.IAC_DIR_LIST}").trim()
//         //     WORKING_DIR = sh(script: "cat /tmp/${env.IAC_DIR_LIST} | tail -1", returnStdout: true).trim()
//         // }

//         stages {
//             stage('Create PR to release branch (prd)') {
//                 when {
//                     //expression { "${env.ENABLE_LINT_TEST}".toBoolean() }
//                     allOf {
//                         expression { return params.ENABLE_GIT_PR }
//                         //not { branch 'release-' }
//                         branch "prd-*"
//                         //expression { BUILD_ENVIRONMENT ==~ /(stg|prd)/ }
//                     }
//                 }
//                 steps {
//                     print 'Create Github Pull Request'
//                     //sh "echo Setting ENVIRONMENT: ${BUILD_ENVIRONMENT}"
//                     //dir("${params.SCM_REPO}") {
//                         sh """
//                         #!/bin/bash
//                         ${BUILD_SCRIPT_DIR}/create-release-branchv3.sh
//                         """
//                     //}
//                 }
//             }
//             stage('Auto merge with release (non-prd)') {
//                 when {
//                     allOf {
//                         expression { return params.ENABLE_GIT_PR }
//                         //not { branch 'release-' }
//                         //anyOf { 
//                         not { branch "release-*" }
//                         not { branch "prd-*" }
//                         //}
//                     }
//                 }
//                 steps {
//                     print 'Auto merge with release- branch '
//                     //sh "echo Setting ENVIRONMENT: ${BUILD_ENVIRONMENT}"
//                     //dir("${params.SCM_REPO}") {
//                         sh """
//                         #!/bin/bash
//                         pwd
//                         ls -la
//                         git --no-pager branch
//                         ${BUILD_SCRIPT_DIR}/create-release-branchv3.sh
//                         """
//                     //}
//                 }
//             }
//         }
//     }


//     stage('Deploy') {
//         when {
//             anyOf {
//                 branch 'release-*'
//                 //expression { BUILD_ENVIRONMENT ==~ /(sbx|dev)/ }
//             }
//         }
//         steps {
//             //withCredentials([usernamePassword(credentialsId: "${GIT_CRED_ID}", usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {
//                 //dir("${params.SCM_REPO}") {
//                 sh """
//                 #!/bin/bash
//                 pwd
//                 git --no-pager branch
//                 git --no-pager config --list
//                 """
//                 sh "${BUILD_SCRIPT_DIR}/__init__.py"

//                 //}
//             //}
//         }
//     }


//    stage('Merge release- branch with master') {
//         when {
//             anyOf {
//                 branch 'release-*'
//                 //expression { BUILD_ENVIRONMENT ==~ /(sbx|dev)/ }
//             }
//         }
//         steps {
//             //dir("${params.SCM_REPO}") {

//                 // sh "ls -la"
//                 // sh "pwd"
//                 // sh "git checkout master"
//                 // sh "git --no-pager branch"
//                 // sh "git merge ${env.BRANCH_NAME}"
//                 // sh "git pull"
//                 // sh "git push origin master"

//             sh "${BUILD_SCRIPT_DIR}/merge-release.sh"

//                 //sh "git commit -am 'Merged relase branch to master'"
//                 //sh "git push origin master"

//             //}

//         }
//     }

//     // stage ('Cleanup') {
//     //     steps {
//     //         cleanWs disableDeferredWipeout: true, deleteDirs: true
//     //     }
//     // }

//     }


    // post {
    //     always {
    //         sh "echo ${env.BRANCH_NAME}"
    //         //cleanWs disableDeferredWipeout: true, deleteDirs: true
    //     }
    // }
}

