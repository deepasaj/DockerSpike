package it.gruppopam.oracle;

import it.gruppopam.geco_dolly.GecoCloner;
import org.skife.jdbi.v2.DBI;

import static java.util.Arrays.asList;

public class LocalgrpInstantiator {

    public static void main(String args[]) throws Exception {
        DBI TWGRPDbi = new DBI("jdbc:oracle:thin:@172.31.167.68:1526:pamtest", "TWGRP", "TWGRP");
        DBI LOCALGRPDbi = new DBI("jdbc:oracle:thin:@localhost:1521:xe", "localgrp", "localgrp");
        GecoCloner cloner = new GecoCloner("LOCALGRP", TWGRPDbi, LOCALGRPDbi);
        cloner.createTables(asList("AR001_ANAGR_ART"));
        cloner.closeConnections();
    }
}
