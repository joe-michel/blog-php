<?php

// Creating routes
//PSR 7 REQUEST OBJECT
// we will have to specify that we are using the PSR-7 interfaces
use \Psr\Http\Message\ServerRequestInterface;
use \Psr\Http\Message\ResponseInterface;

//ROUTING
// We add our request routes
// instance->http verb GET, POST, DELETE, PUT... ('URI', callBackFunction aka closure(PSR 7 request objec $HTTP request, PSR 7 request objec $HTTP response, $array passed to the URI))
// route for HP
$app->get('/',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'home.twig');
})->setName('home');

$app->post('/log', function(ServerRequestInterface $request,ResponseInterface $response, $args) {
  $password = $request->getParam('password');
  $username = $request->getParam('username');

  $req = $this->db->prepare ('SELECT id, password, label_id FROM users WHERE username = :username');

  $req->execute(array(
    'username' => $username));
  $fetch = $req->fetch();
  $isPasswordOk = password_verify($password, $fetch['password']);
  if (!$isPasswordOk) {
    echo "Le nom d'utilisateur ou le mot de passe est incorrect";
    return $this->view->render($response, 'home.twig');
  } else {
      session_start();
      $_SESSION['id'] = $fetch['id'];
      $_SESSION['label'] = $fetch['label_id'];
      $_SESSION['username'] = $username;
      return $this->view->render($response, 'home.twig', ['curl_result' => $_SESSION]);
    }
})->setName('home');



// Post method for signup and insertion into the DB with password hash
$app->post('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $username = $request->getParam('username');
  $password = password_hash($request->getParam('password'), PASSWORD_BCRYPT);
  $req = $this->db->prepare('INSERT INTO users VALUES (DEFAULT, :username, :password, 0)');
  $req->execute(array(
    'username' => $username,
    'password' => $password));
  $fetch = $req->fetch();
  session_start();
  $_SESSION['username'] = $username;
  return $this->view->render($response, 'home.twig', ['curl_result' => $_SESSION]);
})->setName('signup');

$app->post('/disconnect',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  session_start();
  session_destroy();
  return $this->view->render($response, 'home.twig');
})->setName('home');

$app->post('/dash',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  session_start();
  return $this->view->render($response, 'dashboard.twig', ['curl_result' => $_SESSION]);
})->setName('dashboard');
