<div align="center">

![Screenshot of a comment on a GitHub issue showing an image, added in the Markdown, of an Octocat smiling and raising a tentacle.](https://silvaco.com/wp-content/uploads/2020/02/stud_logo_large1-300x159.jpg)

</div>

<!-- Introduction of project -->

<div align="center">
  
  <h1> 60.004 - Service Design Studio 2024 </h1> 
  <h2> DBS DocCheck Team 07 </h2>

</div>

<h3 align="center" style="text-decoration: none;">A joint collaboration between SUTD, DBS and Google</h3>

<div align="center">

[Design Workbook](https://docs.google.com/document/d/1L4lje_IrNw3vBCZRLhw0MzS21esSraEnZhPzash-BkM/edit#heading=h.30mvr6mmd9p3). [Google Site](https://sites.google.com/view/team-wlb/home). [App Website](https://dbsdoccheckteam7-44nyvt7saq-de.a.run.app)

</div>

## Table of Contents
- [Project Overview](#project-overview)
- [Technologies and Dependencies](#technologies-and-dependencies)
- [Getting Started](#getting-started)
  - [Prerequesites](#prerequisites)
  - [Installations](#installations)
  - [Frontend](#frontend)
  - [Backend](#backend)
  - [Database](#database)
  - [Deployment](#deployment)
  - [Testing](#testing)

## Project Overview
 This project aims to make the process of DBS credit card application foolproof such that customers who are not Singapore Citizen/PR submits the correct documents on the first try to reduce the need for DBS Operations team to send back applications.

## Technologies and Dependencies
 - Ruby On Rails, Ruby version 3.3.1 (Frontend framework)
 - Flask, Python 3, pip (Backend framework)
 - Google Cloud SDK (Database deployment)
 - PostgreSQL
 - Docker

## Getting Started

  ### Prerequisites
  
  Before beginning this project, please ensure that you have the following installed:
  - Ruby: [Installation guide](https://www.ruby-lang.org/en/documentation/installation/)
  - Python: [Installation guide](https://wiki.python.org/moin/BeginnersGuide/Download)
  - PostgreSQL: [Installation guide](https://www.postgresql.org/docs/current/tutorial-install.html)
  - Google Cloud SDK: [Installation guide](https://cloud.google.com/sdk/?%7B_dsmrktparam&utm_source=google&utm_medium=cpc&utm_campaign=japac-SG-all-en-dr-SKWS-all-all-trial-DSA-dr-1605216&utm_content=text-ad-none-none-DEV_c-CRE_647923039857-ADGP_Hybrid+%7C+SKWS+-+BRO+%7C+DSA+-All+Webpages-KWID_39700075148142355-dsa-19959388920&userloc_9062548-network_g&utm_term=KW_&gad_source=1&gclid=Cj0KCQjw8MG1BhCoARIsAHxSiQm_Z5Zpm00LwbgwuIzMOlyxaIHUa3x4V5EUnhd13kzfFTxpfF4Rv-4aAgCNEALw_wcB&gclsrc=aw.ds&hl=en)
  - Docker: [Installation guide](https://docs.docker.com/engine/install/)
  - Recommended: [Github Desktop](https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop)
  
  
  ### Installations
  ```bash
  git clone https://github.com/icedbeancat/1d-final-project-summer-2024-sds-2024-team-07.git
  ```
  
  ### Frontend
  Our Frontend utilises the Ruby On Rails framework. To run the Frontend:
  1. Go to the `Frontend` directory
     ```bash
     cd ./Frontend/
     ```
  
  2. Install dependencies
     ```bash
     bundle install
     ```
  
  3. Run local host
     ```bash
     bundle exec rails s
     ```
  
  ### Backend
  Our Backend utilises Python Flask. To run the Backend:
  1. Go to the `Backend` directory
     ```bash
     cd./Backend/
     ```
  
  2. Install `virtualenv` (if not already installed) and set up virtual environment
     ```bash
     pip install virtualenv
     python3 -m venv myenv
     source myenv/bin/activate
     pip install -r ./requirements.txt
     pip install --upgrade google-generativeai google-cloud-aiplatform
     pip freeze > requirements.txt
     ```
  
  3. Run the flask app
     ```bash
     flask run
     ```
  
  ### Database
  This section will show how PostgreSQL database is deployed to Google Cloud Platform (GCP). For development and test environments, SQLite 3 is used.</br>
  </br>
  Ensure that you have:
  * A Google Cloud account
  * Google Cloud SDK installed
  
  1. Create a new project on GCP
     * Go to the [Google Cloud Console](https://cloud.google.com/cloud-console/?utm_source=google&utm_medium=cpc&utm_campaign=japac-SG-all-en-dr-BKWS-all-super-trial-PHR-dr-1605216&utm_content=text-ad-none-none-DEV_c-CRE_649003149322-ADGP_Hybrid%20%7C%20BKWS%20-%20BRO%20%7C%20Txt%20-Management%20Tools-Cloud%20Console-google%20cloud%20console-main-KWID_43700075888673448-kwd-296393718382&userloc_9062546-network_g&utm_term=KW_google%20cloud%20console&gad_source=1&gclid=Cj0KCQjw8MG1BhCoARIsAHxSiQkzXS1X6LUui4YjJFaZwcRy3sU1PqB7lyPPkscM7BE0dACdDtmkiSEaAuN8EALw_wcB&gclsrc=aw.ds)
     * Click on the project dropdown at the top of the page
     * Select **New Project**
     * Enter your project name and billing account, then click **Create**
    
  2. Enable the Cloud SQL Admin API
     * In the Google Cloud Console, navigate to the **APIs & Services** section
     * Search **Cloud SQL Admin API** and enable it for your project
    
  3. Create a Cloud SQL Instance
     * Navigate to the **SQL** section in the Google Cloud Console
     * Click **Create Instance**
     * Choose **PostgreSQL** as the database engine
     * Follow the prompts to set up your instance, including setting the instance ID, root password, and region
     * Click **Create**
    
  4. Configure the database
     * Once the instance is created, click on it to view its details
     * Note the **Instance connection name**
     * Set up a database and user by clicking **Databases** and **Users** tabs and adding the necessary configurations
  
  5. Create database.yml file</br>
     Navigate to the `config` directory and open the `database.yaml` file
     ```yaml
     default: &default
      adapter: sqlite3
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      timeout: 5000
  
      development:
        <<: *default
        database: storage/development.sqlite3
  
      test:
        <<: *default
        database: storage/test.sqlite3
       
      production:
        adapter: postgresql
        encoding: utf8  
        host: <%= ENV.fetch("DB_SOCKET_DIR") { '/cloudsql' } %>/<%= ENV['CLOUD_SQL_CONNECTION_NAME'] %>
        database: <%= ENV['DB_NAME'] %>
        username: <%= ENV['DB_USERNAME'] %>
        password: <%= ENV['DB_PASSWORD'] %>
        pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      ```
  
     Create a `.env` file in the root of your project and create the following:
     ```bash
     DB_USERNAME="your-username"
     DB_PASSWORD="your-password"
     DB_HOST="your-instance-connection-name"
     DB_NAME="your-database-name"
     ```
  
     Check that the gemfile includes the `dotenv-rails` gem
     ```ruby
     gem 'dotenv-rails', groups: [:development, :test]
     ```
  
     Create an initialiser to load the `.env` file
     ```ruby
     # config/initialisers/dotenv.rb
     Dotenv.load
     ```
  
  6. Migrate the Database </br>
     Run the following commands to create and migrate the database
     ```bash
     rails db:create
     rails db:migrate
     ```  
  ### Deployment
  1. Ensure you have a Dockerfile for both Frontend and Backend to containerise the setup in `./Frontend/Dockerfile` and `./Backend/Dockerfile`
     
  2. Create a service account
     * Go to Google Cloud Console
     * Navigate to the **IAM & Admin** > **Service accounts**
     * Click **Create Service Account**
     * Create the service account and assign the **Editor** role to the service account. Click **Continue**
     * Click **Done** to create the service account
       
  3. Download the Serice Account Key (secret key)
     * Click on the service account name
     * Navigate to the **Keys** tab
     * Click **Add Key** > **Create new key**
     * Choose **JSON** and click **Create**
     * Save the downloaded JSON file and store it securely in the repository
     
  4. Use the `cloudbuild.yaml` file to automate the deployment of both the backend and frontend to Google Cloud Run
     ```yaml
     steps:
       - id: "build image"
         name: "gcr.io/cloud-builders/docker"
         entrypoint: 'bash'
         args: ["-c", "docker build --build-arg MASTER_KEY=$$RAILS_KEY -t gcr.io/$PROJECT_ID/${_SERVICE_NAME} . "]
         secretEnv: ["RAILS_KEY"]

       - id: "push image"
         name: "gcr.io/cloud-builders/docker"
         args: ["push", "gcr.io/$PROJECT_ID/${_SERVICE_NAME}"]

       - id: "apply migrations"
         name: "gcr.io/google-appengine/exec-wrapper"
         entrypoint: "bash"
         args: ["-c", "/buildstep/execute.sh -i gcr.io/$PROJECT_ID/${_SERVICE_NAME} -s "your-project-id":${_REGION}:${_INSTANCE_NAME} -e RAILS_MASTER_KEY=$$RAILS_KEY -- bundle exec rake db:migrate"]
         secretEnv: ["RAILS_KEY"]

       - id: "run deploy"
         name: "gcr.io/google.com/cloudsdktool/cloud-sdk"
         entrypoint: gcloud
         args: ["run", "deploy", "${_SERVICE_NAME}", "--platform", "managed", "--region", "${_REGION}", "--image", "gcr.io/$PROJECT_ID/${_SERVICE_NAME}", "--add-cloudsql-instances", "${_INSTANCE_NAME}", "--update-secrets=RAILS_MASTER_KEY=${_SECRET_NAME}:latest"]
     
     substitutions:
       _REGION: "your-region "
       _SERVICE_NAME: "your-service-name"
       _INSTANCE_NAME: 'your-instance-name'
       _SECRET_NAME: 'your-secret-name'
  
     availableSecrets:
       secretManager:
       - versionName: projects/$PROJECT_ID/secrets/${_SECRET_NAME}/versions/latest
         env: RAILS_KEY
      
     images:
       - "gcr.io/$PROJECT_ID/${_SERVICE_NAME}"

     ```
  5. Deploy with Google Cloud Build
     ```bash
     gcloud builds submit --config cloudbuild.yaml
     ```
### Deployment with Github Actions
  1. To automate your deployment process, `.github/workflows/deploy.yml` is used.
  2. Ensure that your steps 1-5 for the above Deployment steps are working.
  3. Go to your Github Repository > Settings > Secrets and Variables > Actions
  4. Click on "New Repository Secret" and add the following secrets:
     * Name: GCP_PROJECT_ID, Secret: "Your-Project-ID"
     * Name: GCP_SA_KEY, Secret: copy and paste the information in credentials.json file from your gcloud service account
       
     * Note: Ensure that your gcloud service account has the roles Artifact Registry Reader, Storage Object Viewer and Service Account Token Creator

### Testing
1. Testing using Cucumber
   * All features and user stories with the happy and sad paths are found in the `./Frontend/features` directory
   * All step definitions are found in the `./Frontend/features/step_definitions` directory
   * The Capybara helper can be found in the `./Frontend/features/support/env.rb` directory </br>
     
    Run the acceptance test using the following command
    ```bash
    bundle exec cucumber
    ```
2. Testing using RSpec
   * All unit and integration testing for UI/Views are found in the `./Frontend/spec/views` directory
   * All unit and integration testing for Controllers are found in the `./Frontend/spec/controllers` directory
   
   Run the RSpec test using the following command
    ```bash
    $env:RAILS_ENV='test'
    bundle exec rspec
    ```

## Acknowledgments
1. Michelle Halim 
2. Ong Kang Jun
3. Ng Yu Hueng
4. Tan Ze Lin
5. Mohammed Azfar
6. Lee Rui Yu
