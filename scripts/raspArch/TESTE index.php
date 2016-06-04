<!DOCTYPE html>
<html>
        <head>
        <meta charset="UTF-8">
        <title>titles</title>
        <script https://code.jquery.com/jquery-2.2.3.min.js>
        </script>
        </head>
        <body>
                <form action="files/whait.php" method="post">
                        Title: <input type="text" name="title">
                        <!--input type="checkbox" name="files[]" value="1" checked="true">IMDB Data |
                        <input type="checkbox" name="files[]" value="2" checked="true">Poster |
                        <input type="checkbox" name="files[]" value="4" checked="true">Srt |-->
                        <input type="checkbox" name="torrent" value="8" checked="true">Torrent
                        </br>
                        <input type="submit" value="ok">
                        <br><br>
                        <hr>

                </form>
                <!-- #Region PHP -->
                <?php
#                       header("Refresh:10");
/*
                        $sum = 0;
                        foreach($_POST['files'] as $fileVal) {
                                $sum += $fileVal;
                        }
                        echo decbin($sum);
*/
                        echo "<div>";
                        $path = "files/";
                        $diretorio = dir($path);
                        $cont = 0;

                        echo "<br/><strong>Files</strong><br/><br/>";

                        while($arquivo = $diretorio -> read()){
                                if (($arquivo != "..") && ($arquivo != ".") && ($arquivo != "sub.sh") && ($arquivo != "sub.php")){
                        echo "<a href='".$path.$arquivo."'>".$arquivo."</a><br />";
                        $cont++;
                                }
                        }

                        if ($cont == 0) {
                                echo "empty";
                        }

                        $diretorio -> close();
                        echo "</div><br><hr><br>";
                ?>
                <!-- #EndRegion -->
        </body>
</html>
