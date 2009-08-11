#!/usr/bin/perl -w
#
# ALO - Ardour Lirc Osc
# Copyright (C) 2008 Raphaël Doursenaud <rdoursenaud@free.fr>
# 26 avenue Federico Garcia Lorca
# 64000 Pau
# France
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
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use strict;
use warnings;
use Lirc::Client;
use Audio::Ardour::Control;
use Switch;

print "ALO - Ardour Lirc Osc\n";
print "Copyright (C) 2008 Raphaël Doursenaud <rdoursenaud\@free.fr>\n";
print "This program comes with ABSOLUTELY NO WARRANTY.\n";
print "This is free software, and you are welcome to redistribute it\n";
print "under certain conditions.\n";
print "\n";

my $lirc = Lirc::Client->new({
	prog    => 'alo',
	rcfile  => "$ENV{HOME}/.lirc/alo",
	debug   => 0,
	fake    => 0,
});

my $ardcontrol = Audio::Ardour::Control->new();

print "LIRC -> Ardour OSC mapper running\n";
print "Hit CTRL+C to quit\n";

while( my $key = $lirc->next_code ){
	switch($key) {
		case "add"	{ $ardcontrol->add_marker(); }
	        case "loop"	{ $ardcontrol->loop_toggle(); }
	        case "start"	{ $ardcontrol->goto_start(); }
	        case "end"	{ $ardcontrol->goto_end(); }
	        case "rewind"	{ $ardcontrol->rewind(); }
	        case "forward"	{ $ardcontrol->ffwd(); }
	        case "stop"	{ $ardcontrol->transport_stop(); }
	        case "pause"	{ $ardcontrol->transport_stop(); }
	        case "play"	{ $ardcontrol->transport_play(); }
	        case "save"	{ $ardcontrol->save_state(); }
	        case "previous"	{ $ardcontrol->prev_marker(); }
	        case "next"	{ $ardcontrol->next_marker(); }
	        case "undo"	{ $ardcontrol->undo(); }
	        case "redo"	{ $ardcontrol->redo(); }
	        case "in"	{ $ardcontrol->toggle_punch_in(); }
	        case "out"	{ $ardcontrol->toggle_punch_out(); }
	        case "record"	{ $ardcontrol->rec_enable_toggle(); }
	        case "all_rec"	{ $ardcontrol->toggle_all_rec_enables(); }
	};
};
