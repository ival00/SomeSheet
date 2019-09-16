#/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $Range = 1000;
my $WhiteCell = '_';
my $BlackCell = '#';
my $i;
my $j;
my $X = $ARGV[0];
my $Y = $ARGV[1];
my $Steps = $ARGV[2];
if (($X > $Range-1) or ($X < 0) or ($Y > $Range-1) or ($Y < 0)) {die "Ant out of Field\n"}
if ($Steps<0) {die "Incorrect number of steps\n"}
my $Vector = 0;
my @Field = ();
my @Row = ();
my $RefField = \@Field;
my $FileName = "out.ant";
my $fh;
$i = $Range;
while ($i>0) {
	push (@Row, $WhiteCell);
	--$i;
}
$i = $Range;
while ($i>0) {
	push (@Field, [@Row]);
	--$i;
}

while ($Steps>0){
	if ($RefField->[$X][$Y] eq $WhiteCell) {
		$RefField->[$X][$Y] = $BlackCell;
		++$Vector;
	}
	else {
		$RefField->[$X][$Y] = $WhiteCell;
		--$Vector;
	}
	if ($Vector == 4) {$Vector = 0}
	if ($Vector == -1) {$Vector = 3}
	if ($Vector == 0) {--$X}
	if ($Vector == 1) {++$Y}
	if ($Vector == 2) {++$X}
	if ($Vector == 3) {--$Y}
	if ($X == -1){$X = $Range-1}
	if ($X == $Range){$X = 0}
	if ($Y == -1){$Y = $Range-1}
	if ($Y == $Range){$Y = 0}
	--$Steps;
}
open($fh, '>', $FileName) or die "Cannot open '$FileName' $!";
for $i(0..$Range-1){
	for $j (0..$Range-1){print $fh $RefField->[$i][$j]}
	print $fh "\n";
}
close $fh;
print "Writed to out.ant\n";

