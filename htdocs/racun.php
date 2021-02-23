<?php
session_start();
$dbh = ibase_connect($_COOKIE['host'], $_SESSION['username'], $_SESSION['pass']);
?>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Racun</title>

    <style>
        .boldtext
        {
            font-weight:bold;
        }

        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, .15);
            font-size: 16px;
            line-height: 24px;
            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
            color: #555;
        }

        .invoice-box table {
            width: 100%;
            line-height: inherit;
            text-align: left;
        }

        .invoice-box table td {
            padding: 5px;
            vertical-align: top;
        }

        .invoice-box table tr td:nth-child(2) {
            text-align: right;
        }

        .invoice-box table tr.top table td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.top table td.title {
            font-size: 45px;
            line-height: 45px;
            color: #333;
        }

        .invoice-box table tr.information table td {
            padding-bottom: 40px;
        }

        .invoice-box table tr.heading td {
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }

        .invoice-box table tr.details td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.item td {
            border-bottom: 1px solid #eee;
        }

        .invoice-box table tr.item.last td {
            border-bottom: none;
        }

        .invoice-box table tr.total td:nth-child(2) {
            border-top: 2px solid #eee;
            font-weight: bold;
        }

        @media only screen and (max-width: 600px) {
            .invoice-box table tr.top table td {
                width: 100%;
                display: block;
                text-align: center;
            }

            .invoice-box table tr.information table td {
                width: 100%;
                display: block;
                text-align: center;
            }
        }

        /** RTL **/
        .rtl {
            direction: rtl;
            font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        }

        .rtl table {
            text-align: right;
        }

        .rtl table tr td:nth-child(2) {
            text-align: left;
        }
    </style>
</head>

<body>
    <div class="invoice-box">
        <table cellpadding="0" cellspacing="0">
            <tr class="top">
                <td colspan="2">
                    <table>
                        <tr>
                            <td class="title">
                                <img src="https://www.sparksuite.com/images/logo.png"
                                    style="width:100%; max-width:300px;">
                            </td>

                            <td>
                                Datum Izdaje: <?php echo date("d.m.Y"); ?> <br>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr class="information">
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                Sejem d.o.o.<br>
                                Celovška 113<br>
                                1000 Ljubljana
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="information">
                <td colspan="2">
                    <table>
                        <tr>
                            <td class="boldtext">
                                RAČUN
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr class="heading">
                <td>
                    ID artikla
                </td>
                <td>
                    Ime artikla
                </td>
                <td>
                    Davek
                </td>
                <td>
                    Provizija
                </td>

                <td>
                    Cena
                </td>
            </tr>
            <?php
$uid=$_GET["gumb"]; 
$stmt = "SELECT id,ime,davek,provizija,cena FROM show_basket('" . $uid . "')";
$sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
$cenaSum = 0;
while ($row1 = ibase_fetch_object($sth)) {
    $row[]=$row1;
    $cenaSum += $row1->CENA;
}

  foreach($row as $r => $y)
  {


    if($r < count($row)-1)
        echo '<tr class="item">';
    else
        echo '<tr class="item last">';



    foreach($y as $k => $x )
    {

      if($k == 'DAVEK' || $k == 'PROVIZIJA')
        $x *= 100;

      if($k == 'DAVEK' || $k == 'PROVIZIJA' || $k=='CENA')
        echo '<td>'.number_format($x,2,',','.');

    else
        echo '<td>'.$x.'</td>';

    if($k == 'DAVEK' || $k == 'PROVIZIJA')
        echo '%</td>';

    else if($k == 'CENA')
        echo '€</td>';

  }
  
  echo '</tr>';
  
}
echo'<tr><td class="boldtext">Skupna cena:</td><td></td><td></td><td></td> <td class="item boldtext">'.number_format($cenaSum,2,',','.')."€ </td></tr>";



?>
</table>
</div>
</body>
</html>
<?php
$staff=$_SESSION['s_id'];
$kupec=$uid;
$stmt = "SELECT * FROM show_basket('".$kupec."')";
$sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
while ($row = ibase_fetch_object($sth)) {
    $IID=$row->ID;
    $stm = "execute procedure input_EVENT('3','" .$staff. "','" . $kupec . "','" . $IID . "')";
    $st = ibase_query($dbh, $stm) or die(ibase_errmsg());
    while ($row2 = ibase_fetch_object($st)){
    }
}
?>