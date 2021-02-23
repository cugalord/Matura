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
    /* STYLE ZA TABELO */
    table {
      font-family: arial, sans-serif;
      border-collapse: collapse;
      width: 100%;
    }

    td,
    th {
      border: 1px solid #dddddd;
      text-align: left;
      padding: 8px;
    }

    tr:nth-child(even) {
      background-color: #dddddd;
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

  <?php

    $dbh = ibase_connect($_COOKIE['host'], $_SESSION['username'], $_SESSION['pass']);
    $stmt = "SELECT * FROM cash_log";

    $sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
    echo '<table><tr><th>Event ID</th><th>Izdelek ID</th><th>Ime prodajalca</th><th>Priimek prodajalca</th><th>Priimek izdelka</th><th>Cena izdelka</th><th>Provizija Izdelka</th><th>DDV Izdelka</th></tr>';
    while ($row = ibase_fetch_object($sth)) {
        echo '<tr><td>' . $row->EVENTID . '</td><td>' . $row->IZDELEKID . '</td><td>' . $row->IMES . '</td><td>' . $row->PRIIMEKS . '</td><td>' . $row->IME_IZDELKA . '</td><td>' . number_format($row->CENA_IZDELKA,2,',','.')  . ' €' .  '</td><td>' . number_format($row->PROVIZIJA_IZDELKA,2,',','.')  . ' %' . '</td><td>'. number_format($row->DAVEK_IZDELKA,2,',','.')  . ' %' .'</td></tr>';
    }


    $stmt = "SELECT * FROM cash_sum";
    $sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
    while ($row = ibase_fetch_object($sth)) {
        echo '<tr><th>Skupno prometa: '.number_format($row->SKUPNO,2,',','.'). ' €'.'</th></tr>';
        echo '<tr><th>Skupno provizija: '.number_format($row->PROFIT,2,',','.'). ' €'.'</th></tr>';
        echo '<tr><th>Skupno davek: '.number_format($row->DAVEK,2,',','.'). ' €'.'</th></tr>';

    }

    echo '</table>';
  ?>
</body>
</html>