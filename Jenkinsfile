node {
   stage('Git Code Checkout') { // for display purposes
      // Get some code from a GitHub repository
      git url: 'git@github.com:abirdatta/SimpleSpringMvcHelloWorld.git', branch: 'master'
   }
   stage('Perform Maven Build, Create and Push Docker Image') {
      // Run the maven build
      echo "Starting Mvn build"
      sh "mvn -s /etc/maven/settings.xml clean package docker:build -DpushImage"
      echo "Finished Mvn build"
   }
   stage("create the full stack for amazon ecs using LambdaFunction"){
       invokeLambda([awsAccessKeyId: 'AKIAIH3T7KFY3ZQZYX7Q', awsRegion: 'us-east-1', awsSecretKey: '{AQAAABAAAAAwNpeFNC+H5t9tqwik2nWXLAMeQJld6/dzn6H02oF1IWUM7C2a9cY2GLb44BrOnVB20KDwcCI1TQ0yrybR0jzOGA==}', functionName: 'LambdaFunctionToCreateOrUpdateECS', payload: '''{
  "updateOrCreate": "update",
  "clusterName": "ecs-test-cluster",
  "serviceName": "ecs-test-service",
  "desiredCount": 1,
  "containerDefinitions": [
    {
      "memory": 500,
      "portMappings": [
        {
          "hostPort": 8888,
          "containerPort": 8080,
          "protocol": "tcp"
        }
      ],
      "name": "ecs-test-container",
      "image": "abirdatta/poc:v${BUILD_NUMBER}",
      "essential": true,
      "cpu": 1
    }
  ],
  "family": "ecs-test"
}''', synchronous: true])

   }
}