# docker-rstudio-shiny
Docker for Rstudio and Shiny Server in one Container

## Usage:
Using tag 3.3.3 (R Version 3.3.3)
To Build :
On this directory Run 
```sh
docker build . -t rstudio-shiny:3.3.3
```


To run a temporary container with Shiny Server:
```sh
docker run --rm -it -p 3838:3838 -p 8787:8787 -e USER=rstudio -e PASSWORD=pass  farkhan/rstudio-shiny:3.3.3 
```

In Production
```sh
docker run --name rstudio-shiny -d -p 3838:3838 -p 8787:8787 -e USER=rstudio -e PASSWORD=pass  farkhan/rstudio-shiny:3.3.3 
```

In Production with nginx or other proxy management
```sh
docker run --name rstudio-shiny -d -p 127.0.0.1:3838:3838 -p 127.0.0.1:8787:8787 -e USER=rstudio -e PASSWORD=pass  farkhan/rstudio-shiny:3.3.3 
```


Add Multiple Users 

Enter Container with container name (define when run docker with --name)
```sh
docker exec -it rstudio-shiny bash
```

Add multiple User
```sh
for username in list_user; do
	adduser $username --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password
	adduser $username staff
	echo "$username:pass" | chpasswd
done
```

Remove Multiple User
```sh
for username in list_user; do
	userdel -r $username
done
```

Exit container
```
ctrl + d
```

