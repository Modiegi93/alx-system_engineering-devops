# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Create a custom config file for Nginx
file { '/etc/nginx/conf.d/custom.conf':
  content => "server_tokens off;\nmore_set_headers 'X-Served-By: ${hostname}';",
  notify => Service['nginx'],
}

# Restart Nginx service when custom config file changes
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/conf.d/custom.conf'],
}
