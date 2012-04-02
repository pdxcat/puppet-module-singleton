class singleton::data {

  # Example hiera data (puppet backend) for package "vim":
  #
  # $singleton_package_vim = {
  #   parameters => {
  #     ensure => present,
  #     name   => 'vim',
  #   },
  #   include_singleton_packages => [
  #     "vim-puppet",
  #   ],
  #   include_classes => [
  #     "stdlib",
  #     "obviouslyfakeclass",
  #   ],
  # }

}
