# Automating Docker Image Upload to AWS ECR using GitHub Actions
 ____________________________________________________________
 ## Objective: 
   Create a GitHub Actions workflow that automatically builds Docker images and uploads them to AWS Elastic Container Registry (ECR) upon code pushes or pull requests.
 ## Basic Pre-requesites:
 * Clone Git repository of Sample Code
 * Create Sonar Server for Code Qulity check
# 1. GitHub Repository Setup
* Initialize a GitHub repository with a sample application (e.g., a simple Hello World app in a language of your choice).So Here We pick this sample repo of java application[here](https://github.com/kesav38/maven-web-application.git)
<img width="959" alt="Screenshot 2023-12-09 224015" src="https://github.com/kesav38/maven-web-application/assets/110167532/b2d16261-6d66-47ca-bc54-356f34fd9bf9">

 ## Took this repo as sample application , fork this repo.

<img width="953" alt="Screenshot 2023-12-09 223910" src="https://github.com/kesav38/maven-web-application/assets/110167532/8a759614-87ef-4c3b-acbe-4e7e9225f07a">

 ## forked this repo to our github succesfully.

<img width="948" alt="Screenshot 2023-12-09 224108" src="https://github.com/kesav38/maven-web-application/assets/110167532/25cc9ce8-0b00-4dde-b33d-c370229941fe">

 ## This is the repo this we are going to use to execute the build and create the images for it.
 
 * Here can see that it has only Src code and its pom.xml file which are important to execute build for this application.Need to write the Dockerfile for this application here.
# 2. Dockerfile creation
*  Write the Dockerfile in local repo of the laptop and push that dockerfile to this github repo to trigger the github actions.
  Create a dir to intialize git and create the "Dockerfile" in that location as follows:
<img width="960" alt="Screenshot 2023-12-10 094916" src="https://github.com/kesav38/maven-web-application/assets/110167532/11e41804-0779-4cea-ad1f-7b86cc284a48">
<img width="960" alt="Screenshot 2023-12-10 094954" src="https://github.com/kesav38/maven-web-application/assets/110167532/5f7d2a80-0c65-4599-af7e-222af416eb43">
<img width="960" alt="Screenshot 2023-12-10 100113" src="https://github.com/kesav38/maven-web-application/assets/110167532/03126497-2886-4180-b0d0-b48fba6e5484">

## Write the Dockerfile as follow to execute image build for the java application. 
 Write the Dockerfile in local repo of the laptop and push that dockerfile to this github repo to trigger the github actions.

<img width="735" alt="Screenshot 2023-12-10 100748" src="https://github.com/kesav38/maven-web-application/assets/110167532/862beedd-4975-4caa-a6a4-07877191bed3">

## Dockerfile is created, we can see that file in following location.

<img width="960" alt="Screenshot 2023-12-10 104128" src="https://github.com/kesav38/maven-web-application/assets/110167532/23d28fb9-a824-4ae4-9757-60d9fa118872">


## Important points to note while writing the Dockerfile
* use alpine images as base image to reduce the size of image whcih is best pratice here, So we used alpine image as base image.
* For complex aplcaitions its better to write the muti stage docker file to reduce image size.
* Instead of using 2 or more RUN instructions mutiple times i dockerfile , then its better to execute all RUN instrcution commands in single line which reduces the no of layers of image. because each RUN instrcution of the image creates separete layer So that increase the size of image.

# 3. AWS ECR & IAM user Setup 
* Create the ECR registry to keep our images in the repos.
* Need to create the IAM user with FULLAccess of ECR for github actions workflow to pull or push the images to the ECR registry.
* (a) AWS ECR creation
* (b) AWS IAM user for push or pull of images
## (a) AWS ECR creation
Search "ECR" in aws console search tab

<img width="959" alt="Screenshot 2023-12-10 110013" src="https://github.com/kesav38/maven-web-application/assets/110167532/d1e00bc3-1ac3-47f1-910e-81cc0e3744d0">

## Click on that ECR service opens its page to create ECR registry.

<img width="959" alt="Screenshot 2023-12-10 110039" src="https://github.com/kesav38/maven-web-application/assets/110167532/74db13af-391c-4a1a-a85b-353be5a65264">

## Click on ---> "get started" to create Registry.

<img width="960" alt="Screenshot 2023-12-10 110232" src="https://github.com/kesav38/maven-web-application/assets/110167532/2de9f7c9-17a9-4d6f-b68b-9c9ddaaa6c7d">

## we took "private registry" and give required details like repositry name as "mvn_image" etc & ---> created registry.

<img width="959" alt="Screenshot 2023-12-10 110250" src="https://github.com/kesav38/maven-web-application/assets/110167532/09a6b213-cb98-46c9-83da-0ad67a8e1af9">
<img width="960" alt="Screenshot 2023-12-10 110314" src="https://github.com/kesav38/maven-web-application/assets/110167532/b983969a-f474-44ab-b3f4-7b4b93bdff80">

       registry got created , inside the registry we have one repositry as "mvn_image" which we created now, inside that repository we can see that nothing is there.we didnt saved any images so its empty now.
       ------->Created the ECR registry <------
## (b) AWS IAM user for push or pull of images
  Search the IAM user in AWS console search tab



