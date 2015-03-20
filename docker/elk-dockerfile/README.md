Author: Actinide (actinide@gmail.com)

Builds a Docker image that contains the basic ELK stack (elasticsearch, logstash, kibana), along with Nginx and Google Auth Proxy to restrict access to kibana using OAuth 2.0 authentication. These instructions assume basic familiarity with all the components, including using OAuth 2.0 for authentication.

WARNING: You should not rely on the proxy component alone for security; you should still secure your environment on all layers according to best practice.

To build, just change the following variables in the included configuration files, and then build the image.

logstash.conf:
- The location and/or name of your lumberjack certs, if you're using that protocol

kibana.conf:
- Change server_name to your server name (FQDN)

google_auth_proxy.cfg
- Set redirect_url
- Set google_apps_domains
- Set your client_id and client_secret

This directory includes a kibana init script from bsmith@the408.com: (https://github.com/akabdog/scripts/edit/master/kibana4_init)

TODO:
- Include cert management (lumberjack & nginx)
