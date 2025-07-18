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
stage('Debug full workspace') {
    steps {
        sh 'pwd'
        sh 'ls -R'
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
// stage('JUnit Tests') {
//             steps {
//                 echo '🧪 Running unit tests with JUnit...'
//                 dir('Foyer2425-main') {
//                     sh 'mvn test'
//                 }
//             }
//         }
        stage('Analyse SonarQube') {
            steps {
                echo '🔍 Analyse de la qualité du code avec SonarQube...'
                sh 'mvn sonar:sonar -Dsonar.projectKey=foyer -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqa_3730e140d0ac48b6f13982c385c9fb724fe60b57'
            }
        }

        stage('Maven Package') {
            steps {
                echo '📦 Création du livrable (JAR)...'
                sh 'mvn package -DskipTests'
            }
        }

       stage('Deploy Artifact to Nexus') {
           steps {
               withCredentials([usernamePassword(credentialsId: 'nexus-maven-creds', usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
                   configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
                       sh 'mvn deploy -s $MAVEN_SETTINGS'
                   }
               }
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
                docker push ${DOCKER_IMAGE}
                '''
            }
        }
    }
}


        stage('Déploiement avec Docker Compose') {
            steps {
                echo '🚀 Déploiement de l’application avec docker-compose...'
//                    sh 'docker-compose -p foyer2425-main down -v --remove-orphans'
                 sh 'docker-compose -p foyer2425-main up -d'
            }

        }
    }
}