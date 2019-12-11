# PythonBox - python testing environment for small projects

Based on ubuntu:18.04

### Contained
* python3
* pip3
* virtualenv
* busybox
* tcpdump
* nmap
* curl
* tmux
* postgresql-common

### What is maked for

If you need to test some python project, you can pass directory of this project as volume to the container. Than you can install all requirements with pip3. After stopping container will be destroyed.

### Installation
1. Copy .env_example file to .env and edit it. If you want to upload image to private or public registry, set REGISTRY variable, otherwise comment it.
2. Build image with ./build.sh
3. If you want to upload it to private or public docker registry run ./push.sh
4. Make symlink from run.sh script to some directory from you executable path, for example: ln -s `pwd`/run.sh /usr/local/bin/pythonbox

### Example

For example my project named as "test123".
```bash
$ cd test123
~/test123$ # Let's see what is here
~/test123$ cat requirements.txt
ujson
~/test123$ cat test.py 
import ujson

t = ujson.dumps({'test1':1, 'test2':[2,3,4]})
print(t)
~/test123$ # Creating test container
~/test123$ pythonbox
48e2ed28ad57ebc93f1743664083426958b7d2394896d441ea7ffd109984f0ed
~/test123$ # At this moment we created container with name test123-test-date_time
~/test123$ docker ps | grep test123
48e2ed28ad57        registry.mysmartflat.tech/pythonbox      "/bin/sh -c 'tail -f…"   6 seconds ago       Up 3 seconds       test123-test-2019-12-11_18-41
docker exec -it test123-test-2019-12-11_18-41 bash
~/test123$ # Here you can also run tmux (it has custom config with Ctrl+a management shortcut instead of Ctrl+b, sorry :))
root@test123-test-2019-12-11_18-41:/# cd /opt
root@test123-test-2019-12-11_18-41:/# ls 
requirements.txt  test.py
root@test123-test-2019-12-11_18-41:/opt# virtualenv myvenv
Using base prefix '/usr'
New python executable in /opt/myvenv/bin/python3
Also creating executable in /opt/myvenv/bin/python
Installing setuptools, pip, wheel...
done.
root@test123-test-2019-12-11_18-41:/opt# . myvenv/bin/activate
(myvenv) root@test123-test-2019-12-11_18-41:/opt# pip3 install -r requirements.txt 
Collecting ujson
  Downloading https://files.pythonhosted.org/packages/16/c4/79f3409bc710559015464e5f49b9879430d8f87498ecdc335899732e5377/ujson-1.35.tar.gz (192kB)
     |################################| 194kB 4.6MB/s 
Building wheels for collected packages: ujson
  Building wheel for ujson (setup.py) ... done
  Created wheel for ujson: filename=ujson-1.35-cp36-cp36m-linux_x86_64.whl size=68027 sha256=9a19fa560f439d7eb071072c3c510a3dc95aeb21d0db93fbd3644f059ed5e599
  Stored in directory: /root/.cache/pip/wheels/28/77/e4/0311145b9c2e2f01470e744855131f9e34d6919687550f87d1
Successfully built ujson
Installing collected packages: ujson
Successfully installed ujson-1.35
(myvenv) root@test123-test-2019-12-11_18-41:/opt# python3 test.py
{"test1":1,"test2":[2,3,4]}
(myvenv) root@test123-test-2019-12-11_18-41:/opt# exit
exit
msf@git:~/test123$ docker ps | grep test123
48e2ed28ad57        registry.mysmartflat.tech/pythonbox   "/bin/sh -c 'tail -f…"   29 minutes ago      Up 29 minutes         test123-test-2019-12-11_18-41
msf@git:~/test123$ docker stop test123-test-2019-12-11_18-41
test123-test-2019-12-11_18-41
msf@git:~/test123$ docker ps -a | grep test123
msf@git:~/test123$ # Container destroyed after stopping
```

