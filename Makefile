IMAGE_NAME=[your docker image name after built]
HOME_DIR=[abosolute path to your html directory]
TMP_DIR=/var/tmp/site
AWS_ACCESS_KEY_ID=[your AWS S3 CLI Access Key]
AWS_SECRET_ACCESS_KEY=[your AWS S3 CLI Secret Key]
PROJECT_BUCKET=[your AWS S3 bucket-name]
PROJECT_BUCKET_DIR=[leave it blank if you want to upload to the root path of your bucket]
AWS_DEFAULT_REGION=[your AWS S3 bucket region]

clean:
	docker image rm ${IMAGE_NAME}
build:
	docker build . -t ${IMAGE_NAME}
run:
	docker run \
	-p 8080:80 \
	${IMAGE_NAME}
upload-website-2-s3:
	docker run -v ${HOME_DIR}:${TMP_DIR} \
            -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
            -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
            -e AWS_S3_BUCKET=${PROJECT_BUCKET} \
            -e SITE=${TMP_DIR} \
            -e INSIDE_DIR=${PROJECT_BUCKET_DIR} \
			-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
            nbtri/website-s3:0.0.1