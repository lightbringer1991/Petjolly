<?PHP

# [PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8] 
# [PRIV8                       Email extractor by Mr.FuGiTiVe                         PRIV8]
# [PRIV8                           http://hacker-1.com                                PRIV8]
# [PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8 PRIV8] 


#definimos variables de busqueda
$pais = $_POST['pais'];
$dominio = $_POST['dominio'];
$rubro = $_POST['rubro'];
$tipo = $_POST['tipo'];
$lista = "";
$num = 0; #total de mails
$lastlist = "";
$lastlist1= "";

#si safe mode esta off nos cargamos el limit time, sino hay que poner el safe_mode en off
#en php.ini o modificar el valor max_execution_time a mas de 30000

set_time_limit(30000); 

if (isset($_POST['google'])) { $google = $_POST['google'];}
else { $google = "NOP";}

if (isset($_POST['mamma'])) { $mamma = $_POST['mamma'];}
else { $mamma = "NOP";}

if (isset($_POST['msn'])) { $msn = $_POST['msn'];}
else { $msn = "NOP";}

if (isset($_POST['ask'])) { $ask = $_POST['ask'];}
else { $ask = "NOP";}

if (isset($_POST['alltheweb'])) { $alltheweb = $_POST['alltheweb'];}
else { $alltheweb = "NOP";}

if (isset($_POST['ya'])) { $ya = $_POST['ya'];}
else { $ya = "NOP";}

if (isset($_POST['aol'])) { $aol = $_POST['aol'];}
else { $aol = "NOP";}



$rubro_ar = explode("
",$rubro);
$tipo_ar = explode("
",$tipo);






echo "<html><head><style>
*{
background-color:#242629;
font-family:Verdana,sans-serif;
color:white;
font-size:12px;
}
a,a:link,a:visited
{
text-decoration:none;
color:orange
}
a:hover
{
color:red;
}
</style><title>Extracting E-Mails...</title></head><body>";

echo "<h1>COMENZANDO! Esto puede tardar unos minutos...</h1><br>";


function busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista){
$N=0; #para la string
$N2=0;
$R=0; #for ask string
$M=1; #for mamma string
$PD = 0;
for ($x = 0; $x < count($rubro_ar);$x++) {
for ($asd = 0; $asd < count($tipo_ar);$asd++){
echo "<br><h1>Buscando $rubro_ar[$x] + $tipo_ar[$asd] en $class.com</h1><br>";
	for ($S = 0; $S<500;$S++)
		{
		$conexion = fsockopen ($server2, 80);

		if ($conexion) {
		if ($class == "msn"){
		$string="/results.aspx?q=$rubro_ar[$x]+%40$dominio+$tipo_ar[$asd]+loc%3A$pais&go=Buscar&first=$N";
				    }
		elseif ($class == "google"){
		$string = "/search?hl=es&lr=&q=%40$dominio+$rubro_ar[$x]+$tipo_ar[$asd]+-spam+-fraude&start=$N2&sa=N";
					    }
		elseif ($class == "alltheweb"){
		$string = "/search?cat=web&cs=iso88591&q=$rubro_ar[$x]+%40$dominio+$tipo_ar[$asd]+site%3A$pais&rys=0&itag=crv&_sb_lang=pref";
						}
		elseif ($class == "ask"){
		$string = "/web?q=$rubro_ar[$x]+%40$dominio+$tipo_ar[$asd]&o=312&l=dir&qsrc=1&dm=adv&&advl=es&advc=mx&page=$R";
					}
		elseif ($class == "aol"){
		$string = "/search?invocationType=comsearch40&query=@%24dominio+%24rubro_ar%5B%24x%5D+%24tipo_ar%5B%24asd%5D+-spam+-fraude&do=Search";
					}
		elseif ($class == "ya") {
		$string = "/search?q=$rubro_ar[$x]+%40$dominio+$tipo_ar[$asd]

&start=$N&origen=box&rbpref=advanced&destino=web&as_dt=i&as_ft=i&as_occt=any&as_qdr=all&as_sitesearch=.$pais&gl=%3F%3F&hl=es";
					}
		elseif ($class == "mamma") {
		$string = "/Mamma?utfout=1&query=$rubro_ar[$x]+%40$dominio+$tipo_ar[$asd]+site%3A.$pais&qtype=0&rpp=15&cb=Mamma&index=$M";
					}
echo "Cadena de busqueda: <br>" .$string."<br>";
		$busqueda  = "GET ". $server.$string ." HTTP/1.0\r\n";
		$busqueda .= "Accept: image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash,application/vnd.ms-excel, 

application/vnd.ms-powerpoint, application/msword, */*\r\n";
		$busqueda .= "Referer: http://$server\r\n";
		$busqueda .= "User-Agent: Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.1)\r\n";
		$busqueda .= "Connection: Keep-Alive";
		$busqueda .= "Host: $server\r\n\r\n";


		fputs($conexion,$busqueda);
			
		$resultado = "";
			
	while(!feof($conexion)) 	{
		$resultado .= fgets($conexion,128);
					}

		$splited = explode(" ",$resultado);

		for ($i = 0; $i < count($splited); $i++) 	{

		$shit = explode("@",$splited[$i]);

		if (  count($shit) > "1" )	{

			if ($shit[0] != "" && $shit[1] != "")	{
				if ($splited[$i] == "!important}@media") {}
				else {
				$mailo = $splited[$i];
				$lala = substr($splited[$i], -1);
				if ($lala == "." or $lala == "," or $lala == ";" or $lala == ":") {
					$mailo = substr($mailo,0,strlen($mailo)-1);
												  }

				$mailo = strip_tags($mailo);

			if (eregi("^[A-Z0-9._%-]+@[A-Z0-9._%-]+\.[A-Z]{2,6}$", $mailo)) {
				$lista = $lista . $mailo . "
";
				$num = $num +1;
				}
				$lastlist = $lastlist . $splited[$i];

				     }
								}
						}
		else 	{
			}
							}

#echo $resultado;

$PD = $PD+1;
if ($PD > 200) { echo "<br>"; $PD=0;}

if ($N != "0" or $R !="0" or $M != "0")	{
	if ($lastlist != $lastlist1)	{
		echo "Total mails: ". $num . "<br><br> ";
		$lastlist1 = $lastlist;
		$lastlist = "";
		$N = $N +10;
		$R = $R +1;
		$M = $M +15;
		$N2 = $N2 + 10;
			   		}
	else	{
		$N = 0;
		$R = 0;
		$N2 = 0;
		$M = 1;
		break;
    		}
		}
else { 
$N = $N +10; 
$R = $R+1;
$M = $M +15;
$lastlist1 = $lastlist;
$lastlist = "";
     }

	}
else { echo "Fallo en la conexion";}
}}}
echo "<br><br>________________________________________________________________<br><br>";
echo "Total de mails obtenidos en " .$class. ".com: " .$num;
if ($num < 10) { echo " (posiblemente baneado?) ";}
if ($num < 500 and $num > 10) { echo " (son bastante pocos...) ";}
if ($num > 500 and $num < 1000) { echo " (no esta mal, podria ser mejor...) ";}
if ($num > 1000 and $num < 2000) { echo " (un muy buen trabajo) ;) ";}
if ($num > 2000 and $num < 5000) { echo " (un excelente trabajo!!) ";}
if ($num > 5000) { echo " (esto es INCREIBLE!!!!) ";}

$master = fopen("lista_mails.txt",'a');
fwrite($master,$lista."
");
fclose($master);
echo "<br>Lista agregada a <a href=lista_mails.txt>lista_mails.txt</a><br>";
echo "Continua la busqueda...";
echo "<br><br>________________________________________________________________<br><br>";
}


if ($msn == "on"){
$server = "http://search.live.com";
$server2 = "search.live.com";
$class = "msn";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
if ($google == "on"){
$server = "http://www.google.com.co";
$server2 = "www.google.com.co";
$class = "google";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
if ($alltheweb == "on"){
$server = "http://www.alltheweb.com";
$server2 = "www.alltheweb.com";
$class = "alltheweb";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
			}
if ($ask == "on"){
$server = "http://es.ask.com";
$server2 = "es.ask.com";
$class = "ask";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
if ($ya == "on"){
$server = "http://busca.ya.com";
$server2 = "busca.ya.com";
$class = "ya";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
if ($mamma == "on"){
$server = "http://mamma.com";
$server2 = "mamma.com";
$class = "mamma";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
if ($aol == "on"){
$server = "http://www.aol.com";
$server2 = "www.aol.com";
$class = "aol";
busca($rubro_ar,$tipo_ar,$pais,$dominio,$server,$lastlist,$lastlist1,$num,$server,$server2,$class,$lista);
		}
echo "<br><br>________________________________________________________________<br><br>";
echo "<h1>Finalizado!</h1>";
?>