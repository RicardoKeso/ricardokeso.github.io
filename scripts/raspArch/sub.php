<?php
        $saida = shell_exec('./sub.sh "'.$_POST["title"].'"');
        echo "<pre>$saida</pre>";
        header("Location: ../index.php");
?>
