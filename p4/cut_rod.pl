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

sub print_cut_rod_solution {
    my ($s, $n) = @_;
    while ($n > 0) {
        print $s->[$n], "\n";
        $n -= $s->[$n];
    }
}

sub extended_bottom_up_cut_rod {
    my ($p, $n) = @_;
    my (@r, @s);
    $r[0] = 0;
    for my $i (1..$n) {
        my $q = 0;
        for my $j (1..$i) {
            if ($q < $p->[$j - 1] + $r[$i - $j]) {
                $q = $p->[$j - 1] + $r[$i - $j];
                $s[$i] = $j;
            }
        }
        $r[$i] = $q;
    }
    print_cut_rod_solution(\@s, $n);
}

