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

</body>
</html>