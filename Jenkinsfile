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
                sh 'mvn sonar:sonar -Dsonar.projectKey=foyer -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqa_ba1a528ca3c90c207150c059a310eb0c49a34b36 '
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
        script {
            withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker push chaimawertani/foyer:1.1.0
                '''
            }
        }
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