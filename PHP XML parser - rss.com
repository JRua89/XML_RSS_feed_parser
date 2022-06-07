
$url = "YOUR_XML_FILE_HERE";

$xml = simplexml_load_file($url);

$html = "";

for($i = 0; $i < $xml->count(); $i++){

	//image for each podcast episode
	$ns_itunes = $xml->channel->item[$i]->children('http://www.itunes.com/dtds/podcast-1.0.dtd');
	$itunesimage= $ns_itunes->image->attributes();
	$itunesduration= $ns_itunes->duration;
  
 
	$title = $xml->channel->item[$i]->title;
	$link = $xml->channel->item[$i]->link;
	$description = $xml->channel->item[$i]->description;
	$pubDate = $xml->channel->item[$i]->pubDate;
	$copyright = $xml->channel->copyright;
	$duration = $xml->channel->item[$i]->duration;
	$enclosure = $xml->channel->item[$i]->enclosure['url'];

	$html .= "<a target='_blank' href='$link'><b>$title</b></a>"; // Title of post
	$html .= "$description"; // Description
	$html .= "<br />$pubDate<br /><br />"; // Date Published
	$html .= $itunesimage;
	$html .= $itunesduration;
	$html .= $duration;
	
}
	
	echo "$html<br />";
