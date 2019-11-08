String credentialsId = 'telepathy-user-aws-keys'

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
    }
  }

  //...............approval stage
   
  
  
  //ended approval stage
  // Run terraform init
  stage('init') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
          //sh "sudo terraform init $jenkis_node_custom_workspace"
          //sh 'cd /var/lib/jenkins/workspace/terraform-2_master'
          sh 'pwd'
          sh 'terraform init'
          // IMP NOTE : import we have to do once only, after successfully import, we have to comment those lines
          // other wise terraform will try to import again and throw errers
          //sh 'terraform import aws_s3_bucket.terraform-state-file-1 ts3f1'
          //sh 'terraform import aws_dynamodb_table.dynamodb-terraform-state-lock ts3f1-lock'
          
          //sh 'sudo /var/lib/jenkins/workspace/terraform-2_master/terraform init ./var/lib/jenkins'
        }
      }
    }
  }
  

  // Run terraform plan
  stage('plan') {
    node {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        credentialsId: credentialsId,
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
      ]]) {
        ansiColor('xterm') {
          //sh 'sudo /var/lib/jenkins/workspace/terraform-2_master'
          sh 'terraform plan'
        }
      }
    }
  }

  if (env.BRANCH_NAME == 'master') {

    // Run terraform apply
    stage('apply') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            //sh 'sudo /var/lib/jenkins/workspace/terraform-2_master'
            sh 'terraform apply -auto-approve'
           // sh 'terraform destroy -auto-approve'
          }
        }
      }
    }

    // Run terraform show
    stage('show') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            //sh 'sudo /var/lib/jenkins/workspace/terraform-2_master'
            sh 'terraform show'
          }
        }
      }
    }
    //........ input
    
    stage('ip') {
      node {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: credentialsId,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          ansiColor('xterm') {
            //sh 'sudo /var/lib/jenkins/workspace/terraform-2_master'
            sh 'terraform output instance_ip_addr'
           // sh 'terraform output instance_ip-addr -out=/var/lib/jenkins/workspace/AWS-INFRA-DEMO_master/ip.xml'
          }
        }
      }
    }
    
    
    
    
    //start
    stage ("wait_prior_starting_smoke_testing") {
       echo 'Waiting 5 minutes for deployment to complete prior starting smoke testing'
         sleep 120 // seconds
      }
    
     //starting point
    stage('ssh to tomcat') {
      node {
          ansiColor('xterm') 
            sh 'PRIVATEIP=$(terraform output instance_ip_addr)'
            sh 'terraform output instance_ip_addr'
            //sh 'terraform output instance_ip-addr -out=/var/lib/jenkins/workspace/AWS-INFRA-DEMO_master/ip.xml'
            sh 'sudo chmod 400 /var/lib/jenkins/workspace/AWS-INFRA-DEMO_master/telepathy-key.pem'
            ssh -i /var/lib/jenkins/workspace/AWS-INFRA-DEMO_master/telepathy-key.pem ubuntu@$'PRIVATEIP'
            sh 'whoami'
            sh 'ifconfig | grep broadcast'
          }
        }
      }
    
    
   
    //...........end
    
  }
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}

