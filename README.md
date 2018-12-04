cios progress garbo
===================

how to use
----------

 1. go to <https://wwwh2.smartevals.com/surveysetup/evalcenter.aspx?y=all&MenuItemID=228>
 2. open network tools
 3. refresh page
 4. copy request to <https://wwwh2.smartevals.com/surveysetup/evalcenter.aspx?y=all&MenuItemID=228> as curl
 5. paste in curl.sh
 6. run `./update.sh "FA 2018"`
 7. configure your webserver to serve status.txt. for nginx i did

        server {
                listen 443 ssl;
                listen [::]:443 ssl;
                server_name cios.zucc.io;
                location / {
                        root /home/admin/cs2110/cios-counter/;
                        try_files /status.txt /status.txt;
                }
        }

thanks to tim aveni for the help
