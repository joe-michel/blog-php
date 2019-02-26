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
  $password = $_POST['password'];
  $username = $_POST['username'];
  //$id = $_POST['id'];
  $req = $this->db->prepare ('SELECT id,password FROM users WHERE username= :username');
  $req->execute(array(
    'username' => $username));
  $fetch = $req->fetch();
  $isPasswordOk = password_verify($password, $fetch['password']);
  if (!$isPasswordOk) {
    echo "Nique ta grand-mère en jet-ski";
  } else {
    if ($isPasswordOk) {
      session_start();
      $_SESSION['id'] = $fetch['id'];
      $_SESSION['username'] = $username;
      echo "Vous êtes un Beau Gosse";
    } else {
      echo "Mange tes morts";
    }
  }
  return $this->view->render($response, 'home.twig');
})->setName('login');

$app->get('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'signup.twig');
})->setName('signup');

// Post method for signup and insertion into the DB with password hash
$app->post('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $username = $_POST['username'];
  $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
  $req = $this->db->prepare('INSERT INTO users VALUES (DEFAULT, :username, :password)');
  $req->execute(array(
    'username' => $username,
    'password' => $password));
  return $this->view->render($response, 'signup.twig');
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
