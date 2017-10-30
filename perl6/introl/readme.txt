1) Perl6 != perl6 
      Perl6 is the language specification
      perl6 is a specific implementation
      
2) Best way to install on ubuntu
      https://github.com/nxadm/rakudo-pkg/releases

3) Module management is via zef

4) perlbrew install perl-5.26.0 --notest --thread -Duseshrplib -Dusemultiplicity --as perl-5.26.0_WITH
    Duseshrplib <== Needed for Inline::Perl5 to with Perl6
