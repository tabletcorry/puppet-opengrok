class opengrok::tomcat (
  $version=7
) {
  require opengrok::files
  $name="tomcat${version}"
  package {
    [$name, "${name}-admin"] :
      ensure => present;
  }

  file {
    "/var/lib/${name}/webapps/source.war" :
      ensure  => present,
      require => [Package[$name],File["${opengrok::files::bin_path}/source.war"]],
      notify  => Service[$name],
      source  => "${opengrok::files::bin_path}/source.war";
  }

  service {
    'tomcat7' :
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$name];
  }
}
