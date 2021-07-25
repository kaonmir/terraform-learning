
    #!bin/bash
    sudo apt update -y
    sudo apt install -y apache2
    sudo systemctl start apache
    sudo bash -c 'echo your very first web server > /var/www/html/index.html'