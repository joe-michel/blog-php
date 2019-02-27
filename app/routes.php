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

$app->get('/login',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'login.twig');
})->setName('login');

$app->post('/login', function(ServerRequestInterface $request,ResponseInterface $response, $args) {
  $password = $request->getParam('password');
  $username = $request->getParam('username');

  $req = $this->db->prepare ('SELECT id, password FROM users WHERE username = :username');

  $req->execute(array(
    'username' => $username));
  $fetch = $req->fetch();
  $isPasswordOk = password_verify($password, $fetch['password']);
  if (!$isPasswordOk) {
    echo "Le nom d'utilisateur ou le mot de passe est incorrect";
    return $this->view->render($response, 'login.twig');
  } else {
      session_start();
      $_SESSION['id'] = $fetch['id'];
      $_SESSION['username'] = $username;
      echo "Vous êtes un Beau Gosse";
      return $this->view->render($response, 'home.twig');
    }
})->setName('login');

$app->get('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'signup.twig');
})->setName('signup');

// Post method for signup and insertion into the DB with password hash
$app->post('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $username = $request->getParam('username');
  $password = password_hash($request->getParam('password'), PASSWORD_BCRYPT);
  $req = $this->db->prepare('INSERT INTO users VALUES (DEFAULT, :username, :password, 0)');
  $req->execute(array(
    'username' => $username,
    'password' => $password));
  return $this->view->render($response, 'home.twig');
})->setName('signup');