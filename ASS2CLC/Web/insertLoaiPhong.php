<?php
$serverName = "127.0.0.1,1434";
$uid = "Long";
$pwd = "123456789";
$databaseName = "ASS2CLC";
$connectionInfo = array("UID" => $uid, "PWD" => $pwd, "Database" => $databaseName);
$conn = sqlsrv_connect($serverName, $connectionInfo);
if ($conn) {
    $query = "";
    if (isset($_POST['delete']) && isset($_POST['MaLoaiPhong']))
    {
        $mlp = $_POST['MaLoaiPhong'];
        $query = "DELETE FROM dbo.LoaiPhong WHERE MaLoaiPhong='$mlp'";
    }
    if (isset($_POST['MaLoaiPhong']) &&
        isset($_POST['TenLoaiPhong']) &&
        isset($_POST['SoKhach']) &&
        isset($_POST['DienTich'])) {
        $MaLoaiPhong = $_POST['MaLoaiPhong'];
        $TenLoaiPhong = $_POST['TenLoaiPhong'];
        $SoKhach = $_POST['SoKhach'];
        $DienTich = $_POST['DienTich'];
        $query = "INSERT INTO [dbo].[MatHang] ([MaLoaiPhong]
           ,[TenLoaiPhong]
           ,[SoKhach]
           ,[DienTich]) VALUES " .
            "('$MaLoaiPhong', '$TenLoaiPhong', '$SoKhach', '$DienTich';";
    }
    print $query."<br />";
    $result = sqlsrv_query($conn, $query, array(), array("Scrollable" => 'static'));;
    if( $result === false)
    {
        if( ($errors = sqlsrv_errors() ) != null) {
            foreach( $errors as $error ) {
                echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
                echo "code: ".$error[ 'code']."<br />";
                echo "message: ".$error[ 'message']."<br />";
            }
        }
    }

    echo <<<_END
  <form action="insertLoaiPhong.php" method="post"><pre>
    MaLoaiPhong <input type="text" name="MaLoaiPhong">
     TenLoaiPhong <input type="text" name="TenLoaiPhong">
  SoKhach <input type="text" name="SoKhach">
      DienTich <input type="text" name="DienTich">
           <input type="submit" value="ADD RECORD">
  </pre></form>
_END;

    $stmt = "SELECT * FROM dbo.LoaiPhong";
    $result = sqlsrv_query($conn, $stmt, array(), array("Scrollable" => 'static'));
    if (!$result) {
        echo "Error in statement execution.\n";
        die( print_r( sqlsrv_errors(), true));
    }

    $rows = sqlsrv_num_rows($result);

    for ($j = 0; $j < $rows; ++$j) {
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $r0 = htmlspecialchars($row['MaLoaiPhong']);
        $r1 = htmlspecialchars($row['TenLoaiPhong']);
        $r2 = htmlspecialchars($row['SoKhach']);
        $r3 = htmlspecialchars($row['DienTich']);

        echo <<<_END
  <pre>
    MaLoaiPhong $r0
     TenLoaiPhong $r1
  SoKhach $r2
      DienTich $r3
  </pre>
  <form action='insertLoaiPhong.php' method='post'>
  <input type='hidden' name='delete' value='yes'>
  <input type='hidden' name='MaLoaiPhong' value='$r0'>
  <input type='submit' value='DELETE RECORD'></form>
_END;
    }

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