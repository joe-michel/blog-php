
# Becode  JEPSEN LG - Create your blog!

![Becode logo](img/becode-logo.png)

## Contributors

- [Louis Cantinieaux](https://github.com/LouisCantinieaux)
- [Vincent Chilot](https://github.com/Raigyo)
- [Mathieu Jasselette](https://github.com/MatthieuJasselette)
- [Joé Michel](https://github.com/joe-michel)

## Goal of the exercice

Create a client server application that allow users to post articles, comment them or delete them according their user rights. The feature requested are those usually encountered in blogs.

Our client are our Becode coaches:
[Nicolas Vanhoren](https://github.com/nicolas-van) and [Nicolas 'Jule' Jamar](https://github.com/NicolasJamar)

The project started on **Monday 25th of February 2019** and the deadline was for **Friday 15th of March 2019**.

## Technologies covered by the exercise

* Use of PHP Slim Framework (routing / CRUD, PSR7 request objects, Forms...)
* Use of Composer, vendors, namespaces
* Use of Twig and container dependencies injection (DI))
* PHP Data Objects (PDO) to connect the database
* PostgreSQL database
* Website and database deployment using scripts and Bash

## Using the application (Front-end part)

According to your rights, you will be able to use some features:

### As unregistered user

### As registered user

### As author

### As administrator

## Deploying the application (Back-end part)

### Architecture of the website

├── app

│   ├── dependencies.php

│   ├── routes.php

│   └── settings.php   

├── bootstrap

│   └── app.php

├── css

│   └── style.css

├── templates

│   ├── partials

│   │   ├── footer.twig

│   │   └── nav.php

│   ├── about.twig

│   ├── contact.twig

│   ├── home.twig

│   └── layout.twig

├── vendor

│   ├── Several folders used by composer

│   └── autoload.php

├── composer.json

├── composer.lock

└── README.md


**--app/dependencies--**

Container service for Twig-Views, DB connection and SQL request results.

**--app/routes--**

PSR 7 request object + routing and functions displaying content according user actions.

**--app/settings--**

Object setting to indicate to the application where to find our twig templates + object to define DB Settings.

**--bootstrap/app--**

Slim Application setting and bootstrapping.


**--templates/partial--**

Common parts of the twig templates.

**--templates--**

Templates for each page + general layout.

**--index--**

Landing page, launch bootstrap and the application.


## Sources and documentation

[Slim documentation](http://www.slimframework.com/docs/)

[The workshop of Marco De Bona and Valentin Grégoire from Becode/Hamilton about Bash and scripting](https://github.com/AnarionBe/BashIt)
