<!DOCTYPE html>
<html>
        <head>
        <meta charset="UTF-8">
        <title>titles</title>
        <script https://code.jquery.com/jquery-2.2.3.min.js>
        </script>
        </head>
        <body>
                <form action="files/sub.php" method="post">
                        Title: <input type="text" name="title">
                        <input type="submit" value="ok">
                </form>
                <?php
#                       header("Refresh:10");

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
                        echo $_POST["title"];
                ?>
        </body>
</html>
