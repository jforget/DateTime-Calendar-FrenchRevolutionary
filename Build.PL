use Module::Build;

Module::Build->new (module_name => 'DateTime::Calendar::FrenchRevolutionary'
    , license => 'perl'
    , requires => { Roman => 0
                  , DateTime => 0.06
                  }
    )->create_build_script;
