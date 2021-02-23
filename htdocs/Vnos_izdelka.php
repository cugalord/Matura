<?php
session_start();
if (isset($_GET['ime'])) {
    $ime = filter_var($_GET['ime'], FILTER_SANITIZE_STRING);
    $tip = filter_var($_GET['tip'], FILTER_SANITIZE_STRING);
    $lastnik = filter_var($_GET['lastnik'], FILTER_SANITIZE_STRING);
    $opis = filter_var($_GET['opis'], FILTER_SANITIZE_STRING);
    $cena = $_GET['cena'];

    $dbh = ibase_connect($_COOKIE['host'], $_SESSION['username'], $_SESSION['pass']);
    $stmt = "execute procedure input_product('" . $ime . "','" . $opis . "','" . $cena . "','" . $tip . "','" . $lastnik . "')";
    $sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
    while ($row = ibase_fetch_object($sth)) {
        $stm="SELECT FIRST 1 ProductID FROM EVENT WHERE memberid= '$lastnik' AND eventtype=1 ORDER BY TIME_STAMP DESC";
        $sth = ibase_query($dbh, $stm);
        while ($row = ibase_fetch_object($sth)) {
            header("Location:prevzem.php?msg=".$row->PRODUCTID."");
        }
    } 
}

else {
    header("Location:Iproduct.php?msg=2");
}
?>