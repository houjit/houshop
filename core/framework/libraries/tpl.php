<?php
defined('INSYSVIEW') or exit('Access Invalid!'.EADBEEFDEEAEA);
class Tpl
{
	private static $instance = null;
	private static $output_value = array();
	private static $tpl_dir='';
	private static $tpl_quna='';
	private static $layout_file = 'layout';
	private function __construct()
	{
	}
	public static function getInstance()
	{
		if (self::$instance === null || !(self::$instance instanceof Tpl))
		{
			self::$instance = new Tpl();
		}
		return self::$instance;
	}
	public static function setDir($dir)
	{
		self::$tpl_dir = $dir;
		return true;
	}
	public static function setDirquna($dirt)
	{
		self::$tpl_quna = $dirt;
		return true;
	}
	public static function setLayout($layout)
	{
		self::$layout_file = $layout;
		return true;
	}
	public static function output($output,$input='')
	{
		self::getInstance();
		self::$output_value[$output] = $input;
	}
	public static function showpage($page_name='',$layout='',$time=2000)
	{

		if (!defined('TPL_NAME')) define('TPL_NAME','default');
		self::getInstance();
		if (!empty(self::$tpl_dir))
		{
			$tpl_dir = self::$tpl_dir.DS;
		}
		if (empty($layout))
		{
			$layout = 'layout'.DS.self::$layout_file.'.php';
		}
		else 
		{
			$layout = 'layout'.DS.$layout.'.php';
		}
		$layout_file = BASE_PATH.'/templates/'.TPL_NAME.DS.$layout;
		if(empty(self::$tpl_quna))
		{
			$tpl_file = BASE_PATH.'/templates/'.TPL_NAME.DS.$tpl_dir.$page_name.'.php';
		}
		else
		{
			$tpl_file = BASE_PATH.'/modules/'.self::$tpl_quna.'/templates/'.TPL_NAME.DS.$tpl_dir.$page_name.'.php';
		}
		if (file_exists($tpl_file))
		{
			$output = self::$output_value;
			$output['html_title'] = $output['html_title']!='' ? $output['html_title'] :$GLOBALS['setting_config']['site_name'];
			$output['seo_keywords'] = $output['seo_keywords']!='' ? $output['seo_keywords'] :$GLOBALS['setting_config']['site_name'];
			$output['seo_description'] = $output['seo_description']!='' ? $output['seo_description'] :$GLOBALS['setting_config']['site_name'];
			$output['ref_url'] = getReferer();
			Language::read('common');
			$lang = Language::getLangContent();
			@header("Content-type: text/html; charset=".CHARSET);
			if ($layout != '')
			{
				if (file_exists($layout_file))
				{
					include_once($layout_file);
				}
				else 
				{
					$error = 'Tpl ERROR:'.'templates'.DS.$layout.' is not exists';
					throw_exception($error);
				}
			}
			else 
			{
				include_once($tpl_file);
			}
		}
		else 
		{
			$error = 'Tpl ERROR:'.'templates'.DS.$tpl_dir.$page_name.'.php'.' is not exists';
			throw_exception($error);
		}
	}
	public static function showTrace()
	{
		$trace = array();
		$trace[Language::get('nc_debug_current_page')] = $_SERVER['REQUEST_URI'].'<br>';
		$trace[Language::get('nc_debug_request_time')] = date('Y-m-d H:i:s',$_SERVER['REQUEST_TIME']).'<br>';
		$query_time = number_format((microtime(true)-StartTime),3).'s';
		$trace[Language::get('nc_debug_execution_time')] = $query_time.'<br>';
		$trace[Language::get('nc_debug_memory_consumption')] = number_format(memory_get_usage()/1024/1024,2).'MB'.'<br>';
		$trace[Language::get('nc_debug_request_method')] = $_SERVER['REQUEST_METHOD'].'<br>';
		$trace[Language::get('nc_debug_communication_protocol')] = $_SERVER['SERVER_PROTOCOL'].'<br>';
		$trace[Language::get('nc_debug_user_agent')] = $_SERVER['HTTP_USER_AGENT'].'<br>';
		$trace[Language::get('nc_debug_session_id')] = session_id().'<br>';
		$log = Log::read();
		$trace[Language::get('nc_debug_logging')] = count($log)?count($log).Language::get('nc_debug_logging_1').'<br/>'.implode('<br/>',$log):Language::get('nc_debug_logging_2');
		$trace[Language::get('nc_debug_logging')] = $trace[Language::get('nc_debug_logging')].'<br>';
		$files = get_included_files();
		$trace[Language::get('nc_debug_load_files')] = count($files).str_replace("\n",'<br/>',substr(substr(print_r($files,true),7),0,-2)).'<br>';
		return $trace;
	}
	public static function flexigridXML($flexigridXML)
	{
		$page = $flexigridXML['now_page'];
		$total = $flexigridXML['total_num'];
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
		header("Last-Modified: " . gmdate( "D, d M Y H:i:s" ) . "GMT" );
		header("Cache-Control: no-cache, must-revalidate" );
		header("Pragma: no-cache" );
		header("Content-type: text/xml");
		$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$xml .= "<rows>";
		$xml .= "<page>$page</page>";
		$xml .= "<total>$total</total>";
		if(empty($flexigridXML['list']))
		{
			$xml .= "<row id=''>";
			$xml .= "<cell></cell>";
			$xml .= "</row>";
		}
		else
		{
			foreach ($flexigridXML['list'] as $k => $v)
			{
				$xml .= "<row id='".$k."'>";
				foreach ($v as $kk => $vv)
				{
					$xml .= "<cell><![CDATA[".$v[$kk]."]]></cell>";
				}
				$xml .= "</row>";
			}
		}
		$xml .= "</rows>";
		echo $xml;
	}
	public static function flexigridfXML($flexigridXML)
	{
		$page = $flexigridXML['now_page'];
		$total = $flexigridXML['total_num'];
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
		header("Last-Modified: " . gmdate( "D, d M Y H:i:s" ) . "GMT" );
		header("Cache-Control: no-cache, must-revalidate" );
		header("Pragma: no-cache" );
		header("Content-type: text/xml");
		$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$xml .= "<rows>";
		$xml .= "<page>$page</page>";
		$xml .= "<total>$total</total>";
		foreach ($flexigridXML['list'] as $k => $v)
		{
			$xml .= "<row id='".$k."'>";
			$xml .= "<cell><![CDATA[".$v['operation']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['channel_name']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['channel_style']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['gc_name']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['channel_show']."]]></cell>";
			$xml .= "</row>";
		}
		$xml .= "</rows>";
		echo $xml;
	}
	public static function flexigridXMLfloor($flexigridXML)
	{
		$page = $flexigridXML['now_page'];
		$total = $flexigridXML['total_num'];
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
		header("Last-Modified: " . gmdate( "D, d M Y H:i:s" ) . "GMT" );
		header("Cache-Control: no-cache, must-revalidate" );
		header("Pragma: no-cache" );
		header("Content-type: text/xml");
		$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$xml .= "<rows>";
		$xml .= "<page>$page</page>";
		$xml .= "<total>$total</total>";
		foreach ($flexigridXML['list'] as $k => $v)
		{
			$xml .= "<row id='".$k."'>";
			$xml .= "<cell><![CDATA[".$v['operation']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['web_name']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['web_page']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['update_time']."]]></cell>";
			$xml .= "<cell><![CDATA[".$v['web_show']."]]></cell>";
			$xml .= "</row>";
		}
		$xml .= "</rows>";
		echo $xml;
	}
	public static function flexigroupbuyXML($flexigridXML)
	{
		$page = $flexigridXML['now_page'];
		$total = $flexigridXML['total_num'];
		header("Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
		header("Last-Modified: " . gmdate( "D, d M Y H:i:s" ) . "GMT" );
		header("Cache-Control: no-cache, must-revalidate" );
		header("Pragma: no-cache" );
		header("Content-type: text/xml");
		$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$xml .= "<rows>";
		$xml .= "<page>$page</page>";
		$xml .= "<total>$total</total>";
		if(empty($flexigridXML['list']))
		{
			$xml .= "<row id=''>";
			$xml .= "<cell></cell>";
			$xml .= "</row>";
		}
		else
		{
			foreach ($flexigridXML['list'] as $k => $v)
			{
				$xml .= "<row id='".$k."'>";
				$xml .= "<cell><![CDATA[".'--'."]]></cell>";
				foreach ($v as $kk => $vv)
				{
					$xml .= "<cell><![CDATA[".$v[$kk]."]]></cell>";
				}
				$xml .= "</row>";
			}
		}
		$xml .= "</rows>";
		echo $xml;
	}
	public static function groupedValues($data, $cou_id, $sk_id)
	{
		foreach ($data as $k => $v) 
		{
			$quna[$v[$cou_id]][$v[$sk_id]]=$v[$sk_id];
		}
		return $quna;
	}
	public static function indexedValues($data, $sku_id, $cou_id)
	{
		if(!empty($data))
		{
			foreach ($data as $k => $v) 
			{
				$quna[$v[$sku_id]]=$v[$cou_id];
			}
		}
		else
		{
			$quna=$data;
		}
		return $quna;
	}
	public static function groupIndexed($data, $cou_id, $sk_id)
	{
		foreach ($data as $k => $v) 
		{
			if($sk_id == 'sku_id')
			{
				$quna[$v[$cou_id]][$v[$sk_id]]=array('price'=>$v['price']);
			}
			else if($sk_id == 'xlevel')
			{
				$quna[$v[$cou_id]][$v[$sk_id]]=$v;
			}
		}
		return $quna;
	}
	public static function indexed($indexed_data, $indexed_xlevel)
	{
		if($indexed_xlevel == 'xlevel')
		{
			foreach ($indexed_data as $indexed_k => $indexed_v) 
			{
				$data[$indexed_v[$indexed_xlevel]]=$indexed_v;
			}
		}
		elseif($indexed_xlevel == 'goods_id')
		{
			foreach ($indexed_data as $index_k => $index_v) 
			{
				$data[$index_v[$indexed_xlevel]]=$index_v;
			}
		}
		return $data;
	}
	public static function uniqueValues($data, $sku_id)
	{
		print_r($data);
		return $data;
	}
}
?>