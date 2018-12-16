# Security version 1
#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Apache Secuirty
    echo "ServerSignature Off" >> /etc/apache2/apache2.conf
    echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
    apt-get install libapache2-modsecurity
    a2enmod mod-security
    service apache2 force-reload
#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# PHP Security
# list of function to disable globally -- REPLACE PHP PATH TO YOUR SETUP#
    echo "disable_functions =exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source"  >> /etc/php/7.2/apache2/php.ini 
    echo "allow_url_fopen=Off" >> /etc/php/7.2/apache2/php.ini 
    echo "allow_url_include=Off" >> /etc/php/7.2/apache2/php.ini 
    service apache2 restart
#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# SSH Login Alert and checks
    apt install mailutils
    touch /etc/ssh/login-notify.sh
    chmod +x /etc/ssh/login-notify.sh
    cat >/etc/ssh/login-notify.sh <<EOL
        #!/bin/sh
        username=whoami
        sender="me@me.com"
        recepient="you@you.com"

        if [ "$PAM_TYPE" != "close_session" ]; then
            subject="Server Alert"
            # Message to send, e.g. the current environment variables.
            message="User \$(whoami) logged on to \$(hostname -A) @ \$(date)"
            echo "$message" | mailx -r "$sender" -s "$subject" "$recepient"
        fi
EOL
#------------------------------------------------------------------------------------------------------------------------------------------------------------------



 


