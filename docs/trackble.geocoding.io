<VirtualHost 173.255.249.114:80>
  ServerAdmin rupert@2rmobile.com
  ServerName trackble.geocoding.io
  ServerAlias trackble.geocoding.io

  DocumentRoot /srv/rails/trackble/current/public
  ErrorLog /var/log/apache2/trackble.error.log

  <Location "^/assets/.*$">
    Header unset ETag
    FileETag None
    ExpiresActive On
    ExpiresDefault "access plus 1 year"
  </Location>

  LogLevel warn
  CustomLog /var/log/apache2/trackble.access.log combined
</VirtualHost>
