cios progress garbo
===================

how to use
----------

 1. go to <https://mwfoi.smartevals.com/instructor/MyEvalCenter.aspx>
 2. open network tools
 3. refresh page
 4. copy request to <https://mwfoi.smartevals.com/instructor/MyEvalCenter.aspx> as curl
 5. paste in curl.sh
 6. run `./update.sh "Spring 2022 CS 6290 Lecture A #21973202202"`
 7. configure your webserver to serve status.txt. for nginx i did

        server {
                listen 443 ssl;
                listen [::]:443 ssl;
                server_name cios.ausb.in;
                location / {
                        root /home/admin/cs6290/cios-counter/;
                        try_files /status.txt /status.txt;
                }
        }
