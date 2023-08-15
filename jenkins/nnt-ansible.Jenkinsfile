pipeline {
    agent any

    environment {
        PG_PASSWORD = credentials('NNT-PG-PASSWORD') // Use the appropriate credential ID
    }

    stages {

        stage('Install Git') {
            steps {
                script {
                    def playbookName = '01_init_playbook.yml'
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "ansible-playbook -i /ansible/inventory.yml /ansible/${playbookName}"
                    }
                }
            }
        }

        stage('Clone Repo') {
            steps {
                script {
                    def playbookName = '02_git_repo_playbook.yml'
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "ansible-playbook -i /ansible/inventory.yml /ansible/${playbookName}"
                    }
                }
            }
        }

        stage('Set up JDK') {
            steps {
                script {
                    def playbookName = '03_jdk_setup_playbook.yml'
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "ansible-playbook -i /ansible/inventory.yml /ansible/${playbookName}"
                    }
                }
            }
        }

        stage('Set up Maven') {
            steps {
                script {
                    def playbookName = '04_mvn_setup_playbook.yml'
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "ansible-playbook -i /ansible/inventory.yml /ansible/${playbookName}"
                    }
                }
            }
        }

        stage('Set up Postgres') {
            steps {
                script {
                    def playbookName = '05_psql_setup_playbook.yml'
                    sshagent(['nnt-env-ssh-credentials']) {
                        sh "ansible-playbook -i /ansible/inventory.yml /ansible/${playbookName}"
                    }
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
