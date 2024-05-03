# Installs a Nginx server with custom HTTP header

exec {'update':
  provider => shell,
  command  => 'sudo apt-get update',
  before   => Exec['install Nginx'],
}

exec {'install Nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
  before   => Exec['add_header'],
}

exec { 'a add_header':
  provider    => shell,
  environment => ["host=${HOSTNAME}"],
  command     => 'sudo sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\ta add_header X-Served-By \"$HOSTNAME\";/" /etc/nginx/nginx.conf',
  before      => Exec['restart Nginx'],
}

exec { 'restart Nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
