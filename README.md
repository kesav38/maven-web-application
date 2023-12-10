# Automating Docker Image Upload to AWS ECR using GitHub Actions
 ____________________________________________________________
 ## Objective: 
   Create a GitHub Actions workflow that automatically builds Docker images and uploads them to AWS Elastic Container Registry (ECR) upon code pushes or pull requests.
 ## Basic Pre-requesites:
 * Clone Git repository of Sample Code
 * Create Sonar Server for Code Qulity check
## 1. GitHub Repository Setup
* Initialize a GitHub repository with a sample application (e.g., a simple Hello World app in a language of your choice).So Here We pick this sample repo of java application[here](https://github.com/kesav38/maven-web-application.git)
<img width="959" alt="Screenshot 2023-12-09 224015" src="https://github.com/kesav38/maven-web-application/assets/110167532/b2d16261-6d66-47ca-bc54-356f34fd9bf9">

 ## Took this repo as sample application , fork this repo.

<img width="953" alt="Screenshot 2023-12-09 223910" src="https://github.com/kesav38/maven-web-application/assets/110167532/8a759614-87ef-4c3b-acbe-4e7e9225f07a">

 ## forked this repo to our github succesfully.

<img width="948" alt="Screenshot 2023-12-09 224108" src="https://github.com/kesav38/maven-web-application/assets/110167532/25cc9ce8-0b00-4dde-b33d-c370229941fe">

 ## This is the repo this we are going to use to execute the build and create the images for it.
 
 * Here can see that it has only Src code and its pom.xml file which are important to execute build for this application.Need to write the Dockerfile for this application here.
## 1. Dockerfile creation
*  Write the Dockerfile in local repo of the laptop and push that dockerfile to this github repo to trigger the github actions.
  Create a dir to intialize git and create the "Dockerfile" in that location as follows:
<img width="960" alt="Screenshot 2023-12-10 094916" src="https://github.com/kesav38/maven-web-application/assets/110167532/11e41804-0779-4cea-ad1f-7b86cc284a48">
<img width="960" alt="Screenshot 2023-12-10 094954" src="https://github.com/kesav38/maven-web-application/assets/110167532/5f7d2a80-0c65-4599-af7e-222af416eb43">
<img width="960" alt="Screenshot 2023-12-10 100113" src="https://github.com/kesav38/maven-web-application/assets/110167532/03126497-2886-4180-b0d0-b48fba6e5484">

## Write the Dockerfile as follow to execute image build for the java application. 

<img width="735" alt="Screenshot 2023-12-10 100748" src="https://github.com/kesav38/maven-web-application/assets/110167532/862beedd-4975-4caa-a6a4-07877191bed3">




