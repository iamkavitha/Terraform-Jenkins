
pipeline {

    agent any

    parameters {
        booleanParam(
            name: 'autoApprove',
            defaultValue: false,
            description: 'Automatically run apply after generating plan?'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {

        stage('Checkout') {
            steps {
                dir('terraform') {
                    git 'https://github.com/iamkavitha/Terraform-Jenkins.git'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }

        stage('Approval') {
            when {
                expression {
                    return !params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'

                    input(
                        message: 'Do you want to apply the Terraform plan?',
                        parameters: [
                            text(
                                name: 'Plan',
                                description: 'Review the Terraform plan before approving',
                                defaultValue: plan
                            )
                        ]
                    )
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline completed successfully.'
        }

        failure {
            echo 'Terraform pipeline failed.'
        }
    }
}

