# FM: added to auto switch PHP version based on project's .switch-php
load-switch-php() {
  if [[ -f .switch-php && -r .switch-php ]]; then
    echo "Found .switch-php"
    if [ "$(php -r 'echo(PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION);')" != "$(cat .switch-php)" ]; then
      echo "PHP versions are different: $(php -r 'echo(PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION);') != $(cat .switch-php), switching"
      switch-php $(cat .switch-php)
    else
      echo "PHP versions are equal: $(php -r 'echo(PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION);') == $(cat .switch-php), doing nothing"
    fi
  fi
}

# hooking load-switch-php call to be called when working directory changes
add-zsh-hook chpwd load-switch-php
