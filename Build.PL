use Module::Build;

Module::Build->new (module_name => 'DateTime::Calendar::FrenchRevolutionary'
    , license => 'perl'
    , requires => { perl => '5.8.5'
                  , Roman => 1.22
                  , DateTime => 0.14
                  }
    , abstract => 'This modules allows converting dates to or from the French Revolutionary calendar'
    )->create_build_script;
