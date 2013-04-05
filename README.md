# Cuda

Cuda is a server and client that uses socket to communication. Cuda client allows you to request a html file to the server and it will parse and retrieve all assets asynchronously.

## Installation

Install the gem:

    $ gem install cuda

After installing you have Cuda command line commands to use.

## How to use

Start the Cuda server like the command bellow:

    $ cuda start -p 5000 -d /path/other/

The command above starts the server in the port 5000 and reads the files in the /path/other/ directory.

To list all html files in the directory use the command `list`:

    $ cuda list

To get a html file to the server use the command `get`:

    $ cuda get file_name.html

It will get the file_name.html to the server and parse the file to retrieve all assets asynchronously.