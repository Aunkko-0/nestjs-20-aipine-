pipeline {
    agent any

    // 1. รับค่า Version ที่ต้องการ Deploy (Default คือ latest)
    parameters {
        string(
            name: 'IMAGE_TAG', 
            defaultValue: 'latest', 
            description: ''
        )
    }

    environment {
        // --- ตั้งค่า Image ---
        REGISTRY = "ghcr.io"
        IMAGE_NAME = "aunkko-0/nestjs-api-20"
        
        // รวมร่างเป็นชื่อเต็ม: ghcr.io/aunkko-0/nestjs-api-20:latest
        TARGET_IMAGE = "${REGISTRY}/${IMAGE_NAME}:${params.IMAGE_TAG}"
    }

    stages {
        stage('🚀 Update Kubernetes') {
            steps {
                script {
                    echo "กำลัง Deploy Image: ${TARGET_IMAGE} ..."
                    
                    // 1. สั่งเปลี่ยน Image ใน Deployment
                    // รูปแบบ: kubectl set image deployment/<ชื่อ-deploy> <ชื่อ-container>=<image-ใหม่>
                    sh "kubectl set image deployment/nestjs-api nestjs-api=${TARGET_IMAGE}"
                    
                    // 2. สั่ง Restart Pod (สำคัญมาก! เพื่อบังคับให้ K8s ดึง Image ใหม่จริงๆ โดยเฉพาะถ้าเป็น tag 'latest')
                    sh "kubectl rollout restart deployment/nestjs-api"
                }
            }
        }

        stage('✅ Verify Deployment') {
            steps {
                script {
                    echo "กำลังตรวจสอบสถานะ..."
                    // รอจนกว่า Pod ใหม่จะรันเสร็จสมบูรณ์ (ถ้าพัง มันจะฟ้อง Error ตรงนี้)
                    sh "kubectl rollout status deployment/nestjs-api"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Deploy เวอร์ชัน ${params.IMAGE_TAG} สำเร็จเรียบร้อย!"
        }
        failure {
            echo "❌ Deploy ล้มเหลว! กรุณาเช็ค Logs"
        }
    }
}
