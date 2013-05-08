# Cuda

Cuda is a static server that uses socket to serve files under http protocol.

## Installation

Install the gem:

    $ gem install cuda

After installing you have Cuda command line commands to use.

## How to use

Start the Cuda server like the command bellow:

    $ cuda start -p 5000 -d /path/other/

The command above starts the server in the port 5000 and reads the files in the /path/other/ directory.

To get a file to the server use the command `get`:

    $ cuda get http://0.0.0.0:5000/file_name.html

It will get the file_name.html to the server and parse the file to retrieve all assets asynchronously.