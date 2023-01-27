pipeline {
    agent none
    stages {
        
        stage('install puppet on slave') {
            agent { label 'slave'}
            steps {
                echo 'Install Puppet'
                sh "wget -N -O 'puppet.deb' https://apt.puppetlabs.com/puppet6-release-bionic.deb"
                sh "chmod 755 puppet.deb"
                sh "echo '123456' | sudo -S dpkg -i puppet.deb"
                sh "echo '123456' | sudo -S apt update"
                sh "echo '123456' | sudo -S apt install -y puppet-agent"
            }
        }

        stage('configure and start puppet') {
            agent { label 'slave'}
            steps {
                echo 'configure puppet'
                sh "mkdir -p /etc/puppetlabs/puppet"
                sh "if [ -f /etc/puppetlabs/puppet/puppet.conf ]; then echo '123456' | sudo -S rm -f /etc/puppetlabs/puppet.conf; fi"
                sh "echo '[main]\ncertname = node1.local\nserver = puppet' >> ~/puppet.conf"
                sh "echo '123456' | sudo -S mv ~/puppet.conf /etc/puppetlabs/puppet/puppet.conf"
                echo 'start puppet'
                sh "echo '123456' | sudo -S systemctl start puppet"
                sh "echo '123456' | sudo -S systemctl enable puppet"
            }
        }

        stage('Install Docker on slave through puppet') {
            agent{ label 'slave'}
            steps {
                sh "echo '123456' | sudo -S /opt/puppetlabs/bin/puppet module install garethr-docker"
                sh "echo '123456' | sudo -S /opt/puppetlabs/bin/puppet apply /var/lib/jenkins/workspace/Test-Project_main/dockerce.pp"
            }
        }

        stage('Git Checkout') {
            agent{ label 'slave'}
            steps {
                sh "if [ ! -d '/var/lib/jenkins/workspace/Test-Project_main' ]; then git clone https://github.com/Bhargava-16/apple-proj1.git /var/lib/jenkins/workspace/Test-Project_main ; fi"
                sh "cd /var/lib/jenkins/workspace/Test-Project_main && echo '123456' | sudo -S git checkout main"
            }
        }
        
        stage('Docker Build and Run') {
            agent{ label 'slave'}
            steps {
                sh "echo '123456' | sudo -S docker rm -f webapp || true"
                sh "cd /var/lib/jenkins/workspace/Test-Project_main && echo '123456' | sudo -S docker build -t test ."
                sh "echo '123456' | sudo -S docker run -it -d --name webapp -p 1998:80 test"
            }
        }

		stage('Setting Prerequisite for Selenium') {
            agent{ label 'slave'}
            steps {
                sh "echo Succesfully set prerequisite"
            }
        }

        stage('Check if selenium test run') {
            agent{ label 'slave'}
            steps {
        sh "echo Running Selenium"
		sh "curl http://localhost:1998 && echo Successful"
            	}
            post {
                failure {
                    sh "echo Failure"
					sh "echo '123456' | sudo -S docker rm -f webapp"
                }
			}
		}
	}
}
