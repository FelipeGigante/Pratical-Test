<!-- Get today’s currency rates based in EUR from the ECB and save them on a CSV file, named
“usd_currency_rates_{date}, with two columns - “Currency Code” and “Rate” - based in USD  --!>

<?php

//data source
$url = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml?5105e8233f9433cf70ac379d6ccc5775";

//starting curl
$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HEADER, false);

//execute curl
$response = curl_exec($curl);
curl_close($curl);

//transforming data
$xml = new SimpleXMLElement($url, null, true);
$data = json_encode($xml);
$array = (json_decode($data, true));

//create csv file
$date = date('m/d/Y');
$header_args = array('Currency Code', 'Rate');
header('Content-Type: text/csv; charset=utf-8');
header("Content-Disposition: attachment; filename=usd_currency_rates_{$date}.csv");
$output = fopen( 'php://output', 'w' );
ob_end_clean();
fputcsv($output, $header_args, "|");


//reading data & inserting in csv
for ($i = 0; $i < count($array['Cube']['Cube']['Cube']); $i++) {
  foreach ($array['Cube']['Cube']['Cube'][$i] as $value) {
    $currency = $value['currency'];
    
    //converting to dollar base (unless it's the dollar itself)
    if($currency == "USD"){
      $rateUSD = $value['rate']; 
      $fields = [$currency, $rateUSD];
    }
    else{
      $rate = ($value['rate'] * $rateUSD); 
      $fields = [$currency, $rate];
    }
    # exporting data to csv - opens in notepad correctly
    fputcsv($output, $fields, "|"); 
  }  
}

?>