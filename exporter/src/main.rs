#![allow(unused)]
#![warn(unused_must_use)]



use std::{fs::{self, File, FileType}, path::{Path, PathBuf}, time::Instant};
use anyhow::*;
use walkdir::WalkDir;
use zip::{ZipWriter, write::{FileOptionExtension, FileOptions}};



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



fn main() -> Result<()> {
	let start = Instant::now();
	let mod_path = get_mod_path()?;
	
	// get version string
	let info_file = fs::read_to_string(mod_path.join("info.json"))?;
	let version = 'version: {
		for line in info_file.lines() {
			let version_start = line.find("version");
			let Some(version_start) = version_start else { continue; };
			let version = &line[version_start + 11 .. line.len() - 2];
			break 'version version;
		}
		return Err(Error::msg("Error: failed to find version field within file 'info.json'"));
	};
	
	// export all
	let output_file = std::fs::File::create(mod_path.join(format!("better-oil-processing_{version}.zip")))?;
	let mut output_zip = ZipWriter::new(output_file);
	let options: FileOptions<()> = FileOptions::default();
	let top_level_folder = format!("better-oil-processing_{version}");
	output_zip.add_directory(&top_level_folder, options.clone())?;
	for item_name in ITEMS_TO_EXPORT {
		let full_path = mod_path.join(item_name);
		if full_path.is_dir() {
			add_folder_to_zip(&mut output_zip, item_name, full_path, &top_level_folder, &mod_path, &options)?;
		} else {
			add_file_to_zip(&mut output_zip, item_name, full_path, &top_level_folder, &options)?;
		}
	}
	
	println!("Finished in {}s", start.elapsed().as_secs_f32());
	Ok(())
}



pub fn add_file_to_zip<T: FileOptionExtension + Clone>(zip: &mut ZipWriter<File>, item_name: &str, full_path: PathBuf, top_level_folder: &str, options: &FileOptions<T>) -> Result<()> {
	println!("Adding file '{item_name}'...");
	zip.start_file(format!("{top_level_folder}/{item_name}"), options.clone())?;
	let mut item_file = File::open(full_path)?;
	std::io::copy(&mut item_file, zip)?;
	Ok(())
}

pub fn add_folder_to_zip<T: FileOptionExtension + Clone>(zip: &mut ZipWriter<File>, item_name: &str, full_path: PathBuf, top_level_folder: &str, mod_path: &Path, options: &FileOptions<T>) -> Result<()> {
	for entry in WalkDir::new(full_path) {
		let entry = entry?;
		let full_path = entry.path();
		let path_within_zip = full_path.strip_prefix(&mod_path)?.to_str();
		let Some(path_within_zip) = path_within_zip else { panic!("Failed to convert path {full_path:?} to a string"); };
		if entry.file_type().is_dir() {
			println!("Starting directory '{path_within_zip}'");
			zip.add_directory(format!("{top_level_folder}/{path_within_zip}"), options.clone())?;
		} else {
			println!("Adding file '{path_within_zip}...'");
			zip.start_file(format!("{top_level_folder}/{path_within_zip}"), options.clone())?;
			let mut item_file = File::open(full_path)?;
			std::io::copy(&mut item_file, zip)?;
		}
	}
	Ok(())
}



pub fn get_mod_path() -> Result<PathBuf> {
	let mut curr_path = get_program_path();
	loop {
		let info_path = curr_path.join("info.json");
		if info_path.exists() {
			return Ok(curr_path);
		}
		let did_pop = curr_path.pop();
		if !did_pop {return Err(Error::msg("Could not find file 'info.json' to indicate location of mod folder"));}
	}
}

pub fn get_program_path() -> PathBuf {
	let mut output =
		std::env::current_exe()
		.expect("Could not retrieve the path for the current executable");
	output.pop();
	output
}
