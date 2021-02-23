<?php
session_start();
$i=ucwords($_SESSION['s_name']);
$p=ucwords($_SESSION['s_surname']);
$x= $i . ' ' . $p;
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="site.css">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet">
  <title>SEJEM</title>

  <style>
*{
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

input[type=number]{
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 8px 8px 8px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #333;
  color: white;
  padding: 15px 40px;
  margin-top: 10px;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: red;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

.col-25 {
  float: left;
  width: 8%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 10%;
  margin-top: 6px;
}

.col-100 {
  float: left;
  width: 18%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
}
}
</style>
</head>

<body class="body">
  <h5 id="lpolje">Prijavljen kot: <?php echo  $x; ?></h5>
  <menu>
    <ul class="bar">
      <li><a href="gen_mem.php">Generiranje Udeležencev</a></li>
      <li><a href="Iproduct.php">Vnos Izdelka</a></li>
      <li><a href="reservation.php">Rezervacija</a></li>
      <li><a href="basket.php">Košarica</a></li>
      <li><a href="out.php">Prevzem</a></li>
      <li style="float:right"><a href="logout.php">Odjava</a></li>
      <li class="dropdown">
        <a href="javascript:void(0)" class="dropbtn">Analitika</a>
        <div class="dropdown-content">
          <a href="cashf.php">Cash flow</a>
          <a href="staffo.php">Zaposleni</a>
          <a href="flow.php">Product & person flow</a>
        </div>
    </ul>
  </menu>
<div class="container">
<form method="get">

<div class="row">
  <div class="col-25">
    <label for="izdelek"><b>ID izdelka: </b></label>
  </div>
  <div class="col-75">
    <input type="text" name="izdelek"><br>
  </div>
</div>

<div class="row">
  <div class="col-25">
    <label for="kupec"><b>ID kupca: </b></label>
  </div>
  <div class="col-75">
    <input type="text" name="kupec"><br>
  </div>
</div>

<div class="row">
  <div class="col-100">
    <input type="submit" value="Potrdi">
  </div>
</div>
</form>

<?php
if(isset($_GET['izdelek']) && isset($_GET['kupec']))
{
    $izdelek=filter_var($_GET['izdelek'], FILTER_SANITIZE_STRING);
    $kupec=filter_var($_GET['kupec'], FILTER_SANITIZE_STRING);

    $dbh = ibase_connect($_COOKIE['host'], $_SESSION['username'], $_SESSION['pass']);
    $stmt = "execute procedure input_EVENT('2','" .$_SESSION['s_id']. "','" . $kupec . "','" . $izdelek . "')";
    $sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
    while ($row = ibase_fetch_object($sth)) {    
        echo '<h4 align="center">' .$row->IZPIS. '</h4>';
    }

}


?>

</body>
</html>