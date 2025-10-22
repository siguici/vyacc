module main

import v.vmod
import os
import cli
import term
import vyacc

const logo = '
 ██╗   ██╗ ██╗   ██╗  █████╗   ██████╗  ██████╗
 ██║   ██║ ╚██╗ ██╔╝ ██╔══██╗ ██╔════╝ ██╔════╝
 ██║   ██║  ╚████╔╝  ███████║ ██║      ██║
 ╚██╗ ██╔╝   ╚██╔╝   ██╔══██║ ██║      ██║
  ╚████╔╝     ██║    ██║  ██║ ╚██████╗ ╚██████╗
   ╚═══╝      ╚═╝    ╚═╝  ╚═╝  ╚═════╝  ╚═════╝'

const manifest = vmod.decode(@VMOD_FILE) or { panic(err) }

pub fn main() {
	mut app := cli.Command{
		name:        manifest.name
		version:     manifest.version
		description: manifest.description
		usage:       'vyacc [file]'
		execute:     fn (cmd cli.Command) ! {
			args := cmd.args
			mut code := 1
			if args.len < 1 {
				println(term.blue(logo))
				code = 0
			}
			h := cmd.help_message()
			println(h)
			exit(code)
		}
	}

	app.setup()
	app.parse(os.args)
}
