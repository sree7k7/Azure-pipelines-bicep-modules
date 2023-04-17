# Deploy Vnet, Vm, NSG VpnGW using Azure Pipelines

### creating resources using azure bicep modules.

## Run
  - [Purpose](#purpose)
  - [Prerequsites](#prerequsites)
  - [Repository](#repository)
  - [Pipelines](#pipelines)
  - [Clean up](#clean-up)

## Purpose

Create Azure pipelines, and automate to deploy your azure infra/resources in (azure portal) an resource group.

![Alt text](pics/pipeline.png)
## Prerequsites

- [azure cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) & [sign in](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli).
- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep) & [Azure pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/get-started/what-is-azure-pipelines?view=azure-devops).
- Create a resource group in Azure portal with the following command.
  
  ```
  az group create -g contoso -l northeurope
  ```

## Repository

1. Create a repository and clone the repo. Follow this Ref [gudie](https://learn.microsoft.com/en-us/training/modules/build-first-bicep-deployment-pipeline-using-azure-pipelines/3-exercise-create-run-basic-pipeline) (create organization, project).
   
   - To clone, navigate to Repos -> click: Clone in VS Code (shown in below pic):
  ![Alt text](pics/azure-repo.png)

2. After cloning createa folder `deploy`. Add a file with name and code (scripted here): [azure-pipeline.yml](deploy/azure-pipeline.yml).

3. Copy (outside `deploy` directory): [main_module.bicep](main_module.bicep), [vm.bicep](vm.bicep), [vnet_vpngw.bicep](vnet_vpngw.bicep).

4. commit and push the code.
   
   ```hcl
   git add .
   git commit -m "first commit"
   git push
   ```

## Pipelines

1. login to [dev.azure.com](https://azure.microsoft.com/en-us/products/devops).
2. After, creating an organization (e.g: *first-org*) and (private) project (e.g: *first-project*). Might created in above steps.
3. Create a service connection:
   - In project settings (located at bottom) → Service connections → Create service connection → Azure Resource Manager → Service principal (automatic) → select: Subscription → Resource group: contoso → Service connection name: contoso.

![Alt text](pics/service_connection.png)

> **Note**: Create a resource group in Azure portal: **contoso**. And keep service connection name: **contoso** (In [azure-pipeline.yml](deploy/azure-pipeline.yml) these variables values are predefined). And **tick**: Grant access permission to all pipelines.

4. Create a pipeline → Repository: Azure Repos Git → choose your repo → Configure your pipeline: Existing Azure Pipelines YAML file → path: `/deploy/azure-pipeline.yml` → Run pipeline.


![Alt text](pics/pipeline_config.png)
5. Check your resources deployed using azure pipelines.
   
## Clean up
- In terminal execute the following command:
```azcli
az group delete -g "contoso" --no-wait
```