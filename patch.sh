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
    apt install mailutils -y 
    touch /etc/ssh/login-notify.sh
    chmod +x /etc/ssh/login-notify.sh
    cat >/etc/ssh/login-notify.sh <<EOL
#!/bin/sh
sender="adarwash@live.co.uk"
recepient="ali.darwash@myport.ac.uk"
client=$SSH_CLIENT
if [ "$PAM_TYPE" != "close_session" ]; then
    subject="SSH Login: $(hostname -A)"
    # Message to send, e.g. the current environment variables.
    message="SSH Login on $(hostname -A) @ $(date) from $(echo $PAM_RHOST)"
    echo "$message" | mailx -r "$sender" -s "$subject" "$recepient"
fi

EOL

if grep -Fxq "session required pam_exec.so seteuid /etc/ssh/login-notify.sh"  /etc/pam.d/sshd
then
    echo "PAM EXEC Already Enabled"
else
   echo "session optional pam_exec.so seteuid /etc/ssh/login-notify.sh" >> /etc/pam.d/sshd
fi




#------------------------------------------------------------------------------------------------------------------------------------------------------------------



 


