node {
   wrap([$class: 'AnsiColorBuildWrapper']) {
      properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '6')), pipelineTriggers([pollSCM('H/15 * * * *')])])
      stage('Checkout') { // for display purposes
         // Clean workspace before checkout
         step ([$class: 'WsCleanup'])
         // Get some code from a GitHub repository
         git 'https://github.com/relybv/dirict-profile_mysql.git'
      }
      stage('Dependencies') {
         sh 'cd $WORKSPACE'
         sh '/usr/bin/bundle install --jobs=1 --path vendor/bundle --without development'
      }
      stage('Code quality') {
         parallel (
            syntax: { sh '/usr/bin/bundle exec rake syntax' },
            lint: { sh '/usr/bin/bundle exec rake lint' },
            spec: { sh '/usr/bin/bundle exec rake ci:all' }
         )
         step([$class: 'JUnitResultArchiver', testResults: 'spec/reports/*.xml'])
         junit 'spec/reports/*.xml'
      }
      stage('Documentation') {
         sh '/opt/puppetlabs/bin/puppet resource package yard provider=puppet_gem'
         sh '/opt/puppetlabs/bin/puppet module install puppetlabs-strings'
         sh '/opt/puppetlabs/puppet/bin/puppet strings'
         publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: false, reportDir: 'doc', reportFiles: 'index.html', reportName: 'HTML Report'])
      }
      stage('Acceptance tests debian 9')
      {
         sh '/usr/bin/bundle exec rake spec_clean'
         withEnv(['OS_AUTH_URL=https://access.openstack.rely.nl:5000/v2.0', 'OS_TENANT_ID=10593dbf4f8d4296a25cf942f0567050', 'OS_TENANT_NAME=lab', 'OS_PROJECT_NAME=lab', 'OS_REGION_NAME=RegionOne']) {
            withCredentials([usernamePassword(credentialsId: 'OS_CERT', passwordVariable: 'OS_PASSWORD', usernameVariable: 'OS_USERNAME')]) {
                sh 'BEAKER_set="openstack-debian-90-x64" /usr/bin/bundle exec rake beaker_fixtures > openstack-debian-90-x64.log'
                sh 'sleep 5' // give the stack a moment to cleanup
                try {
                   // False if failures in logfile
                   sh "grep --quiet Failures openstack-debian-90-x64.log"
                   sh "grep -A100000 Failures openstack-debian-90-x64.log"
                   currentBuild.result = 'FAILURE'
                } catch (Exception err) {
                   currentBuild.result = 'SUCCESS'
                }
            }
         }
      }
   }
   archiveArtifacts '*.log'
}
