pipeline {
  agent any
  stages {
    stage('Notify') {
      steps {
        sh 'echo "Hello world"'
      }
    }
    stage('Run fastlane') {
      steps {
        sh 'fastlane test'
      }
    }
  }
}