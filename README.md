# Azure Databricks Platform

Infrastructure-as-Code and CI/CD platform for deploying an Azure Databricks data platform using **Terraform**, **Azure**, **Unity Catalog**, **Databricks Asset Bundles (DAB)**, and **GitHub Actions**.

The project demonstrates how to build a reproducible Azure Databricks data platform from infrastructure provisioning through data pipeline deployment and CI/CD automation.

---

## 1. Project Overview

This project provisions and manages an Azure Databricks data platform using Infrastructure as Code.

The platform includes:

- Azure Resource Group
- Azure Data Lake Storage Gen2
- Azure Databricks Workspace
- Azure Databricks Access Connector
- Azure Managed Identity
- Azure RBAC permissions
- Unity Catalog
- Unity Catalog Storage Credential
- Unity Catalog External Location
- Bronze, Silver, and Gold schemas
- Unity Catalog volumes
- Databricks workspace permissions
- Databricks Jobs
- Bronze, Silver, and Gold data pipelines
- Terraform remote state
- GitHub Actions CI/CD
- Microsoft Entra ID authentication
- GitHub Actions OIDC / Workload Identity Federation
- Databricks Asset Bundles

The main objective is to demonstrate a modern cloud data engineering platform where infrastructure and data pipelines can be deployed consistently through source control and automation.

---

# 2. Architecture

```text
                         GitHub Repository
                                |
                                |
                         GitHub Actions
                                |
                     OIDC / Workload Identity
                                |
                                v
                       Microsoft Entra ID
                                |
                                |
                Service Principal:
        sp-azure-databricks-terraform
                                |
                 +--------------+--------------+
                 |                             |
                 v                             v
             Terraform                    Databricks
                 |                    Asset Bundles (DAB)
                 |                             |
        +--------+---------+                   |
        |                  |                   |
        v                  v                   v
   Azure Resources     Unity Catalog      Data Pipelines
        |                  |                   |
        |                  |             +-----+-----+
        |                  |             |     |     |
        v                  v             v     v     v
 Resource Group      Catalog         Bronze Silver Gold
        |
        +--------------------+
        |
        v
 ADLS Gen2 Storage
        |
        +-----------------------------+
        |                             |
        v                             v
    Raw Data                    Unity Catalog
                                External Location

---

## Bronze

The Bronze layer contains raw or minimally processed data.

### Purpose

- Preserve source data
- Maintain an auditable raw layer
- Support reprocessing
- Provide a reliable source for downstream transformations

### Datasets

- Users
- Products
- Orders
- Order Items
- Events
- Reviews

---

## Silver

The Silver layer contains cleaned and transformed data.

### Typical Operations

- Removing duplicates
- Handling invalid records
- Standardising columns
- Cleaning data types
- Validating keys
- Handling null values
- Applying business transformations

---

## Gold

The Gold layer contains business-ready datasets.

### The Gold Layer Is Designed For

- Analytics
- Reporting
- Dashboards
- Business intelligence
- Data products
- Downstream applications