# Bitbucket Pipelines Pipe: bitbucket-k8-helm-pipe

This pipe is used to build and deploy applicaitons via helm charts.

## Docker image 
  [kalborfon/bitbucket-pipe-helm-k8s](https://hub.docker.com/repository/registry-1.docker.io/kalborfon/bitbucket-pipe-helm-k8s)

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
script:
  - pipe: docker://kalborfon/bitbucket-pipe-helm-k8s:v1.2
    variables:
      NAMESPACE: "<string>" # namespace of project
      AWS_KEY: $AWS_KEY
      AWS_SECRET: $AWS_SECRET
      EKS_CLUSTER: "<string>"
      AWS_REGION: "<string>"
      RELEASE_NAME: '<string>'
      HELM_COMMAND: '<string>' # this along with the next option allows the chart to be installed or upgraded
      HELM_CHART_PATH: '<string>' # path of chart
      HELM_COMMAND_ARGS: '--set version=${TAG} --set env.appEnv=production' # and any other commands


```
## Variables

| Variable              | Usage                                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------- |
| NAMESPACE (*)            | Namespace project          |
| AWS_KEY (*)     | AWS KEY for EKS.                                                                        |
| AWS_SECRET (*) | AWS Secret key for EKS.                                                                 |
| EKS_CLUSTER (*)           | Name of EKS cluster to deploy to.                                                       |
| RELEASE_NAME (*)               | Chart name                         |
| HELM_COMMAND (*)               | path  of chart /<dir>           |
| HELM_CHART_PATH (*)           | Artifactory Docker User for helm and docker repo                                        |
| HELM_COMMAND_ARGS (*)           | Args of command helm                                   |
| AWS_REGION (*)            | AWS Region of the EKS cluster                                                           |

_(*) = required variable._

## Examples

Basic example:

```yaml
script:
  - pipe: docker://kalborfon/bitbucket-pipe-helm-k8s:v1.2
      variables:
        NAMESPACE: "<string>" # namespace of project
        AWS_KEY: $AWS_KEY
        AWS_SECRET: $AWS_SECRET
        EKS_CLUSTER: "<string>"
        AWS_REGION: "<string>"
        RELEASE_NAME: '<string>'
        HELM_COMMAND: '<string>' # this along with the next option allows the chart to be installed or upgraded
        HELM_CHART_PATH: '<string>' # path of chart
        HELM_COMMAND_ARGS: '--set version=${TAG} --set env.appEnv=production' # and any other commands

```
 