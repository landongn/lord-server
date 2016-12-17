node {
    def version = ""
    def dockerImage = ""

    stage('Checkout') {
        checkout scm
    }

    stage ('Build') {
        withEnv(['PATH=/usr/local/bin:$PATH']) {
            sh "mix local.hex --force"
            sh "mix deps.get"
        }
        withEnv(['PATH=/Users/daniel/.nvm/versions/node/v6.9.1/bin:$PATH']) {
            sh "npm install"
        }
    }

    if (env.BRANCH_NAME == "master") {
        stage ('Docker') {
            version = "${BUILD_VERSION}"
            dockerImage = docker.build "home.cherubini.casa:5000/lordserver:${version}"
            currentBuild.description = "Docker image: home.cherubini.casa:5000/lordserver:${version}"
        }

        stage('Delivery') {
            dockerImage.push()
            
            // sh "./deploy.sh ubuntu@172.29.194.214 home.cherubini.casa:5000/lordserver ${version} docker-container-globalweb.service"
        }
    }
}
