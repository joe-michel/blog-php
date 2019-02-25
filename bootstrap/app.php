<?php
/**
 *  Slim Application setting
 *  and bootstrapping
 */

 //USE VENDOR
 // Call composer to autoload(make them available)
 // all classes from the the `vendor` folder
 // located at vendor/autoload.php
 require __DIR__ . '/../vendor/autoload.php';

// Application settings - table that has to be in variable
$settings = require __DIR__ . '/../app/settings.php';

// call of the Slim application using its namespace
//instanciation using the object settings as argument.
use Slim\App;
$app = new Slim\App( $settings );

// Add our dependencies to the container
require __DIR__ . '/../app/dependencies.php';

// Require our route
require __DIR__ . '/../app/routes.php';
