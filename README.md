# MountainMetrics 
## www.mountainmetrics.com 

### Postgresql Database
To-Do

### Running the servera
Update Host File 
```
127.0.0.1       mountainmetrics.com www.mountainmetrics.com
``

Start Server in Port 80 
```bash
rvmsudo rails server thin -p 80 -b 127.0.0.1
```

Clear DNS Cache
```
sudo dscacheutil -flushcache
```
