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

//Methode pour rediriger en fonction des permissions du user
/*$app->get('/login', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $permission = $request->getParam('permission');
  $user = $request->getParam('username');
//Url de redirection
  $url_user = 'http://home_user.twig';
  $url_admin = 'http://home_admin.twig';
  $url_author = 'http://home_author.twig';
//Requête effectuée
  $req = $this->db->prepare ('SELECT id, username FROM users');
  $req = $this->db->prepare ('SELECT id, rank FROM permissions');
//Switch pour savoir où et quel moment il est redirigé
  switch ($permission) {
    case 'user':
      header('Location: $url_user');
      break;
    case 'admin':
      header('Location: $url_admin');
      break;
    case 'author':
      header('Location: $url_author');
      break;
  };
  return $this->view->render($response, 'home_user.twig');
})->setName('user');*/

//We make the login page with a method post
$app->get('/login',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'login.twig');
})->setName('login');
//Here we compare to see if the is registered in our db
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

//we initiate our signup page
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

// route for about +DB content
$app->get('/about',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $sth = $this->db->prepare("SELECT id, name, profile FROM about");
  $sth->execute();
  $about = $sth->fetchAll();
  //return $this->response->withJson($about);
  return $this->view->render($response, 'about.twig', ['curl_result' => $about] );
})->setName('about');

// route for contact
$app->get('/contact',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'contact.twig');
})->setName('contact');

// Post Requests
$app->post('/confirm',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  //we put the content of the form in an array and then in a variable
  $data = ['contentForm' => $request->getParam('contentForm')];
  //because we can only send an array as argument in a render
  return $this->view->render($response, 'confirm.twig', $data);
})->setName('confirm');

// get content of DB
/*$app->get('/contendDb', function (ServerRequestInterface $request,ResponseInterface $response,$arg) {
    $sth = $this->db->prepare("SELECT `id`, `name`, profile FROM `about`");
    $sth->execute();
    $about = $sth->fetchAll();
    return $this->response->withJson($about);
});*/
