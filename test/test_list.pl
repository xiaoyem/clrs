#
# Copyright (c) 2005-2016 by Xiaoye Meng.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

do "p3/list.pl";

my $l = new dlist;
my $a = new element;
my $b = new element;
my $c = new element;
my $d = new element;
my $e = new element;
$a->key(1);
$b->key(4);
$c->key(16);
$d->key(9);
$e->key(25);
list_insert($l, $a);
list_insert($l, $b);
list_insert($l, $c);
list_insert($l, $d);
for (my $x = $l->head; defined $x; $x = $x->next) {
    print $x->key;
}
print "\n";
list_insert($l, $e);
for (my $x = $l->head; defined $x; $x = $x->next) {
    print $x->key;
}
print "\n";
list_delete($l, $b);
for (my $x = $l->head; defined $x; $x = $x->next) {
    print $x->key;
}
print "\n";

