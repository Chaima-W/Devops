pipeline {
    agent any

    stages {
        stage('Git') {
            steps {
                echo 'Recup Code de Git : ';
                git branch : 'master',
                url :'https://github.com/Chaima-W/Devops.git';
            }
        }

        stage('Maven Clean') {
            steps {
                echo 'Nettoyage du Projet : ';
                sh 'mvn clean';
            }
        }

        stage('Maven Compile') {
            steps {
                echo 'Construction du Projet : ';
                sh 'mvn compile';
            }
        }

        stage('SonarQue') {
            steps {
                echo 'Analyse de la Qualité du Code : ';
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar';
            }
        }

        stage('Maven Package') {
            steps {
                echo 'Création du livrable : ';
                sh 'mvn package -DskipTests';
            }
        }

        stage('Image') {
            steps {
                echo 'Création Image : ';
                sh 'docker build -t chaimaouertani/foyer:1.0.0 .';
            }
        }

        stage('Dockerhub') {
            steps {
                echo 'Push Image to dockerhub : ';
                sh 'docker login -u chaimaWertani -p chaima@52';
                sh 'docker push chaimaouertani/foyer:1.0.0 ';
            }
        }

        stage('Docker-Compose') {
            steps {
                echo 'Staet Backend + DB : ';
                sh 'docker compose up -d';
            }
        }

    }
}