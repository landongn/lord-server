node {
    def version = ""
    def dockerImage = ""

    stage('Checkout') {
        checkout scm
    }

    stage ('Build') {
        sh "/usr/local/bin/mix local.hex --force"
        sh "/usr/local/bin/mix deps.get"
        sh "/Users/daniel/.nvm/versions/node/v4.2.1/bin/npm install"
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
