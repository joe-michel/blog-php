<?php

session_start();

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
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
});


//We make the login page with a method post
$app->get('/login',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'login.twig');
})->setName('login');
//Here we compare to see if the is registered in our db

$app->post('/log', function(ServerRequestInterface $request,ResponseInterface $response, $args) {
//Login
  $password = $request->getParam('password');
  $username = $request->getParam('username');

  $req = $this->db->prepare ('SELECT id, password, label_id FROM users WHERE username = :username');
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  $req->execute(array(
    'username' => $username));
  $fetch = $req->fetch();
  $isPasswordOk = password_verify($password, $fetch['password']);
  if (!$isPasswordOk) {
    echo "Le nom d'utilisateur ou le mot de passe est incorrect";
    return $this->view->render($response, 'articles.twig', ['display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
  } else {
      $_SESSION['id'] = $fetch['id'];
      $_SESSION['label'] = $fetch['label_id'];
      $_SESSION['username'] = $username;
      return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
    }
})->setName('log');

//we initiate our signup page
$app->get('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  return $this->view->render($response, 'signup.twig');
})->setName('signup');

// Post method for signup and insertion into the DB with password hash
$app->post('/signup',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $username = $request->getParam('username');
  $password = password_hash($request->getParam('password'), PASSWORD_BCRYPT);
  $req = $this->db->prepare('INSERT INTO users VALUES (DEFAULT, :username, :password, 1)');
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  $req->execute(array(
    'username' => $username,
    'password' => $password));
  $fetch = $req->fetch();
  $_SESSION['username'] = $username;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('signup');

$app->post('/disconnect',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  session_destroy();
  return $this->view->render($response, 'articles.twig', ['display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('disconnect');

$app->post('/dash',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $user_view = $this->users;
  $all_article_view = $this->all_articles;
  return $this->view->render($response, 'dashboard.twig', ['curl_result' => $_SESSION, 'user_view' => $user_view, 'page_name' => 'dashboard', 'display_all_article' => $all_article_view, 'page_name' => 'dashboard']);
})->setName('dash');

// button from dashboard.twig to load articles.twig
$app->post('/leaveDash',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('leaveDash');

$app->post('/new_article',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $title = $request->getParam('title');
  $content = $request->getParam('content');
  $author_id = $_SESSION['id'];
  $date = date("d/m/y");
  $req = $this->db->prepare ("INSERT INTO articles VALUES (DEFAULT, :title, '$author_id', :content, '$date')");
  $req->execute(array(
    'title' => $title,
    'content' => $content));
  $fetch = $req->fetch();
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('new_article');

$app->post('/delete_article/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $req = $this->db->prepare ("DELETE FROM articles WHERE id = :id");
  $req->bindValue('id',$args['id']);
  $req->execute();
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('delete_article');

$app->post('/delete_article_dash/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $req = $this->db->prepare ("DELETE FROM articles WHERE id = :id");
  $req->bindValue('id',$args['id']);
  $req->execute();
  $all_article_view = $this->all_articles;
  $user_view = $this->users;
  return $this->view->render($response, 'dashboard.twig', ['curl_result' => $_SESSION, 'display_all_article' => $all_article_view, 'user_view' => $user_view, 'page_name' => 'dashboard']);
})->setName('delete_article_dash');

$app->post('/edit/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $title = $request->getParam('title');
  $content = $request->getParam('content');
  $id = $args['id'];
  $req = $this->db->prepare ("UPDATE articles SET title = :title, content = :content WHERE id='$id'");
  $req->execute(array(
    'title' => $title,
    'content' => $content));
  $fetch = $req->fetch();
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('edit');

$app->post('/edit_dash/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $title = $request->getParam('title');
  $content = $request->getParam('content');
  $id = $args['id'];
  $req = $this->db->prepare ("UPDATE articles SET title = :title, content = :content WHERE id='$id'");
  $req->execute(array(
    'title' => $title,
    'content' => $content));
  $fetch = $req->fetch();
  $all_article_view = $this->all_articles;
  $user_view = $this->users;
  return $this->view->render($response, 'dashboard.twig', ['curl_result' => $_SESSION, 'display_all_article' => $all_article_view, 'user_view' => $user_view, 'page_name' => 'dashboard']);
})->setName('edit_dash');

$app->post('/comment/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $commentary = $request->getParam('commentary');
  $date = date("d/m/y");
  $article_id = $args['id'];
  $user_id = $_SESSION['id'];
  $req = $this->db->prepare ("INSERT INTO comments VALUES (DEFAULT, '$user_id', '$article_id', :commentary, '$date')");
  $req->execute(array(
    'commentary' => $commentary));
  $fetch = $req->fetch();
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('comment');

$app->post('/delete_comment/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  $req = $this->db->prepare ("DELETE FROM comments WHERE id = :id");
  $req->bindValue('id',$args['id']);
  $req->execute();
  $article_view = $this->articles;
  $comments_view = $this->comments;
  $authors_view = $this->authors;
  return $this->view->render($response, 'articles.twig', ['curl_result' => $_SESSION, 'display_article' => $article_view, 'display_comments' => $comments_view, 'display_author' => $authors_view]);
})->setName('delete_comment');

$app->post('/sort/{id}', function(ServerRequestInterface $request,ResponseInterface $response,$args) {
    $id = $args['id'];
    $req = $this->db->prepare ("SELECT articles.id, username, title, author_id, content, date FROM articles INNER JOIN users ON articles.author_id = users.id WHERE users.id = '$id';");
    $req->execute();
    $sort_authors = $req->fetchAll();
    $comments_view = $this->comments;
    $authors_view = $this->authors;
    return $this->view->render($response, 'authors.twig', ['curl_result' => $_SESSION, 'display_sort_article' => $sort_authors, 'display_comments' => $comments_view, 'display_author' => $authors_view, 'page_content' => 'sort']);
})->setname('sort');

//function to toggle user status user/author
$app->post('/confirm-users',function(ServerRequestInterface $request,ResponseInterface $response,$args) {
  foreach ($_POST as $value) {
    $dataPost = isset($value) ? $value : NULL;//check if the element exists
    list($user, $status) = explode("::", $dataPost);//split values into two variables
    $req = $this->db->prepare('UPDATE users SET label_id=:status WHERE id=:user');
    $req->execute(array(
      'user' => $user,
      'status' => $status,
    ));
  }
  //unset($i);//destroy the reference on the last element
  $user_view = $this->users;
  $all_article_view = $this->all_articles;
  // session_start();
  return $this->view->render($response, 'dashboard.twig', ['curl_result' => $_SESSION, 'user_view' => $user_view, 'display_all_article' => $all_article_view, 'page_name' => 'dashboard']);
})->setname('confirm-users');
//end function to toggle user status user/author
