<?php
/**launch from root with: php -S localhost:8000 -t public/
http://localhost:8000/
**/


// Let's ask PHP to display all errors whenever they
// occur in our slim code
ini_set('display_errors', true);

// Require application bootstrap (=php file with the path of all the other required files)
require __DIR__ . '/../bootstrap/app.php';


// Run Slim
$app->run();
