pipeline {
    agent any
    parameters{
      string(
        name: 'TICKET',
        description: 'Mention the ticket to update the release status',
        defaultValue: '')
      string(
        name: 'VERSION',
        description: 'CLASHBOARD_VARIABLE_VERSION to release',
        defaultValue: '')        
      choice(
        name: 'ENVIRONMENT',
        description: 'Select the environment in which you wish to run Ansible Playbook',
        choices: 'DEV\nQA\nPROD')
    }
    environment {
        def DEV = '_dev'
        def QA = '_qa'
    }
    stages {
        stage('Ansible Playbook to stop the scheduler') {
            steps {
                script {
                    echo "$TICKET"
                    echo "$VERSION"
                    if (params.ENVIRONMENT == 'DEV') {
                        sh 'ansible-playbook -i inventory/scheduler_release${DEV}.ini playbooks/scheduler_release_stop.yaml'
                    } else if (params.ENVIRONMENT == 'QA') {
                        sh 'ansible-playbook -i inventory/scheduler_release${QA}.ini playbooks/scheduler_release_stop.yaml'
                    } else if (params.ENVIRONMENT == 'PROD') {
                        sh 'ansible-playbook -i inventory/scheduler_release.ini playbooks/scheduler_release_stop.yaml'
                    } else {
                        currentBuild.result = 'FAILURE'
                        error ('Aborted')
                    }
                }
            }
        }
        stage('User Input Check') {
            steps {
                script {
                    try {
                        timeout(time:1, unit:'DAYS') {
                            input message: 'Has the config update (if any) for this release been merged?'
                        }
                    } catch(err) { // timeout reached or input false
                        currentBuild.result = 'FAILURE'
                        error ('Aborted')
                    }
                }
            }
        }
        stage('Ansible Playbook to start the scheduler') {
            steps {
                script {
                    if (params.ENVIRONMENT == 'DEV') {
                        sh 'ansible-playbook -i inventory/scheduler_release${DEV}.ini playbooks/scheduler_release_start.yaml'
                    } else if (params.ENVIRONMENT == 'QA') {
                        sh 'ansible-playbook -i inventory/scheduler_release${QA}.ini playbooks/scheduler_release_start.yaml'
                    } else if (params.ENVIRONMENT == 'PROD') {
                        sh 'ansible-playbook -i inventory/scheduler_release.ini playbooks/scheduler_release_start.yaml'
                    } else {
                        currentBuild.result = 'FAILURE'
                        error ('Aborted')
                    }
                }
            }
        }
    }
}
