<?php
$serverName = "127.0.0.1,1434";
$uid = "Long";
$pwd = "123456789";
$databaseName = "ASS2CLC";
$connectionInfo = array("UID" => $uid, "PWD" => $pwd, "Database" => $databaseName);
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn) {
    if (isset($_POST['MaChiNhanh']) &&
        isset($_POST['Nam'])) {
        $MaChiNhanh = $_POST['MaChiNhanh'];
        $Nam = $_POST['Nam'];
        $procedure_params = array(
            array(&$MaChiNhanh, SQLSRV_PARAM_IN),
            array(&$Nam, SQLSRV_PARAM_IN)
        );
        $sql = "ThongKeLuotKhach @MCN = ?, @nam = ?";
        $stmt = sqlsrv_prepare($conn, $sql, $procedure_params);
        $result = sqlsrv_execute( $stmt );
        if($result  === false ) {

            die( print_r( sqlsrv_errors(), true));

        }else{
            do {
                while ($row = sqlsrv_fetch_array($stmt)) {
                    $r0 = htmlspecialchars($row['Thang']);
                    $r1 = htmlspecialchars($row['TongSoKhach']);


                    echo <<<_END
  <pre>
Thang $r0
TongSoKhac $r1
  </pre>
_END;
                }
            } while (sqlsrv_next_result($stmt));

        }

    }

    echo <<<_END
  <form action="viewThongKe.php" method="post"><pre>
    MaChiNhanh <input type="text" name="MaChiNhanh">
     Nam <input type="text" name="Nam">
           <input type="submit" value="Thong Ke">
  </pre></form>
_END;




} else {
    echo "Connection could not be established.\n";
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_close($conn);
function get_post($conn, $var)
{
    return $conn->quote($_POST[$var]);
}

?>