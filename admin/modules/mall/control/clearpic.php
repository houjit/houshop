<?php

defined('INSYSVIEW') or exit('Access Invalid!');

class clearpicControl extends SystemControl {

    public function __construct() {
        // parent::__construct();
    }

    public function goodPicPath() {
        //商品上传目录路径
        return BASE_UPLOAD_PATH . DS . ATTACH_GOODS;
    }

    public function delPicGroup($pic, $picname = '') {
        $picArr1 = explode('/', $pic);
        //图片名
        $pic1 = end($picArr1);
        if ($picname)
            return $pic1;
        //图片路径
        $picPath = str_replace($pic1, '', $pic);

        $pictmp = explode('.', $pic1);
        $picName = $pictmp[0];
        $picExt = $pictmp[1];

        $piclist = array(
            $picPath . $picName . '.' . $picExt,
            $picPath . $picName . '_1280.' . $picExt,
            $picPath . $picName . '_240.' . $picExt,
            $picPath . $picName . '_360.' . $picExt,
            $picPath . $picName . '_60.' . $picExt,
        );
        return $piclist;
    }

    public function index() {
        $model = Model();
        $picPath = $this->goodPicPath();
        $path = $picPath;
        $picall = $this->my_dir($path);
        foreach ($picall as $value) {
            $tSize = count($value);
            if ($tSize > 0) {
                foreach ($value as $subval) {
                    $picname = $this->delPicGroup($subval, 1);
                    $goods_imagess = $model->table('goods_images')->where(array('goods_image' => $picname))->select();
                    if (!$goods_imagess)
                        $picarr[] = $subval;
//                    $picarr[] = $subval;
                }
            }
//            if($value)$picarr[] =$value;
        }
        // 删除图片
        if (chksubmit()) {
            if (empty($_POST['id'])) {
                showMessage('请选择要删除的图片');
            }
            $delList = $_POST['id'];
            foreach ($delList as $val) {
                $delid = $picarr[$val];
                $delarr = $this->delPicGroup($delid);
                if ($delid) {
                    foreach ($delarr as $val) {
                        @unlink($val);
                    }
                    //$model->table('sns_albumpic')->where($where)->delete();
                    $this->log(L('feiwa_del,feiwa_member_album_manage') . '[无用图片清理ID:' . implode(',', $_POST['id']) . ']', 1);
                }
            }
            showMessage('删除成功');
        }
        $id = intval($_GET['id']);

        //分页
        $curpage = intval($_GET['curpage']);
        if ($curpage < 1)
            $curpage = 1;
        $pageSize = 50;
        $total = count($picarr);
        $pgsize = ceil($total / $pageSize);
        if($curpage>$pgsize) $curpage = $pgsize;
        $pageStr = $pageSize * ($curpage - 1);
        $pageEnd = $pageSize * $curpage;
        if ($pageEnd > $total)
            $pageEnd = $total;
        if ($pageStr > $total)
            $pageStr = 0;
        //echo $pageStr.'--'.$pageEnd;
        for ($index = $pageStr; $index < $pageEnd; $index++) {
            $pic_list[$index] = $picarr[$index];
        }
//        print_r($pic_list);
        Tpl::output('id', $id);
        Tpl::output('showpage', $this->pager(urlAdminMall('clearpic', '', array('curpage' => '')), $curpage, $pageSize, $total));
        Tpl::output('pic_list', $pic_list);
        Tpl::setDirquna('mall');
        Tpl::showpage('clearpic.piclist');

        $picPath = $this->goodPicPath();
        $path = $picPath;
        $picall = $this->my_dir($path);
        //Tpl::setDirquna('system');
        //Tpl::showpage('area.index');
    }

    //循环目录下所有文件
    public function my_dir($dir) {
        $files = array();
        if (is_dir($dir)) {
            $handle = opendir($dir);
            if ($handle) {
                while (($file = readdir($handle)) != false) {
                    if ($file != '.' && $file != '..' && $file != 'index.html') {
                        if (is_dir($dir . "/" . $file)) {
                            $files[$file] = $this->my_dir($dir . "/" . $file);
                        } else {
                            if (!preg_match('/_1280|_240|_360|_60/', $file))
                                $files[] = $dir . "/" . $file;
                        }
                    }
                }
            } else {
                echo '文件目录地址有问题！';
            }
            closedir($handle);
            return $files;
        }
    }

    public function pager($pgurl, $curpage, $pgnum, $total, $maxln = 10) {
        $pgstr = ""; // 1 … 2 | 3 | 4 | 5 … 10
        $curpage = (!empty($curpage) && is_numeric($curpage) && (intval($curpage) > 0)) ? $curpage : 1;
        $pgsize = ceil($total / $pgnum);
        $page = min($curpage, $pgsize);

        // Page space
        $space = $page - floor($maxln / 2);
        if ($space <= 0) {
            $start = 1;
        } else {
            $start = ($page + floor($maxln / 2)) > $pgsize ? ($pgsize - min($maxln, $pgsize) + 1) : $space;
        }
        $pend = ($start + $maxln) > $pgsize ? ($pgsize + 1) : ($start + $maxln);

        // Previous
        if ($page > 1) {
            $pgstr .= "<li><a href=\"{$pgurl}" . ($page - 1) . "\" class=\"pager_link\"><span>上一页</span></a></li>&nbsp;";
        }
        // 1 …
        if (($page + ceil($maxln / 2) - 1 > $maxln) && ($maxln < $pgsize)) {
            $pgstr .= "<li><a href=\"{$pgurl}1\" class=\"pager_link\"><span>1&nbsp;…&nbsp;</span></a></li>";
        }
        // 2 | 3 | 4 | 5
        for ($i = $start; $i < $pend; $i++) {
            $ctag = ($page == $i) ? ' currentpage' : '';
            $pgstr .= "<li><a href=\"{$pgurl}{$i}\" class=\"pager_link{$ctag}\"><span class=\"{$ctag}\">{$i}</span></a></li>&nbsp;";
        }
        // … 10
        if (($page <= $pgsize - ceil($maxln / 2)) && ($maxln < $pgsize)) {
            $pgstr .= "<li><a href=\"{$pgurl}{$pgsize}\" class=\"pager_link\">{$pgsize}</a></li>";
        }
        // Next
        if ($page < $pgsize) {
            $pgstr .= "<li><a href=\"{$pgurl}" . ($page + 1) . "\" class=\"pager_link\"><span>下一页</span></a></li>";
        }

        return '<ul>' . $pgstr . '</ul>';
    }

}
