#Get specific data - “Date” and “Close” - for the past 10 days from Yahoo Finance and save it
#on a CSV file, named “eur_btc_rates.csv”, with two columns - “Date” and “BTC Closing Value”.

import csv
import pandas as pd
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

#starting the webdriver - with closed browser
chrome_options = Options()
chrome_options.add_argument('--headless')
browser = webdriver.Chrome(chrome_options=chrome_options, executable_path="C:/chromedriver")
browser.get('https://finance.yahoo.com/quote/BTC-EUR/history/')

#configuring CSV file
f = open('eur_btc_rates.csv', 'w', newline='')
fieldnames = ["Date ", " BTC Closing Value"]
w = csv.DictWriter(f, fieldnames=fieldnames, delimiter="|")
w.writeheader()
writer = csv.writer(f, delimiter="|")

#auxiliary variables
i = 0; valuesBTC = []; time = []

#dynamically picking up elements
while i < 10:
    i += 1
    
    timeClose = browser.find_element_by_xpath(
        '//*[@id="Col1-1-HistoricalDataTable-Proxy"]/section/div[2]/table/tbody/tr[{}]/td[1]'.format(i)
    )
    time.insert(i, (timeClose.text))
    
    btcClose = browser.find_element_by_xpath(
        '//*[@id="Col1-1-HistoricalDataTable-Proxy"]/section/div[2]/table/tbody/tr[{}]/td[5]'.format(i)
    )
    valuesBTC.insert(i, (btcClose.text))
   

#putting the extracted data into the CSV file
for x in range(10):
    writer.writerow([time[x], valuesBTC[x]])

f.close()

