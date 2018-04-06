# Bike

## Overview

The BikeShare API is a set of APIs and services that enable:

- Bike sharing poviders to post the location and use of their bike fleets to a data repository for providing reporting and analytics capabilities.
The APIs allow the data to be conditioned and analyzed, to produce reports and visualizations of the successes and impacts of the BikeSharing program in a protected environment.
- Administrate and set up alerts that notify providers when data compliance violations occur or user trends are changing. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. The path to the resources in the quickstart folder are intended to be used to get a minimal single deployment. There are additional solutions and resources in the BikeShare Solutions folder to provide more extinsive capablities. 

### Prerequisites

- User access to Azure
- Powershell installed on PC
- Azure CLI / Cloud Shell

### Setup

#### Building the Repository

#### Quick Overview
The deployment has depends on building the deployment assets on the Azure subscription followed by deploying the database then azure functions. The order of the components built and deployed is important to be able to deploy a new instance in Azure. The order of the deployment is creation of the Resoruce Group and Azure enviroment followed by the database setup and finally the Azure Functions. 

The initial deployment tasks are related to setting up a Resource Group that will contain the database and functions. The deployment resources can be edited if desired but it is suggested to start with the defaults. 

##### Step 1: Create an Azure Resource Group #####
There are many ways to create a Resource Group either with the Azure Portal or with other tools but in this example I will be using the Azure Cli in a powershell console. Using other means of setting up and configuring the components in Azure will not cause any issues just maintain the naming consistency. 

Using Azure CLI running in  a local powershell window the command to log into your azure account is shown below.
``` 
az login
az account set -s "Your subscription name"
```
Once you have logged into Azure the following command can be used to create the resource group that will be used for the deployment. 

```
az group create --name tdcbikeshare01 --location "WEST US"
```

##### Step 2: Create the SQL Server in the resource group #####

The SQL Server setup creates the server resources necessary to host the SQL Databases in. The az cli commands to setup and a SQL Server instance have requred parameters shown in the below example. The key parameter is the Resoures Group which provides the association to the rest of the. 

```
az sql server create -p Kmcx5XsyU%TZ4M4Q -u bikeshareadmin -l WESTUS -n bikeshare01-sqlsvr -g bikeshare01
```
##### Step 3: Create the databases #####
Using the bacpac (binary) database schema the tdcbikeshare_db database can be imported into the _sqlsvr. The primary database that has to be setup is the bikesharedb which has been serailize into the bikesharedb.bacpac file. Using powershell the blob can be uploaded to the storage account in the bikeshare01 resource group where it can then be imported to the bikeshare01-sqlsvr.  

``` 
$StorageContext = Get-AzureRmStorageAccount -Name 'tdcbikesstore' -ResourceGroupName "tdcbikeshare" 

$src = 'tdcbikesharedb.bacpac'
$dst = 'tdcbikesharedb.bacpac'
$StorageContext | Set-AzureStorageBlobContent -Container 'staging' -File $src -Blob $dst
```

##### Step 4: Deploy the functions #####
Using the Azure Cli in powershell or cloud shell run the deployment and point to the ARM Template and Parameters files. The powershell script will deploy the functions and appinsights components to the tdcbikeshare resource group. 

```
 az group deployment create --name bikesharedeploy --resource-group bikeshare01 --template-file template.json --parameters parameters.json
```

##### Step 5: Finalize the AppInsights and configurations #####

At this part of the setup the Azure Portal can be used to explore the resource group bikeshare01 and adjust any configurations needed. If thier are issues with any of the deployment steps the logging is normally found in the resource groups deployments feature. 



#### Documentation #####
The documentation for the site, functions and databases can be found in the root of the api-functions and sql-procedures folders. The documentation can provide further guidance on how to modify or use the apis. 


## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors


See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.


## License

This project is licensed under the MIT License - see the [license.md](./LICENSE.md) file for details

## Acknowledgments


