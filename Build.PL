use Module::Build;

Module::Build->new (module_name => 'DateTime::Calendar::FrenchRevolutionary'
    , license => 'perl'
    , requires => { Roman => 0
                  , DateTime => 0.14
                  }
    )->create_build_script;
