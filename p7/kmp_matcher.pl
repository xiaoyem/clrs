#
# Copyright (c) 2005-2015 by Xiaoye Meng.
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

sub compute_prefix_function {
    my $p = shift;
    my $n = length $p;
    my @pi;
    my $k = -1;
    $pi[0] = -1;
    for my $q (1..$n - 1) {
        $k = $pi[$k]
            while $k > -1 && substr($p, $k + 1, 1) ne substr($p, $q, 1);
        ++$k if substr($p, $k + 1, 1) eq substr($p, $q, 1);
        $pi[$q] = $k;
    }
    @pi;
}

sub kmp_matcher {
    my ($t, $p) = @_;
    my ($m, $n, $q) = (length $t, length $p, -1);
    my @pi = compute_prefix_function($p);
    for my $i (0..$m - 1) {
        $q = $pi[$q]
            while $q > -1 && substr($p, $q + 1, 1) ne substr($t, $i, 1);
        ++$q if substr($p, $q + 1, 1) eq substr($t, $i, 1);
        if ($q == $n - 1) {
            print "Pattern occurs with shift ", $i - $n + 1, "\n";
            $q = $pi[$q];
        }
    }
}

