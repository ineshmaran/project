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
        description: 'Select the ini file (dev/qa/prod)',
        choices: 'scheduler_release_dev.ini\nscheduler_release_qa.ini\nscheduler_release.ini')
    }
    stages {
        stage('Ansible Playbook to stop the scheduler') {
            steps {
                script {
                    if (params.TICKET == '' || params.VERSION == '') {
                        currentBuild.result = 'ABORTED'
                        error ('TICKET or VERSION should not be empty')
                    }
                    sh 'ansible-playbook -i inventory/"$ENVIRONMENT" playbooks/scheduler_release_stop.yaml'
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
                    sh 'ansible-playbook -i inventory/"$ENVIRONMENT" playbooks/scheduler_release_start.yaml'
                }
            }
        }
    }
}
