# Kong API Gateway - Practice Lab 

This is Kong API Gateway OSS tutorial to install and configure with docker. 



## Introduction 

In this tutorial, we will walk through with several installation options and deployment topology. Kong Gateway is a low-demand, high-performing API gateway. You can set up Kong Gateway with  it  various self-managed systems. This training course designed to learn Kong Gateway.

Through a series of modules and lab exercises, the fundamental and advance concepts of Kong Gateway will be presented and put into practice by managing Kong Gateway, designing an API, and exposing the API through Kong Gateway. This course balances lecture, hands-on exercise

## Setup instruction Guide 

There are several prerequisites that are needed prior to running Kong Gateway on your local laptop/workstation. These are outlined below (with links to external web sites).

Setup and installation is divided into two Part. 

1. Prerequesties and required tools. 
   
    • Install docker community edition - https://docs.docker.com/engine/install/
   
    • Install cURL - https://everything.curl.dev/get
   
    • Install httpie https://httpie.io/docs/cli/installation
   
    • Install deck https://docs.konghq.com/deck/latest/installation/
   
    • Install postman or insomnia -   https://www.postman.com/downloads/ https://insomnia.rest/download
   

   We use Docker as local containerized applications hence we will use docker to pull kong images in every mode.

3. Kong Deployment topology

   Kong Gateway can be deployed in four different modes:

    
    • DB-less and declarative
    •	Traditional (database)
    • Hybrid
    •	Kong Konnect 
 

    Each mode has benefits and limitations, so it is important to consider them carefully when deciding which mode to use to install Kong Gateway in production.

    The following sections briefly describe each mode.

    ### DB-less mode

    <img width="660" alt="image" src="https://github.com/user-attachments/assets/31fbdd56-4206-4eac-ab5d-23223f6dc442">

    When running in DB-less mode, configuration is provided to Kong Gateway using a second file. This file contains your configuration in YAML or JSON format using Kong’s declarative   
    configuration syntax.


    ### Traditional mode

    In traditional mode, Kong Gateway requires a database to store configured entities such as routes, services, and plugins. Kong Gateway supports PostgreSQL 10+. you will get kong manger an 
    admin UI to manage the kong entrities.


     <img width="660" alt="image" src="https://github.com/user-attachments/assets/5148256d-da13-46fa-a84c-27e4cf62ee09">


    ### Hybrid mode

    Traditionally, Kong has always required a database, to store configured entities such as routes, services, and plugins. Hybrid mode, also known as control plane / data plane separation 
    (CP/DP), removes the need for a database on every node.

    In this mode, Kong nodes in a cluster are split into two roles: control plane (CP), where configuration is managed and the Admin API is served from; and data plane (DP), which serves traffic     for the proxy. Each DP node is connected to one of the CP nodes, and only the CP nodes are directly connected to a database.

    <img width="660" alt="image" src="https://github.com/user-attachments/assets/24c67993-d896-40e1-ad2a-223f00767673">

4. Lab Setup

   1.  run setup.sh to start kong in different mode, currenly it supports dbless, db, and hybrid
   2.  this script will use docker-compose.yaml file and pull latest image from the hub.
  
5. Kong Gateway Overview

   <img width="660" alt="image" src="https://github.com/user-attachments/assets/a7670380-db66-4ccc-8e12-295863d32027">



    • what is client ?

    • what is service ?

    • what is route ?

    • what is plugin ?

    • what is upstream ?
   

   
    






