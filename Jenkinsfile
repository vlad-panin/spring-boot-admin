@Library('ci-tools') _ // library with most of CI logic

properties([buildDiscarder(logRotator(numToKeepStr: '5'))]) // number of stored build records on Jenkins

cancelPreviousBuilds() // abort previous currently running builds

DockerImage image

stage('Initialize') {
    initializer.setBuildProperties(tool: 'gradle', toolVersion: '5.6.4', projectKey: 'DO', jdk: '8') // set initial static properties for build, use args to override defaults
    initializer.setMessageBase() // set main text of informational message, use env.MESSAGE_BASE to override default text

    image = new DockerImage()

    Artifactory dockerRegistry = new Artifactory()
    image.exists = dockerRegistry.searchImage(image.tag) // check if current commit hash already exists in registry

    currentBuild.displayName = image.tag // set build number to image tag
}

node {
    stage('Source checkout') {
        source.smartCheckout() // clone or update repo, check if local repo HEAD corresponds to HEAD from Bitbucket API
    }
    stage("Build image") {
        when(!image.exists) {
            image.buildImage() // build boot jar and docker image
        }
    }
    stage("Push to registry") {
        when(!image.exists) {
            image.pushImage() // upload image to Artifactory
        }
    }
}

// stage("CD trigger") {
//     deployTrigger(image.name, 'mobile-test') // trigger deploy to Staging environment
// }