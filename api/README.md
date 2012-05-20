API server for tow
==================

Installation steps
------------------
If you want, you can manually install worker. However it is strongly recommended to use vagrant+chef environment.

    sudo gem install bundler
    cd ../
    bundle install
    cd -
    cd lib
    ruby tow_server.rb

Typical folder structure
------------------------

    /
      bin/  #Put your executables here
      data/ #Everything else needed for the project
      doc/  #RDoc for the lib/ directory
      ext/  #C-Extensions go here
      lib/  #Everything internal is handled here
        - my_namespace.rb #Contains module methods for MyNamespace
        my_namespace/   #Directory for classes in MyNamespace
          - my_class.rb  #Contains MyClass
          my_inner_namespace/
            - my_2nd_class.rb
