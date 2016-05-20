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
                        $ponteiro = fopen("dados", "r");

                        while (!feof ($ponteiro)) {
                                $linha = fgets($ponteiro, 4096);
                                echo $linha."<br>";
                        }
                        fclose($ponteiro);
                        echo "</div><hr><br>";
                ?>
                <div style="color: white;">
                        kingbradley - S1gmUndF!
                </div>
        </body>
</html>
