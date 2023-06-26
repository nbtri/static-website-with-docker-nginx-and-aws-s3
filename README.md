
# static-website-with-docker-nginx-and-aws-s3

Deploy your static website in AWS S3 with Docker




## Acknowledgements

 - [How to setup AWS S3 as a website hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/HostingWebsiteOnS3Setup.html)
 - [Upload your website to AWS S3](https://github.com/nbtri/aws-s3-uploader)


## Features

- Build your Nginx gateway works with AWS S3
- Run with Docker


## Usage/Examples

### Prepare your Source code
Put your source code under directory ```html```

### Configure your AWS S3 URL
Open ```nginx/default.conf``` and update your AWS S3 URL at the ```proxy_pass```

```
location / {
        rewrite ^/ /index.html break;
        proxy_pass       https://[your AWS S3 URL here];
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host [your AWS S3 URL here];
        ...
}
```

```
location ~ ^/.*/$ {
        rewrite ^/(.*)/ /$1/index.html break;
        proxy_pass       https://[your AWS S3 URL here];
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host [your AWS S3 URL here];
        ...
}
```

```
location ~* /.*\.(woff|woff2|ttf|gz|css|js|gif|jpg|jpeg|html|svg|ico|xml|png)$ {
        rewrite ^/(.*) /$1 break;
        proxy_pass       https://[your AWS S3 URL here];
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host [your AWS S3 URL here];
        ...
}
```

### Configure the  Makefile Environments
Environment KEYs and Values
```
IMAGE_NAME=[your docker image name after built]
HOME_DIR=[abosolute path to your html directory]
TMP_DIR=/var/tmp/site
AWS_ACCESS_KEY_ID=[your AWS S3 CLI Access Key]
AWS_SECRET_ACCESS_KEY=[your AWS S3 CLI Secret Key]
PROJECT_BUCKET=[your AWS S3 bucket-name]
PROJECT_BUCKET_DIR=[leave it blank if you want to upload to the root path of your bucket]
AWS_DEFAULT_REGION=[your AWS S3 bucket region]
``` 
Environments Examples
```
IMAGE_NAME=static-s3-website
HOME_DIR=`pwd`/html
TMP_DIR=/var/tmp/site
AWS_ACCESS_KEY_ID=abc
AWS_SECRET_ACCESS_KEY=xyz
PROJECT_BUCKET=my-static-s3-website
PROJECT_BUCKET_DIR=
AWS_DEFAULT_REGION=ap-southeast-1
``` 


## Run Locally

Clone the project

```bash
  git clone git@github.com:nbtri/static-website-with-docker-nginx-and-aws-s3.git
```

Go to the project directory

```bash
  cd my-project
```

Upload the source code to AWS s3

```bash
  make upload-website-2-s3
```

Build the image

```bash
  make build
```

Start the server

```bash
  make run
```

Now you can access your website at: http://localhost:8080

