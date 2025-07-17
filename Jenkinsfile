pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'chaimawertani/foyer:1.1.0'
        DOCKERHUB_USER = 'chaimaWertani'
        DOCKERHUB_PASSWORD = 'chaima@52'
    }

    stages {

        stage('Git Checkout') {
            steps {
                echo '📦 Récupération du code source depuis Git...'
                git branch: 'master',
                    url: 'https://github.com/Chaima-W/Devops.git'
            }
        }

        stage('Maven Clean') {
            steps {
                echo '🧹 Nettoyage du projet Maven...'
                sh 'mvn clean'
            }
        }

        stage('Maven Compile') {
            steps {
                echo '🔧 Compilation du projet...'
                sh 'mvn compile'
            }
        }

        stage('Analyse SonarQube') {
            steps {
                echo '🔍 Analyse de la qualité du code avec SonarQube...'
                sh 'mvn sonar:sonar -Dsonar.projectKey=foyer -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=admin -Dsonar.password=sonar'
            }
        }

        stage('Maven Package') {
            steps {
                echo '📦 Création du livrable (JAR)...'
                sh 'mvn package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                echo '🐳 Construction de l’image Docker...'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Docker Push') {
            steps {
                echo '📤 Push de l’image sur Docker Hub...'
                sh "echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USER} --password-stdin"
                sh "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Déploiement avec Docker Compose') {
            steps {
                echo '🚀 Déploiement de l’application avec docker-compose...'
                sh 'docker compose down -v --remove-orphans'
                sh 'docker compose up -d'
            }

        }
    }
}