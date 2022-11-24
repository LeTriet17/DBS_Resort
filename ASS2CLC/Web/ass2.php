<?php
$serverName = "127.0.0.1,1434";
$uid = "sManager";
$pwd = "123456789";
$databaseName = "ASS2CLC";
$connectionInfo = array("UID" => $uid, "PWD" => $pwd, "Database" => $databaseName);
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn) {

    if (isset($_POST['find']) && isset($_POST['MKH']))
    {
        $mkh = $_POST['MKH'];
        $stmt = "SELECT * FROM dbo.DonDatPhong WHERE MKH='$mkh'";
        $result = sqlsrv_query($conn, $stmt, array(), array("Scrollable" => 'static'));;
        $rows = sqlsrv_num_rows($result);
        for ($j = 0; $j < $rows; ++$j) {
            $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
            $r0 = htmlspecialchars($row['MDP']);
            $r1 = htmlspecialchars($row['NgayNP']->format('Y-m-d'));
            $r2 = htmlspecialchars($row['NgayTP']->format('Y-m-d'));
            $r3 = htmlspecialchars($row['SoKhach']);
            $r4 = htmlspecialchars($row['TinhTrang']);
            $r5 = htmlspecialchars($row['TenGoi']);

            echo <<<_END
  <pre>
    MDP $r0
    NgayNP $r1
    NgayTP $r2
    SoKhach $r3
    TinhTrang $r4
    TenGoi $r5
    MKH $mkh
  </pre>

_END;
        }
    }
    else {
        $stmt = "SELECT * FROM dbo.KhachHang";
        $result = sqlsrv_query($conn, $stmt, array(), array("Scrollable" => 'static'));;
        $rows = sqlsrv_num_rows($result);

        for ($j = 0; $j < $rows; ++$j) {
            $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
            $r0 = htmlspecialchars($row['MKH']);
            $r1 = htmlspecialchars($row['CCCD']);
            $r2 = htmlspecialchars($row['Email']);
            $r3 = htmlspecialchars($row['Username']);
            $r4 = htmlspecialchars($row['Diem']);
            $r5 = htmlspecialchars($row['Loai']);
            $r6 = htmlspecialchars($row['Ho']);
            $r7 = htmlspecialchars($row['Ten']);

            echo <<<_END
  <pre>
    MKH $r0
    CCCD $r1
    Email $r2
    Username $r3
    Diem $r4
    Loai $r5
    Ho va Ten $r6 $r7   
  </pre>
  <form action='ass2.php' method='post'>
  <input type='hidden' name='find' value='yes'>
  <input type='hidden' name='MKH' value='$r0'>
  <input type='submit' value='FIND INFORMATION'></form>
_END;
        }
    }

} else {
    echo "Connection could not be established.\n";
    die(print_r(sqlsrv_errors(), true));
}
sqlsrv_close($conn);


?>