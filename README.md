# Infraestrutura AWS com Terraform

Este repositório contém a infraestrutura como código (IaC) utilizando Terraform para provisionar e gerenciar recursos na AWS, como VPC, EKS, ECR, grupos de segurança e deployments Kubernetes para uma aplicação Django.

## Estrutura do Repositório

- **./Infra**
  - **ECR.tf**: Cria um repositório no Amazon ECR para armazenar imagens Docker.
  - **EKS.tf**: Provisiona um cluster EKS usando o módulo oficial da AWS e configura um grupo de nós gerenciados.
  - **kubernetes.tf**: Configura um deployment Kubernetes e um serviço LoadBalancer para uma aplicação Django.
  - **variables.tf**: Define as variáveis usadas pelos recursos Terraform, como o nome do repositório e o nome do cluster.
  - **GrupoSeguranca.tf**: Define grupos de segurança para permitir acesso SSH ao cluster EKS.
  - **provider.tf**: Configura os provedores AWS e Kubernetes, incluindo autenticação e acesso ao cluster EKS.
  - **VPC.tf**: Cria uma VPC com subnets públicas e privadas, além de configurar gateways NAT.

- **./Environments/Prod**
  - **main.tf**: Utiliza os módulos da infraestrutura definidos na pasta `./Infra` para o ambiente de produção, especificando nomes de recursos específicos para produção.
  - **backend.tf**: Configura o backend do Terraform no S3 para armazenar o estado do Terraform do ambiente de produção.

## Componentes Principais

### 1. ECR (Elastic Container Registry)
Cria um repositório ECR para armazenar as imagens Docker da aplicação.

### 2. EKS (Elastic Kubernetes Service)
Provisiona um cluster EKS com um grupo de nós gerenciados, utilizando o módulo oficial da AWS.

### 3. Kubernetes Deployment
Configura um deployment Kubernetes para a aplicação Django, incluindo réplicas, probes de liveness e um serviço LoadBalancer para expor a aplicação.

### 4. VPC (Virtual Private Cloud)
Cria uma VPC com subnets públicas e privadas, configurando gateways NAT para permitir acesso à Internet a partir das subnets privadas.

### 5. Grupo de Segurança
Define grupos de segurança para permitir acesso SSH ao cluster EKS.