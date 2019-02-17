import httplib2
import urllib.request
from bs4 import BeautifulSoup

url = 'http://134.173.42.100:8000/'
http = httplib2.Http()
response, content = http.request(url)

soup = BeautifulSoup(content, 'html.parser')

for link in soup.find_all('a'):
    lnk = link.get('href')       
    if ".png" in lnk:
        urllib.request.urlretrieve(url+lnk, filename='photos/'+lnk)
