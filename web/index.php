<?php

include_once 'tool/globalFunction.class';

ob_start();

include ResolveUrl('/html/bloc/header.php');

loadController();

include ResolveUrl('/html/bloc/footer.php');

ob_end_flush();

?>