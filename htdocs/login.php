<?php
$host = 'localhost:/baze/sejemv2.fdb';
$username=$_POST["uname"];
$password=$_POST["psw"];

session_start();

$sname=filter_var($username, FILTER_SANITIZE_STRING);
$x=0;

$dbh = ibase_connect($host,$username,$password);
$stmt = "SELECT * FROM staff_login('".$sname."')";

$sth = ibase_query($dbh, $stmt);
while ($row = ibase_fetch_object($sth)) {
    $_SESSION['s_id'] = $row->ID;
    $_SESSION['s_name']=$row->IME;
    $_SESSION['s_surname']=$row->PRIIMEK;
    $_SESSION['username']=$username;
    $_SESSION['pass']=$password;
    setcookie('host',$host,time()+86400);
    session_set_cookie_params(0);
    $x=1;
}

if($x > 0){
    header("Location:main.php");
}
else{
    
    header("Location:index.php?msg=1");
}

ibase_free_result($sth);
ibase_close($dbh);
?>