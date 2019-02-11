pipeline {
    agent any
    parameters{
      string(
        name: 'REL_TICKET',
        description: 'Mention the REL Ticket to update the release status',
        defaultValue: 'INESH_123')
      string(
        name: 'VERSION',
        description: 'CLASHBOARD_VARIABLE_VERSION to release',
        defaultValue: '200000-56')        
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
        stage('GIT SCM Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Ansible Playbook to stop the scheduler') {
            steps {
                script {
                    if (params.ENVIRONMENT == 'DEV') {
                        echo "ansible-playbook -i inventory/scheduler_release${DEV}.ini playbooks/scheduler_release_stop.yaml"
                    } else if (params.ENVIRONMENT == 'QA') {
                        echo "ansible-playbook -i inventory/scheduler_release${QA}.ini playbooks/scheduler_release_stop.yaml"
                    } else if (params.ENVIRONMENT == 'PROD') {
                        echo "ansible-playbook -i inventory/scheduler_release.ini playbooks/scheduler_release_stop.yaml"
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
                        echo "ansible-playbook -i inventory/scheduler_release${DEV}.ini playbooks/scheduler_release_start.yaml"
                    } else if (params.ENVIRONMENT == 'QA') {
                        echo "ansible-playbook -i inventory/scheduler_release${QA}.ini playbooks/scheduler_release_start.yaml"
                    } else if (params.ENVIRONMENT == 'PROD') {
                        echo "ansible-playbook -i inventory/scheduler_release.ini playbooks/scheduler_release_start.yaml"
                    } else {
                        currentBuild.result = 'FAILURE'
                        error ('Aborted')
                    }
                }
            }
        }
    }
}
