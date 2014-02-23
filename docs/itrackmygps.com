<VirtualHost 173.255.249.114:80>
  ServerAdmin rupert@2rmobile.com
  ServerName itrackmygps.com
  ServerAlias itrackmygps.com

  DocumentRoot /srv/rails/itrackmygps/current/public
  ErrorLog /var/log/apache2/itrackmygps.error.log

  <Location "^/assets/.*$">
    Header unset ETag
    FileETag None
    ExpiresActive On
    ExpiresDefault "access plus 1 year"
  </Location>

  LogLevel warn
  CustomLog /var/log/apache2/itrackmygps.access.log combined
</VirtualHost>
