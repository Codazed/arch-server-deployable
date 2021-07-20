pipeline {
    agent any

    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Pull from SCM') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/Codazed/arch-server-deployable'
            }
        }
        stage('Build Docker container') {
            steps {
                sh 'docker build --tag ${JOB_NAME} .'
            }
        }
        stage('Build ISO') {
            steps {
                sh 'docker run --rm --privileged -v ${WORKSPACE}/artifacts:/artifacts -v ${WORKSPACE}/config:/iso-config ${JOB_NAME} /usr/bin/mkarchiso -v -o /artifacts /iso-config'
                archiveArtifacts artifacts: 'artifacts/*.iso', followSymlinks: false
            }
        }
        stage('Generate Checksum') {
            steps {
                sh 'sha256sum ${WORKSPACE}/artifacts/*.iso >> ${WORKSPACE}/artifacts/sha256sum.txt'
                archiveArtifacts artifacts: 'artifacts/sha256sum.txt', followSymlinks: false
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
