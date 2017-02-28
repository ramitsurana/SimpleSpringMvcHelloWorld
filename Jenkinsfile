node {
   stage('Git Code Checkout') { // for display purposes
      // Get some code from a GitHub repository
      git url: 'git@github.com:abirdatta/SimpleSpringMvcHelloWorld.git', branch: 'master'
   }
   stage('Build & Deploy to Nexus') {
      // Run the maven build
      echo "Starting Mvn build"
      sh "mvn -s /etc/maven/settings.xml clean deploy"
      echo "Finished Mvn build"
   }
   stage("Create Docker image from DockerFile") {
       sh "docker build --no-cache -t abirdatta/poc:v${BUILD_NUMBER} ."
   }
   stage("Login and Push Image to DockerHub") {
       sh 'docker login --username=abirdatta --email="abirdatta.in@gmail.com" --password="dockerhub123"'
       sh "docker push abirdatta/poc"
   }
   stage("re-register Amazon ecs task and update amazon ecs"){
       sh "./update-ecs-cluster.sh"
   }
}
