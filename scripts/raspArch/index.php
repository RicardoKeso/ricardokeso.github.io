<!DOCTYPE html>
<html>
        <head>
        <meta charset="UTF-8">
        <title>ArchRPi</title>
        <script https://code.jquery.com/jquery-2.2.3.min.js>
        </script>
        </head>

        <body>
                <?php
                        header("Refresh:10");
                        echo "<div>";
                        $path = "torrents/";
                        $diretorio = dir($path);
                        $cont = 0;
                        echo "<strong>ADDED</strong><br/><br/>";
                        while($arquivo = $diretorio -> read()){
                                if (($arquivo != "..") && ($arquivo != ".")) {
                                        echo $arquivo."<br />";
                                        $cont++;
                                }
                        }
                        if ($cont == 0) {
                                echo "empty";
                        }
                        $diretorio -> close();
                        echo "</div><br><hr><br>";
                        //------------------------------------------------------------------------
                        echo "<div>";
                        $path = "incomplete/";
                        $diretorio = dir($path);
                        $cont = 0;
                        echo "<strong>INCOMPLETE</strong><br/><br/>";
                        while($arquivo = $diretorio -> read()){
                                if (($arquivo != "..") && ($arquivo != ".")) {
                                        echo $arquivo."<br />";
                                        $cont++;
                                }
                        }
                        if ($cont == 0) {
                                echo "empty";
                        }
                        $diretorio -> close();
                        echo "</div><br><hr><br>";
                        //------------------------------------------------------------------------
                        echo "<div>";
                        $cont=0;
                        $path = "storage/";
                        $diretorio = dir($path);
                        echo "<strong>FINISHED</strong><br/><br>";
                        while($arquivo = $diretorio -> read()){
                                if (($arquivo != "..") && ($arquivo != ".")) {
                                        echo "<a href='".$path.$arquivo."'>".$arquivo."</a><br />";
                                        $cont++;
                                }
                        }
                        if ($cont == 0) {
                                echo "empty";
                        }
                        $diretorio -> close();
                        echo "</div><br><hr><br>";
                        //------------------------------------------------------------------------
                        echo "<div>";
                        echo "<b>";
                        echo shell_exec('date');
                        echo "</b>";
                        $ponteiro = fopen("dados", "r");
                        while (!feof ($ponteiro)) {
                                echo $linha."<br>";
                                $linha = fgets($ponteiro, 4096);
                        }
                        fclose($ponteiro);
                        echo shell_exec('awk \'{printf "Temp: %3.1f C\n", $1/1000}\' /sys/class/thermal/thermal_zone0/temp');
                        echo "<br>";
                        echo shell_exec('curl -s http://checkip.amazonaws.com');
                        echo " - public<br>";
                        echo shell_exec('ip a | grep "inet " | grep -v "127.0.0.1" | awk \'{print $2 " - " $7}\' | sed \':a;$!N;s/\n/<br>/g;ta\'');
                        echo "<br><br>";
                        echo "</div><hr><br>";
                ?>
                <div style="color: white;">
                        kingbradley - S1gmUndF!
                </div>
        </body>
</html>
