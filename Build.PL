use Module::Build;

Module::Build->new (module_name => 'DateTime::Calendar::FrenchRevolutionary'
    , license => 'perl'
    , requires => { Roman => 1.22
                  , DateTime => 0.14
                  }
    )->create_build_script;
