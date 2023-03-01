pipeline{
    agent any
    tools {
        maven "MAVEN"
        jdk "JDK8"
    }
    environment {
        
    }
    stages{
        stage("Fetch Code"){
            steps{
                git branch: "master", url: "https://github.com/Missawi1/my-vprofile-project.git"
            }
            post{
                always{
                    echo "========fetching updated files...========"
                }
                success{
                    echo "========Files fetched successfully.========"
                }
                failure{
                    echo "========Failed to fetch files.========"
                }
            }
        }
        stage("A"){
            steps{
                echo "====++++executing A++++===="
            }
            post{
                always{
                    echo "====++++always++++===="
                }
                success{
                    echo "====++++A executed successfully++++===="
                }
                failure{
                    echo "====++++A execution failed++++===="
                }
        
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}