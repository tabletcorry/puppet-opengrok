class opengrok::tomcat (
  $version=7
) {
  require opengrok::files
  $tname="tomcat${version}"
  package {
    [$tname, "${tname}-admin"] :
      ensure => present;
  }

  file {
    "/var/lib/${tname}/webapps/source.war" :
      ensure  => present,
      require => [Package[$tname],File["${opengrok::files::bin_path}/source.war"]],
      notify  => Service[$tname],
      source  => "${opengrok::files::bin_path}/source.war";
  }

  service {
    'tomcat7' :
      hasrestart => true,
      hasstatus  => true,
      require    => Package[$tname];
  }
}
