package SrvChart::DB;
use DBI;
sub open {
	my $database = "test.db";
	my $driver   = "SQLite";
	my $dsn      = "DBI:$driver:dbname=$database";
	my $dbh      = DBI->connect( $dsn, "", "", { RaiseError => 1 } )
	  or die $DBI::errstr;

	my $stmt = qq(CREATE TABLE IF NOT EXISTS COUNTS
      (ID INTEGER PRIMARY KEY,
       TS		    TEXT,
       SYSTEM       TEXT,
       TYPE         TEXT,
       COUNT        INT););
	my $rv = $dbh->do($stmt);
	if ( $rv < 0 ) {
		die $DBI::errstr;
	}
	return $dbh;
}

return 1;