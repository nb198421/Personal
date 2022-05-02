#!/usr/bin/perl -w
use strict; 
use Spreadsheet::WriteExcel; 
sub write_sheet ($$$) {
	my ($excelfile, $sheetname, $filename) = @_;
	print "Sheet Name = $sheetname\n";
	print "File Name  = $filename\n"; 
	my $sheet = $excelfile->addworksheet($sheetname);
 
	my $bluebg = $excelfile->addformat();
	$bluebg->set_color('blue');
 
	open(CSV, "$filename") or die "cannot open $!";
	while (<CSV>) {
    	chomp;
    	my(@vals)=split(/;/,d $_);
    	my $format = ($. == 1) ? $bluebg : undef;
    	foreach my $vidx (0..$#vals) {
        	$sheet->write(($.-1), $vidx, $vals[$vidx], $format);
    	}
	}
	close(CSV);
	return 1;
} 
my @input = qw{C:\Users\npanguluri\Desktop\test\test1.csv C:\Users\npanguluri\Desktop\test\test2.csv};
#my $output = $input;
#$output =~ s/\.csv$/.xls/i;
 
my $wb = Spreadsheet::WriteExcel->new("C:\Users\npanguluri\Desktop\test\perl.xls"); 
my $x;
foreach my $f ( @input ) {
	$x++;
	write_sheet($wb,"Sheet $x",$f);
}
$wb->close();