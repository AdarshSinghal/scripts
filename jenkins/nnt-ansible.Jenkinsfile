def runAnsiblePlaybook(playbookName) {
    sshagent(['nnt-env-ssh-credentials']) {
        sh "ansible-playbook -i ${INVENTORY_FILE} ${PLAYBOOK_PATH}/${playbookName}"
    }
}

pipeline {
    agent any

    environment {
        ANSIBLE_PATH = '/ansible/git/nnt/scripts/ansible'
        INVENTORY_FILE = '${ANSIBLE_PATH}/inventory.yml'
        PLAYBOOK_PATH = '${ANSIBLE_PATH}/playbooks'
        PG_PASSWORD = credentials('NNT-PG-PASSWORD') // Use the appropriate credential ID
    }

    stages {

        stage('Install Git') {
            steps {
                script {
                    runAnsiblePlaybook('01_init_playbook.yml')
                }
            }
        }

        stage('Clone Repo') {
            steps {
                script {
                    runAnsiblePlaybook('02_git_repo_playbook.yml')
                }
            }
        }

        stage('Set up JDK') {
            steps {
                script {
                    runAnsiblePlaybook('03_jdk_setup_playbook.yml')
                }
            }
        }

        stage('Set up Maven') {
            steps {
                script {
                    runAnsiblePlaybook('04_mvn_setup_playbook.yml')
                }
            }
        }

        stage('Set up Postgres') {
            steps {
                script {
                    runAnsiblePlaybook('05_psql_setup_playbook.yml')
                }
            }
        }

        stage('Reset Postgres Password') {
            steps {
                script {
                    def scriptContent = """#!/bin/bash
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '${PG_PASSWORD}'"
"""
                    def path = '/tmp/reset_pwd.sh'
                    writeFile file: path, text: scriptContent
                    sh "chmod +x ${path}"
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "scp -i /root/.ssh/id_rsa ${path} root@139.84.135.9:${path}"
                        sh "ssh -i /root/.ssh/id_rsa root@139.84.135.9 '${path}'"
                    }
                }
            }
        }
    }
}
