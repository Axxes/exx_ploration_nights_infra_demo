pwd
ls
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/index_1.html ec2-user@54.155.95.176:/var/www/html/index.html
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/traineeship_image_1.png ec2-user@54.155.95.176:/var/www/html/traineeship_image_1.png
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/traineeship_image_2.png ec2-user@54.155.95.176:/var/www/html/traineeship_image_2.png
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/index_2.html ec2-user@54.246.202.229:/var/www/html/index.html
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/traineeship_image_1.png ec2-user@54.246.202.229:/var/www/html/traineeship_image_1.png
scp -i /var/lib/jenkins/keys/web_id_rsa_ssh -o StrictHostKeyChecking=no /var/lib/jenkins/templates/traineeship_image_2.png ec2-user@54.246.202.229:/var/www/html/traineeship_image_2.png