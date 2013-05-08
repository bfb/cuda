# Cuda

Cuda is a static server that uses socket to serve files under http protocol.

## Installation

Install the gem:

    $ gem install cuda

After installing you have the Cuda commands to use.

## How to use

To see all instructions you can use the `help` command.

    $ cuda --help

Start the Cuda server like the command bellow:

    $ cuda start -p 5000 -d /path/other/

The command above starts the server in the port 5000 and reads the files in the /path/other/ directory.

To get a file to the server use the command `get`:

    $ cuda get http://0.0.0.0:5000/file_name.html

It will get the file_name.html and parse the file to retrieve all assets asynchronously.