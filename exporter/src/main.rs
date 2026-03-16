#![allow(unused)]
#![warn(unused_must_use)]



const ITEMS_TO_EXPORT: &[&str] = &[
	"graphics",
	"locale",
	"changelog.txt",
	"control.lua",
	"data-final-fixes.lua",
	"data-updates.lua",
	"data.lua",
	"info.json",
	"LICENSE",
	"mod-readme.txt",
	"thumbnail.png",
	"utils.lua",
];



pub use std::{fs::{self, File}, path::{Path, PathBuf}, sync::OnceLock, time::Instant, process::exit};
pub use anyhow::*;
pub use walkdir::WalkDir;
pub use zip::{ZipWriter, write::{FileOptionExtension, FileOptions}};



pub mod export;
pub use export::*;



fn main() -> Result<()> {
	let start = Instant::now();
	
	let args = std::env::args().collect::<Vec<String>>();
	struct RunArgs {
		run_type: RunType,
		path: Option<String>,
		output: Option<String>,
	}
	enum RunType {
		Help,
		Export
	}
	let mut run_args = RunArgs {
		run_type: RunType::Export,
		path: None,
		output: None,
	};
	let mut i = 1;
	let require_more_args = |i, count: usize| {
		if i + count >= args.len() {
			println!("Invalid usage: missing {count} additional argument{}", if count == 1 {""} else {"s"});
			exit(1);
		}
	};
	while i < args.len() {
		match &*args[i] {
			"--path"   | "-p" => { require_more_args(i, 1); run_args.path = Some(args[i + 1].clone()); i += 2; }
			"--output" | "-o" => { require_more_args(i, 1); run_args.output = Some(args[i + 1].clone()); i += 2; }
			"--help"   | "-h" => { run_args.run_type = RunType::Help; i += 1; }
			arg => { println!("Warning: unknown / unprocessed argument '{arg}'"); i += 1; }
		}
	}
	
	match run_args.run_type {
		
		RunType::Help => {
			println!();
			println!("Exports a Factorio mod as a distributable zip.");
			println!();
			println!("Usage:");
			println!("  exporter -p <path> [-o <path>]");
			println!("  exporter -h");
			println!();
			println!("Options:");
			println!("  -p, --path <path>      Path to the mod folder");
			println!("  -o, --output <path>    Output directory (default: same as input)");
			println!("  -h, --help             Show this help screen");
			println!();
		}
		
		RunType::Export => {
			let Some(path) = run_args.path else {
				return Err(Error::msg("Error: the mod path must be specified with '--path'"));
			};
			let mod_path = repo_path().join(path);
			let output_path = run_args.output.map(|v| PathBuf::from(v));
			export(mod_path, output_path)?;
		}
		
	}
	
	println!("Finished in {}s", start.elapsed().as_secs_f32());
	Ok(())
}



static REPO_PATH: OnceLock<PathBuf> = OnceLock::new();

pub fn repo_path() -> &'static Path {
	if let Some(repo_path) = REPO_PATH.get() { return repo_path; }
	REPO_PATH.set(get_repo_path()).expect("Fatal: failed to set static variable 'REPO_PATH'");
	REPO_PATH.get().expect("Fatal: failed to get variable 'REPO_PATH' even though it was just set")
}

pub fn get_repo_path() -> PathBuf {
	let mut curr_path = get_program_path();
	loop {
		let info_path = curr_path.join("readme.md");
		if info_path.exists() {
			return curr_path;
		}
		let did_pop = curr_path.pop();
		if !did_pop { panic!("Fatal: failed to find 'readme.md' to signify top folder of repo"); }
	}
}

pub fn get_program_path() -> PathBuf {
	let mut output =
		std::env::current_exe()
		.expect("Fatal: failed to retrieve the path of the current executable");
	output.pop();
	output
}
