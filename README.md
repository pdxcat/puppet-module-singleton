# Singleton Puppet Module

The Singleton module provides functions that dynamically create resources
defined either by built-in defaults or by hiera-supplied parameters.

For now, this module provides one function only: `singleton_packages`, which is
intended to be used as a tool to address the problem of simple package
inclusion in puppet manifests.

Because resources can only be declared once in a puppet manifest, including
"simple" packages in multiple places can become a complicated and verbose
endeavour -- where "simple packages" are loosely defined as those which are too
inconsequential to merit their own classes or modules. The `singleton_packages`
function aims to detach inclusion of these kinds of trivial packages from the
complexity of the Puppet DAG and eliminate the need to a-priori iterate the
list of trivial packages that you might want to include (via means such as
classes, virtual resources, or other contrivances), while simultaneously
allowing for a small level of user-excersised power and control beyond global
or function-wide default parameters.

The `singleton_package` function is called with the name(s) of the package(s)
to install. It does not matter how many times the function is called for a
given package name, the resource will only be defined once, and will be defined
within the scope of Class[singleton].

# Examples

The following puppet code can be used to install three packages, "vim",
"emacs", and "nano".

    singleton_packages("vim", "emacs", "nano")

By default, each package will be created as if it had been given the parameters:

    package { "singleton_package_$name":
      ensure => present,
      name   => $name,
    }

Additional customization can be supplied by adding hiera data. You may supply
parameters, additional singleton_packages to chain-include, and additional
classes to include.

## YAML Example for "vim" Package

File: $confdir/data/common.yaml
(or other appropriate file, per hiera configuration)

    ---
    :singleton_package_vim:
      :parameters:
        :name: vim
        :ensure: present
      :include_singleton_packages:
      - vim-puppet
      :include_classes:
      - stdlib
      - obviouslyfakeclass

## Puppet Example for "vim" Package

File: $modulepath/data/common.pp
(or other appropriate file/class, per hiera configuration)

    class data::common {
      $singleton_package_vim = {
        parameters => {
          ensure => present,
          name   => 'vim',
        },
        include_singleton_packages => [
          "vim-puppet",
        ],
        include_classes => [
          "stdlib",
          "obviouslyfakeclass",
        ],
      }
    }
