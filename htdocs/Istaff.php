<?php
$host = 'localhost:/baze/sejemv2.fdb';
$username=$_POST["uname"];
$name=$_POST["name"];
$sname=$_POST["sname"];
$name=filter_var($name, FILTER_SANITIZE_STRING);
$sname=filter_var($sname, FILTER_SANITIZE_STRING);
$password=password_hash($_POST["psw"], PASSWORD_BCRYPT);

  // attach to the server with proper privileges
  if (($service = ibase_service_attach('localhost', 'sysdba', 'masterkey')) != FALSE) {
    // get server version and implementation strings
    $server_info  = ibase_server_info($service, IBASE_SVC_SERVER_VERSION)
                  . ' / '
                  . ibase_server_info($service, IBASE_SVC_IMPLEMENTATION);
    //ibase_service_detach($service);
}
else {
    $ib_error = ibase_errmsg();
}

//dodamo userja v sistemsko tabelo
if (($result = ibase_add_user($service, $username,$password)) != FALSE) {
    ibase_service_detach($service);
}
else {
    $ib_error = ibase_errmsg();
    //detach from server
    ibase_service_detach($service);
}

/*
$dbh = ibase_connect($host,'sysdba','masterkey');
    $stmt = "GRANT BLA BLA";
    $sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
    while ($row = ibase_fetch_object($sth)) {    
        $row->IZPIS;
    }
*/

//dodamo userja v tabelo staff
$dbh = ibase_connect($host,'sysdba','masterkey');
$stmt = "EXECUTE PROCEDURE I_Staff('". $name ."','" . $sname . "','" . $username . "')";
$sth = ibase_query($dbh, $stmt) or die(ibase_errmsg());
while ($row = ibase_fetch_object($sth)) {    
    $row->IZPIS;
}

?>