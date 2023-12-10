<img width="960" alt="Screenshot 2023-12-10 200647" src="https://github.com/kesav38/maven-web-application/assets/110167532/4147cc7d-2c00-44fa-a4e4-930472eb717e"><img width="960" alt="Screenshot 2023-12-10 200647" src="https://github.com/kesav38/maven-web-application/assets/110167532/0c291372-a638-4e69-a907-01e100fd5a61"># Automating Docker Image Upload to AWS ECR using GitHub Actions
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
 Created the ECR registry.
 
## (b) AWS IAM user for push or pull of images
  Search the IAM user in AWS console search tab
  <img width="960" alt="Screenshot 2023-12-10 112113" src="https://github.com/kesav38/maven-web-application/assets/110167532/0a81f972-d6a3-4e05-a14d-a2dacd325c1a">
  <img width="960" alt="Screenshot 2023-12-10 112316" src="https://github.com/kesav38/maven-web-application/assets/110167532/afe0b146-5c40-4dc4-b3e3-864830a1dc97">
  
Create the user here.

<img width="959" alt="Screenshot 2023-12-10 112510" src="https://github.com/kesav38/maven-web-application/assets/110167532/007637fb-bb79-4a01-9839-e32d7cb0e703">

Give the User name "ECR_user" and required details 

<img width="960" alt="Screenshot 2023-12-10 112701" src="https://github.com/kesav38/maven-web-application/assets/110167532/d42d87f4-381b-4fda-9296-8d1d80207b2e">

Click on "Attach policies directly" & give this policy "AmazonEC2ContainerRegistryFullAcces" for the user.and review and create the user here.

<img width="960" alt="Screenshot 2023-12-10 113100" src="https://github.com/kesav38/maven-web-application/assets/110167532/49005f54-bee6-4580-99c3-865a770bb15f">

User got created. To give access to this ECR for outisde user we need to have "Access key" and "secret key" ,So create access key and secret key by click on user as follows.

<img width="960" alt="Screenshot 2023-12-10 113124" src="https://github.com/kesav38/maven-web-application/assets/110167532/933a870e-95b8-4c72-9787-166416e16387">
<img width="958" alt="Screenshot 2023-12-10 113228" src="https://github.com/kesav38/maven-web-application/assets/110167532/aef76c4c-3f44-4169-8fe7-e3b99fdcd0d1">

## Created the "Access key" and "secret key" for user .store these keys in another file safely to make it reuse these keys for Github Actions.

# 4. GitHub Actions Workflow:
*This github action flow looks going to have these stages 
## "Build with Maven" , "Code Quality Analysis" , "Docker Build" , "Push the image to ECR". 
* we can write separate job for each stage in yml file to run the workflow otheriwise we can run all these stages as steps with in the single job.
* We choosed to run all these stages as steps with in the single job.
## (a)Build with Maven:
To execute build for java code , build tool is "maven" and executes the following command.

    mvn clean package --file pom.xml
To write the Workflow file, go to cloned github repo ----> Actions  ---> search workflow we want ortherwise "setup workflow yyourself" as follows:

<img width="957" alt="Screenshot 2023-12-10 132455" src="https://github.com/kesav38/maven-web-application/assets/110167532/98368784-3e0f-4cb4-85d1-899e8a1dd999">

## search "java with maven" ,on the top of this we will write our own workflow here otherwise we can write from scratch also.

* search "java with maven" ---> click on "configure", show the complete workflow syntax. Change the Name from "Java CI with Maven" to "Image build & push to ECR"

* In this workflow syntax it has job name. And this syntax explains that for every "Push" or "Pull Request" in "master" branch job goes to run.
 
* This build runs on "ubnutu-latest" OS , which has pre installed Maven , docker also. Here we are installing the java which is pre-requisite for mvn build.
     
    name: Image build & push to ECR
    on:
      push:
        branches: [ master ]
      pull_request:
        branches: [ master ]
    jobs:
      build:

        runs-on: ubuntu-latest

        steps:
        - uses: actions/checkout@v2
        - name: Set up JDK 11
          uses: actions/setup-java@v2
          with:
            java-version: '11'
            distribution: 'adopt'
            cache: maven
        - name: Build with Maven #Step for build of java src code
          run: mvn -B package --file pom.xml

  And commit the changes to the workflow file. whenever we commit the chnages to repo under "master" it triggers workflow ,after commiting the step "Build with Maven" along with other steps of job got executed successfully. we can see as follows:

<img width="952" alt="Screenshot 2023-12-10 145826" src="https://github.com/kesav38/maven-web-application/assets/110167532/9693b87a-afab-4fa4-b26b-d96118ad8358">

 
  Here Step "Build with maven" got executed alogn with the job successfully.
 
## Iam writing this workflow in local repo of laptop in VSC(visual studio code) for better indentation.

<img width="960" alt="Screenshot 2023-12-10 151057" src="https://github.com/kesav38/maven-web-application/assets/110167532/eb279afc-140c-41af-8db4-e081d7ba1ca0">


  We are updating the same file "maven.yml" in local repo to avoid the multiple triggers and this file saved in same path ".github/workflows/maven.yml" in local repository in laptop we can see in the above figure.

## (b) Code Quality Analysis: (we are  follwing this step for security best pratices)
* To analyse the Quality of the code which we have, here we are going to use code quality tool called "Sonarqube".
* ## It finds the Vulnerabilities, code smells, bugs of the code and these were extracted and scanned by the "Quality profiles" and "Quality gates" of Sonarqube. 
* Pre-requisite is need to have SonarQube installed server.Follow the Sonarqube Official docs for Sonarqube server setup https://docs.sonarsource.com/sonarqube/9.9/setup-and-upgrade/install-the-server/\
execute this command to prepare this Sonar code quality report for Java Src code.

      mvn sonar:sonar --file pom.xml -Dsonar.host.url=<sonar-server_url> -Dsonar.login=<soanr-server-token>

### NOTE: <sonar-server_url>,soanr-server-token save these as Repo Secrets for security best practices. 

<img width="960" alt="Screenshot 2023-12-10 154741" src="https://github.com/kesav38/maven-web-application/assets/110167532/471d8b63-460d-4f73-ab00-8b4f6c08a007">



### This command produces the Sonar code quality report Java Src code. Add this command to the "maven.yml" file as Follows.


<img width="959" alt="Screenshot 2023-12-10 154447" src="https://github.com/kesav38/maven-web-application/assets/110167532/f82e2055-b012-4373-8ae9-035375bcaea4">

#### Here we Added Sonar command to produce build report to find out  Vulnerabilities, code smells, bugs.

## (c) Config AWS credentials & Login:
Here we executes Docker build to create docker images and pushes that docker image to the ECR where it scans image by default. we created IAM user "Access key" and "secret key" we uses those keys to configure to AWS to push the images to ECR.

 we are going to use "image push to ECR github actions" to push the image, we can refer that actions here https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service\

### NOTE: Access key, secret key, ECR url, AWS region,AWS account No, Repo url save these as Repo Secrets for security Best practices.

<img width="957" alt="Screenshot 2023-12-10 165046" src="https://github.com/kesav38/maven-web-application/assets/110167532/58e3f320-5c98-4d29-9775-2d4051a6c50d">


We saved as Secrets here.


<img width="960" alt="Screenshot 2023-12-10 165655" src="https://github.com/kesav38/maven-web-application/assets/110167532/85510bcd-5bcf-4edc-a82c-989e7916c2e3">


Here we added the Steps "Configure AWS credentials", "Login to Amazon ECR" as per the Github actions referred in above link, is used login into AWS.

## (d) Docker Build & push to ECR:
  
  Docker used to create the image for the java Src code. we uses the following commands to built and push to ECR.

      docker build -t <registry>/<image>:<tag>  .
          docker push  <registry>/<image>:<tag> 
     #we already logged into the aws using above steps so no need to use "docker login command"


  Add the step to built and push to ECR in "maven.yml" as follows:

<img width="960" alt="Screenshot 2023-12-10 172924" src="https://github.com/kesav38/maven-web-application/assets/110167532/d941a16c-b90b-49b3-9003-88d6d3294fab">


   We added step to build the image and push to ECR.


## 5. Security and Best Practices:

##### We used Github secrets to configure sensitive data to pipeline flow for best security practices in github action workflow file as follows.

<img width="957" alt="Screenshot 2023-12-10 165046" src="https://github.com/kesav38/maven-web-application/assets/110167532/b45dc0dd-aadd-4ca9-9aa8-d2d4b82195ff">

## Run the workflow to check that its working or not :
##### Push the files present in the local repo to remote repo to trigger the workflow.

    git add . && git commit -m "dockerfile & workflow update"
    git pull mvnweb master
    git push mvnweb master
 Successfully pushed to github repo . after pushing to github repo "github actions" triggered the workflow as follows:

 <img width="960" alt="Screenshot 2023-12-10 181849" src="https://github.com/kesav38/maven-web-application/assets/110167532/29a12836-03db-40a4-a625-b76cb0bbb9e1">


#### we can see that workflow triggered and its running in above figure>

<img width="959" alt="Screenshot 2023-12-10 182202" src="https://github.com/kesav38/maven-web-application/assets/110167532/a43b0b06-01d6-403a-8e38-414b21c8dd86">

#### Successfully all the steps in workflow got triggered , we can observe that in above figure.

<img width="959" alt="Screenshot 2023-12-10 182259" src="https://github.com/kesav38/maven-web-application/assets/110167532/3ac438e7-0bbe-4ea7-8808-aaf8e549628c">

#### Sonar Report got generated in the server , we can observe in above figure , code quality Gate failed for the java code but "sonar code quality report" got generated here during the workflow.

<img width="960" alt="Screenshot 2023-12-10 182319" src="https://github.com/kesav38/maven-web-application/assets/110167532/78f141e0-57ce-4606-a255-74b3a4827544">

#### Image Successfully pushed to the ECR registry by github actions workflow.

## Completed the assesment here.

## 7. Bonus Tasks
### * Implement image scanning for vulnerabilities 
  here we are applying image scanning for the image which we created here before pushing. so github actions for Trivy image scan refer this link https://github.com/aquasecurity/trivy-action#using-trivy-with-github-code-scanning\ ---> we choosed "Docker Image Scanning" Github actions flow

#### add this Docker Image Scanning action to the "maven.yml" file in our local , we added this scanning after the build and before this pushing to AWS ECR , we can see it on the following image:

<img width="960" alt="Screenshot 2023-12-10 200647" src="https://github.com/kesav38/maven-web-application/assets/110167532/bb67d07d-f36a-4914-8a6a-7cd12c39e2df">


As we said we kept the "Trivy image scanning" no:2  between the "Build step" no:1  and "Push to ECR step" no:3 .saved this.

This vulnerabilities or code errors report of trivy image scan are going to be saved to "github repo Security"-----> "code scannings"

#### Lets try to execute the workflow to check that Trivy image scanning step is running or not ,iamge is going to pushes to ECR or not.
     #execute push commands to trigger the build
      git commit -a -m "trivy scan update"
      git pull mvnweb master
      git push mvnweb master

  After the execution of these commands the Workflow got triggered as follows:


<img width="956" alt="Screenshot 2023-12-10 202127" src="https://github.com/kesav38/maven-web-application/assets/110167532/b88752cc-7d14-4258-9791-9a669d396af4">

#### Workflow triggered and status of job steps as follows:

<img width="960" alt="Screenshot 2023-12-10 202151" src="https://github.com/kesav38/maven-web-application/assets/110167532/c24c7662-5a74-4b7f-bff1-9738afa38673">


<img width="960" alt="Screenshot 2023-12-10 202351" src="https://github.com/kesav38/maven-web-application/assets/110167532/597508d7-24ec-46c9-aa71-f8e3da455891">

### Workflow got executed all the steps successfully as above along with "trivy image scanning step also"

#### After the Workflow success, we can see that code errors , vulnerablities are saved in "security of github repo's" ------> "code scanning" as follows:

<img width="960" alt="Screenshot 2023-12-10 202417" src="https://github.com/kesav38/maven-web-application/assets/110167532/78bf5e03-a423-41e8-bf3d-f959274ab93a">


<img width="960" alt="Screenshot 2023-12-10 202603" src="https://github.com/kesav38/maven-web-application/assets/110167532/813653ca-ce42-4035-8131-97cc87936c07">


All vulnerabilities and code smell are saved here as above.

### After the completion of whole work flow the image got pushed to the ECR as we can see in below: we have two images of two workflow builds.

<img width="960" alt="Screenshot 2023-12-10 202624" src="https://github.com/kesav38/maven-web-application/assets/110167532/8fb44458-0a09-4ed8-999c-3097ae2377ca">

### Assesment completed upto hear successfully.
