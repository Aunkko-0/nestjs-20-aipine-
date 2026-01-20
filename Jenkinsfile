pipeline {
    agent any

    environment {
        REGISTRY = "ghcr.io"
        IMAGE_NAME = "aunkko-0/nestjs-api-20"
        CREDENTIALS_ID = 'nestjs'
    }

    stages {
        stage('1. Checkout Source') {
            steps {
                checkout scm
            }
        }
stage('2. Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${env.CREDENTIALS_ID}", passwordVariable: 'GHCR_PAT', usernameVariable: 'GHCR_USER')]) {
                    sh 'echo $GHCR_PAT | docker login $REGISTRY -u $GHCR_USER --password-stdin'
                }
            }
        }

        stage('3. Build Image') {
            steps {
                // ระบุไฟล์ Dockerfile ให้ชัดเจน และมีจุด . ท้ายสุด
                sh 'docker build -f Dockerfile -t $REGISTRY/$IMAGE_NAME:latest .'
            }
        }

        stage('4. Push to Registry') {
            steps {
                sh 'docker push $REGISTRY/$IMAGE_NAME:latest'
            }
        }
    } // <--- ปิด stages ตรงนี้

    post {
        always {
            // ส่วนนี้ยังอยู่ภายใน pipeline เพราะวงเล็บปิด pipeline อยู่ด้านล่างสุด
            sh 'docker rmi $REGISTRY/$IMAGE_NAME:latest || true'
            cleanWs()
        }
        success {
            echo "Successfully built and pushed: $IMAGE_NAME"
        }
    } // <--- ปิด post ตรงนี้

} // <--- ปิด pipeline ตรงนี้ (ต้องเป็นตัวสุดท้ายของไฟล์!)
จัดให้หน่อย 
