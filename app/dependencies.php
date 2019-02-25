<?php

//CONTAINER DI:Create  new container service 
// Get the container
$container = $app->getContainer();
// Twig view dependency
$container['view'] = function ($container) {
    $cf = $container->get('settings')['view'];
    $view = new \Slim\Views\Twig($cf['path'], $cf['twig']);
    $view->addExtension(new \Slim\Views\TwigExtension(
        $container->router,
        $container->request->getUri()
    ));
    return $view;
};

// PDO database library
$container['db'] = function ($container) {
    $cf = $container->get('settings')['db'];
    $pdo = new PDO('pgsql:host=localhost;port=5432;dbname=' . $cf['dbname'], $cf['user'], $cf['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};
