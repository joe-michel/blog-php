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

$container['articles'] = function ($container) {
    $req = $container->db->prepare ('SELECT articles.id, title, author_id, content, username, date FROM articles INNER JOIN users ON users.id = articles.author_id ORDER BY articles.id DESC LIMIT 5');
    $req->execute();
    $article_view = $req->fetchAll();
    return $article_view;
};

$container['authors'] = function ($container) {
    $req = $container->db->prepare ('SELECT * FROM users WHERE label_id >= 2');
    $req->execute();
    $authors_view = $req->fetchAll();
    return $authors_view;
};

$container['users'] = function ($container) {
    $req = $container->db->prepare ('SELECT users.id, username, label_id, user_label FROM users INNER JOIN labels ON users.label_id = labels.id');
    $req->execute();
    $user_view = $req->fetchAll();
    return $user_view;
};

$container['comments'] = function ($container) {
    $req = $container->db->prepare ('SELECT comments.id, article_id, username, comments.date, content FROM comments INNER JOIN users ON comments.author_id = users.id ORDER BY comments.id DESC');
    $req->execute();
    $comments_view = $req->fetchAll();
    return $comments_view;
};

$container['all_articles'] = function ($container) {
    $req = $container->db->prepare ('SELECT articles.id, title, author_id, content, username, date FROM articles INNER JOIN users ON users.id = articles.author_id ORDER BY articles.id DESC');
    $req->execute();
    $all_article_view = $req->fetchAll();
    return $all_article_view;
};