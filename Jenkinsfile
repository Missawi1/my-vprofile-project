pipeline{
    agent any
    tools {
        maven "MAVEN"
        JDK "JDK8"
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
        stage("Build"){
            steps{
                sh 'mvn install -Dskiptest'
            }
            post{
                always{
                    echo "Now archiving..."
                }
                success{
                    echo "...Archiving...."
                    archiveArtifacts artifacts: "**/target/*.war"
                }
                failure{
                    echo "Archiving failed"
                }
            }
        }
        stage("Unit test"){
            steps{
                sh "mvn clean test"
            }
            post{
                always{
                    echo "Unit test has started running..."
                }
                success{
                    echo "Unit test passed..."
                }
                failure{
                    echo "Unit test failed..."
                }
            }
        }
        stage("Checkstyle"){
            steps{
                sh "mvn checkstyle:checkstyle" 
            }
            post{
                always{
                    echo "Checkstyle started..."
                }
                success{
                    echo "====++++Checkstyle executed successfully++++===="
                }
                failure{
                    echo "====++++Checkstyle execution failed++++===="
                }
            }
        }
        stage("Quality Test"){
            steps{
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
            post{
                always{
                    echo "====++++Quality test started++++===="
                }
                success{
                    echo "====++++Quality Test executed successfully++++===="
                }
                failure{
                    echo "====++++Quality Test execution failed++++===="
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