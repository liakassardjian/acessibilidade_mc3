# Template of Login

**Login** template of login made in nodejs using API and JSON.

### Dependencies 

- NodeJS
- Express
- npm

### Installing

To run the server, we need to insert the folder that contains the `package.json` file.
1. Installing NodeJS dependencies:

```shell
$ npm install
```

2. Running the server:

```shell
$ npm start
```

### API - Application Programming Interface

#### Register

send to `<YourURL.com>/api/register/`

```
{ 
    'name' : <name>,
    'email' : <email>,
    'password' : <password>
}
```

result if sucess:

```
{
     'result': true
}
```

else:

```
{
    'result': false
⁾)
```

#### Login

send to `<YourURL.com>/api/login/`

```
{ 
    'email' : <email>,
    'password' : <password>
}
```


result if sucess:

```
{
    'name': <user_name>,
    'email' : <user_email>,
    'password' : <user_password>
}
```

else:

```
{
    'result' : 'false'
}
```
