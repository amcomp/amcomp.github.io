---
layout: post
title: "Working with JSON in PowerShell"
date: 2024-08-26 13:32:20 +0300
description: Working with JSON in PowerShell # Add post description (optional)
img: pexels-luis-gomes-166706-546819.jpg # Add image post (optional)
---

# JSON And PowerShell

As automation becomes integral to managing systems, working with JSON data often becomes necessary. PowerShell facilitates sending and receiving JSON data, which is pivotal for managing both local and cloud services in a system administrator's infrastructure. This article covers how to retrieve data from the JSONPlaceholder API using PowerShell.

### What is JSON?

JSON (JavaScript Object Notation) is a lightweight data interchange format that is easy to read and write for humans and machines. JSON structures data as "key-value" pairs and is often used in APIs due to its simplicity and efficiency. Here’s an example:
<br><br>


```
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  }
]
```
<br><br>
The whole data is opened with brackets [ ], then each object is opened with curly brackets { }. In this example I have only shown one object. Finally, the data is simply a “key-value” pair. In the first line, the key is “userId” and the value is “1”, separated by a colon. 

### Working with JSON

In PowerShell the primary Cmdlet we will be working with is “ConvertFrom-Json”. We use this Cmdlet, because PowerShell does not directly work with JSON without it. PowerShell is expecting something called a “PowerShell Objects”. With this one command you can convert valid JSON into a PS Object. There is also a “ConvertTo-Json” Cmdlet. This would convert your PS Objects to JSON. In this case you would likely be sending information to a server to make changes.  

### Script

```powershell
#PSjsonexample.ps1

# Define the API endpoint URI
$uri =  "https://jsonplaceholder.typicode.com/posts/"

# Send a GET request to the API endpoint
$jsonoutput = Invoke-WebRequest -Uri $uri 

# Convert the JSON response content to PowerShell objects
$object = $jsonoutput.Content | ConvertFrom-Json 

# Display the first three objects from the response
$object[0,1,2] 

```

### Description

1. **Define the URI**: Set up the URL of the API endpoint.
<br><br>
2. **Send HTTP Request**: Use `Invoke-WebRequest` to make a request to the API and get the response.
    <br><br>
    1. Running this alone would give this output
    <br><br>
    
    ```
    StatusCode        : 200
    StatusDescription : OK
    Content           : [
                          {
                            "userId": 1,
                            "id": 1,
                            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                            "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita ...
    RawContent        : HTTP/1.1 200 OK
                        Transfer-Encoding: chunked
                        Connection: keep-alive
                        Report-To: {"group":"heroku-nel","max_age":3600,"endpoints":[{"url":"https://nel.heroku.com/reports?ts=1723350123&sid=e11707d5-02a7...
    Forms             : {}
    Headers           : {[Transfer-Encoding, chunked], [Connection, keep-alive], [Report-To, {"group":"heroku-nel","max_age":3600,"endpoints":[{"url":"https://nel.heroku.com/re 
                        ports?ts=1723350123&sid=e11707d5-02a7-43ef-b45e-2cf4d2036f7d&s=QXZP2BJVT1zYzVakDdejCpbnpXxsqTBpxwLH0ekXgSE%3D"}]}], [Reporting-Endpoints,
                        heroku-nel=https://nel.heroku.com/reports?ts=1723350123&sid=e11707d5-02a7-43ef-b45e-2cf4d2036f7d&s=QXZP2BJVT1zYzVakDdejCpbnpXxsqTBpxwLH0ekXgSE%3D]...}   
    Images            : {}
    InputFields       : {}
    Links             : {}
    ParsedHtml        : mshtml.HTMLDocumentClass
    RawContentLength  : 27520
    ```
    <br><br>
    
    <aside>
    💡 This output is useful later for things like error handling. Notice the status code. It is common to write programmatic loops, checking for that number to ensure that the connection was successful, before continuing the rest of the script. In a more complex script, error handling is important to stop the script from doing anything unintended, should conditions not be as expected. This would be for scenarios where we would be sending data to a server, making changes to critical infrastructure. The example for this article is simply retrieving data, and simply parsing it out.
    <br><br>
    </aside>
    
    ```powershell
    //Error handling example
    if ($jsonoutput.StatusCode -ne 200) {
        Write-Error "Failed to retrieve data. Status code: $($jsonoutput.StatusCode)"
    }
    ```
    <br><br>
    
3. **Convert JSON Data**: Use `ConvertFrom-Json` to parse the JSON response and convert it into PowerShell objects.
<br><br>
    1. Running only $jsonoutput.content at this point would look like this:
    <br><br>
    
    ```
    [
      {
        "userId": 1,
        "id": 1,
        "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
        "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      },
      {
        "userId": 1,
        "id": 2,
        "title": "qui est esse",
        "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
      },
      
      // Stopped after the first two objects, this list will output 100 objects
    ```
    <br><br>
4. **Access Data**: The data at this point can be selected like an array, using the brackets. In this case, I wanted to output the first three objects, so I'll use [0,1,2] as arrays typically start with 0. If you only wanted to output a single object, simply use a number corresponding to its order in the list, [0] for the very first object for example. 
<br><br>
    1. Running the whole script will give this output:
<br><br>
```
userId id title                                        body
------ -- -----                                        ----
            1  1 sunt aut facere repellat  quia et...
            1  2 qui est esse                                 est rerum tempore vitae...
            1  3 ea molestias quasi exercitat...              et iusto sed quo iure...
```

 <br><br>

### Working with the PS object

From here we get four columns: UserID, ID, Title and Body. These will be unique depending on what is written in the JSON data. PowerShell makes it easy to pick which column we want to parse out. You can simply add the name of the column to the end of our final output in the script, for example:

```powershell
$object[0,1,2].userID #output only the userID
$object[0,1,2].iD #output the only id
$object[0,1,2].title #output the only title
$object[0,1,2].body #output the onlybody
```

### Experimentation

Using this basic script, there is room for experimentation. Try a few of these:

1. Select a different object in the list
2. Select more objects in the list
3. Try different URIs from JSON Placeholder (I'll leave a link to the site below)
4. Try implementing error handling using the status code.
5. Experiment with additional PowerShell cmdlets to filter or format the output.

### Resources

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- [Microsoft Learn documentation for Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.4)
- [Microsoft Learn documentation for ConvertFrom-Json](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json?view=powershell-7.4)