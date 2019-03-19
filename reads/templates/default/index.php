<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="reads-content">
<?php 
$index_file = BASE_UPLOAD_PATH.DS.ATTACH_READS.DS.'index_html'.DS.'index.html';
if(is_file($index_file)) {
    require($index_file);
}
?>
</div>
