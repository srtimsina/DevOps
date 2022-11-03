pipeline {
    agent any
    stages {
        stage('UnitTest') {
            step {
                echo "Hello, we are learning Jekins pipeline as a code"
                echo "Running Unitest"
            }
        }
        stage('Build') {
            step {
                echo "Building the code"
            }
        }
        stage('DeployStaging') {
            step {
                echo "Deploying to staging env"
            }
        }  
        stage('DeployProd') {
            step {
                echo "Deploying to prod env"
            }
        }    
    }
}