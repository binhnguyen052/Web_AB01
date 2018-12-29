<?php
//config

//cấu hình kết nối cơ sở dữ liệu
//host
define('DB_HOST', "localhost");
//user sử dụng
define('DB_USER', "root");
//mật khẩu
define('DB_PASSWORD', "");
//database sử dụng
define('DB_DATABASE', "photon");
//port: cổng mạng
define('DB_PORT', 3306);


class Database
{
    /**
     * Khai báo biến kết nối
     * @var [type]
     */
    public $link = null;

    public function __construct()
    {
        // // $this->link = mysqli_connect("localhost", "root", "", "eshopv", 3308);
        // $this->link = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_DATABASE, DB_PORT);
        // mysqli_set_charset($this->link, "utf8");
        // if (mysqli_connect_error()) {
        //     die("Không thể kết nối: " . $link->connect_error);
        // } else {
        //     echo "kết nối thành công";
        // }
    }

    /**
     * hàm mở kết nối 
     */
    public function db_connect()
    {
        //kiểm tra biến $link (connect database) đã khởi tạo connect chưa
        if (!$this->link) {
            // $this->link = mysqli_connect("localhost", "root", "", "photon", 3308);
            $this->link = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_DATABASE, DB_PORT);
            mysqli_set_charset($this->link, "utf8");
            
            //xuất thông báo xem có kết nối được hay không?
            if (mysqli_connect_error()) {
                die("Không thể kết nối: " . mysqli_error($this->link));
            } else {
                // echo "kết nối thành công";
            }
        }
    }

    /**
     * hàm đóng kết nối 
     */
    public function db_close()
    {
        //nếu có mở kết nối thì đóng kết nối
        if ($this->link) {
            mysqli_close($this->link);
        }
    }

    /*
     * hàm thực thi câu truy vấn
     * $query: câu truy vấn cần thực thi
     */
    public function executeQuery($conn, $query)
    {
        //$this->db_connect();
        $result = mysqli_query($conn , $query) or die(" Lỗi Truy Vấn " .  mysqli_error($conn));
        //$this->db_close();
        return $result;
    }
}    


?>