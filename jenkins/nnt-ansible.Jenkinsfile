pipeline {
    agent any

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

        // Add more stages if needed...
    }
}
