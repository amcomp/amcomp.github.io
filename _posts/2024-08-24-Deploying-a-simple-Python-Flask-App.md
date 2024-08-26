---
layout: post
title: "Deploying a simple Python Flask App"
date: 2024-8-25 13:32:20 +0300
description: How to get a simple Python Flask App started # Add post description (optional)
img: photo-1672308627194-9a2c28daa17a.jpg  # Add image post (optional)
---


When building more complex apps, the design will typically include a front end (the part you look at) and a back end (where the data comes from). When an application is structured like this, you need a way to connect the two parts into one larger application. This connection is called API or Application Programming Interface. System Administrators and DevOps engineers are familiar with APIs for connecting new vendors, services, and apps. APIs are also used in scripting for automation when using data from the internet. In this article, I will briefly describe a simple deployment of Flask, a Python tool which can be a part of deploying self-hosted API and websites, to quickly get started learning a critical layer in application deployment. 

---

# How to Set up Flask with Python

<aside>
💡 I set this up using an Ubuntu Virtual machine. This should work similarly for any mainstream Linux distribution. I will link the Flask documentation that I followed at the bottom of the page.

</aside>

Create a new folder for the project, and then open a new Python file, and name it anything you like.  I named mine hello.py

```python
#hello.py

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
```


## Explaining this code

Using this code above, it will simply output a white webpage, with “Hello World” in the top left. 

From top to bottom:

- **Importing the package:** Imports the Flask package.
- **Creates the instance of Flask:** `app = Flask(__name__)` creates an instance of the Flask class.
- **Defines the route:** `@app.route("/")` is a decorator that defines the route for the following function.
- **The Python code itself:** The `hello_world` function returns the HTML to be displayed on the webpage.

---

```bash
#!/bin/bash

export FLASK_APP=hello.py
flask run
#or
flask run --host=0.0.0.0 # If you need the server available to other devices. 
```

## Explaining this script

From top to bottom:

- **Set the FLASK_APP environment variable:** This tells the Flask development server what file to run.
- **Run your code:** `flask run` starts the Flask built-in development server.

---

## Results

You should immediately be prompted to open 127.0.0.1:5000 in the browser, where you will see your almost blank webpage, meaning you have successfully deployed a Flask app! If you are running your Ubuntu Server as a Virtual Machine, you may need to open up the connection to the whole network. In that case, use `flask run --host=0.0.0.0`.

---

# Considerations

### Why Use Flask?

When building applications, it is beneficial to separate the Front-end, API, and Back-end. This principle is known as **Separation of Concerns.** In my case, I'll be using it to keep API keys out of my Flutter apps. This keeps code cleaner and safer since you don't need to worry about managing keys within the front-end, which will be deployed to users.

### Flask Alone is Not Production-Ready

Flask has a built-in server, but its primary use is for development environments. It lacks necessary security features and is only capable of handling one request at a time. When it is time for production, even for internal apps, it is best to use a production-ready **WSGI** (Web Server Gateway Interface). A popular one is called Gunicorn. Simply put, you will build your app in Flask and then serve the app with Gunicorn.

## For reference

[Welcome to Flask — Flask Documentation (3.0.x)](https://flask.palletsprojects.com/en/3.0.x/)