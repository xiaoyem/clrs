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

use Class::Struct;

struct vertex => {
    pi        => '$',
    d         => '$',
    color     => '$',
    alist     => '@'
};

sub enqueue {
    my ($q, $x) = @_;
    push @$q, $x;
}

sub dequeue {
    my $q = shift;
    shift @$q;
}

sub bfs {
    my ($g, $s) = @_;
    for my $u (@$g) {
        $u->color('W');
    }
    $s->d(0);
    $s->color('G');
    my @q;
    enqueue(\@q, $s);
    while (@q != 0) {
        my $u = dequeue(\@q);
        for my $v (@{$u->alist}) {
            if ($v->color eq 'W') {
                $v->pi($u);
                $v->d($u->d + 1);
                $v->color('G');
                enqueue(\@q, $v);
            }
        }
        $u->color('B');
    }
}

sub print_path {
    my ($g, $s, $v) = @_;
    if ($v == $s) {
        print $s, "\n";
    } elsif (!(defined $v->pi)) {
        print "no path from ", $s, " to ", $v, " exists\n";
    } else {
        print_path($g, $s, $v->pi);
        print $v, "\n";
    }
}

