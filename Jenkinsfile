pipeline{
    agent {label 'newdocker'}
    environment {
		DOCKER_LOGIN_CREDENTIALS=credentials('Rajashekar85-Dockerhub')
	}
    stages {
        stage('checkout') {
            steps {
            git branch: 'main', url: 'https://github.com/Rajashekar85/palindrome.git'
            }
        }

        stage('build') {
            steps {
                sh 'mvn clean package'
                sh 'docker build -t rajashekar85/palindrome:$BUILD_NUMBER .'
               }
        }
        stage('jacoco report') {
            steps {
                jacoco()
            }
        }
        stage('SonarQube Analysis Stage') {
            steps{
                withSonarQubeEnv('Jacoco-sonar') {
                 sh "mvn clean verify sonar:sonar -Dsonar.projectKey=palindrome-sonar"
                }
            }
        }
        stage('Snyk scanning code') {
            steps{
                snykSecurity failOnError: false, failOnIssues: false, projectName: 'palindrome', snykInstallation: 'SYNK', snykTokenId: 'SYNK_Jacoco_Token'
            }
        }
        stage('Docker image') {
            steps{
                sh 'echo $DOCKER_LOGIN_CREDENTIALS_PSW | docker login -u $DOCKER_LOGIN_CREDENTIALS_USR --password-stdin'
                sh 'docker push rajashekar85/palindrome:$BUILD_NUMBER'
            }
        }
        stage('deploy') {
            steps{
                sh "docker run -itd rajashekar85/palindrome:$BUILD_NUMBER"
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
