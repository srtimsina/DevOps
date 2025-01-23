pipeline {
    agent {
        label 'builtinNode'
    }
    stages {
        stage('Build Application') {
            steps {
                sh 'mvn -f jenkins/java-tomcat-sample/pom.xml clean package'
            }
            post {
                success {
                    echo "Now Archiving the Artifacts...."
                    archiveArtifacts artifacts: '**/*.war'
                }
            }
        }
        stage('Create Tomcat Image') {
            agent {
                label 'testnode'
            }
            steps {
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
                echo "Building docker image"
                sh '''
                original_pwd=$(pwd -P)
                cd jenkins/java-tomcat-sample
                docker build -t localtomcatimg:$BUILD_NUMBER .
                cd $original_pwd
                sh '''
            }
        }
        stage('Deploy to Stagging Env') {
            agent {
                label 'testnode'
            }
            steps {
                echo "Running app on stagging env"
                sh '''
                docker stop tomcatInstanceStaging || true
                docker rm tomcatInstanceStaging || true
                docker run -itd --name tomcatInstanceStaging -p 8082:8080 localtomcatimg:$BUILD_NUMBER
                sh '''
            }
        }
        stage('Deploy Production Environment') {
            agent {
                label 'testnode'
            }
            steps {
                timeout(time:1, unit:'DAYS'){
                input message:'Approve PRODUCTION Deployment?'
                }
                echo "Running app on Prod env"
                sh '''
                docker stop tomcatInstanceProd || true
                docker rm tomcatInstanceProd || true
                docker run -itd --name tomcatInstanceProd -p 8083:8080 localtomcatimg:$BUILD_NUMBER
                '''
            }
        }
    }
    post { 
        always { 
            mail to: 'devopsuryaraj@gmail.com',
            subject: "Job '${JOB_NAME}' (${BUILD_NUMBER}) is waiting for input",
            body: "Please go to ${BUILD_URL} and verify the build"
        }
        success {
            mail bcc: '', body: """Hi Team,

Build #$BUILD_NUMBER is successful, please go through the url

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: '', from: '', replyTo: '', subject: 'BUILD SUCCESS NOTIFICATION', to: 'devopsuryaraj@gmail.com'
        }
        failure {
            mail bcc: '', body: """Hi Team,
            
Build #$BUILD_NUMBER is unsuccessful, please go through the url

$BUILD_URL

and verify the details.

Regards,
DevOps Team""", cc: '', from: '', replyTo: '', subject: 'BUILD FAILED NOTIFICATION', to: 'devopsuryaraj@gmail.com'
        }
    }
}
