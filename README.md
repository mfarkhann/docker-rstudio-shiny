# docker-rstudio-shiny
Docker for Rstudio and Shiny Server in one Container

## Usage:
Using tag 3.3.3 (R Version 3.3.3)

### Build :
On this directory Run 
```sh
docker build . -t rstudio-shiny:3.3.3
```

### Run
To run a temporary container with Shiny Server:
```sh
docker run --rm -it -p 3838:3838 -p 8787:8787  farkhan/rstudio-shiny:3.3.3 
```
go to localhost:8787
login with :
```
user : rstudio
pass : rstudio
```

In Production
```sh
docker run --name rstudio-shiny -d -p 3838:3838 -p 8787:8787  farkhan/rstudio-shiny:3.3.3 
```

In Production with nginx or other proxy management
```sh
docker run --name rstudio-shiny -d -p 127.0.0.1:3838:3838 -p 127.0.0.1:8787:8787  farkhan/rstudio-shiny:3.3.3 
```

When In Production, we want to Remove Default User and Add Multiple User

Enter Container with container name (define when run docker with --name or find out with `docker ps`)
```sh
docker exec -it rstudio-shiny bash
```

Remove Rstudio User
```sh
userdel -r rstudio
```


Add multiple User
```sh
for username in list_user; do
	adduser $username --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password
	adduser $username staff
	echo "$username:pass" | chpasswd
done
```

Exit container
```
ctrl + d
```


side notes :
To Remove Multiple User
```sh
for username in list_user; do
	userdel -r $username
done
```
