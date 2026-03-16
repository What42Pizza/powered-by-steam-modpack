use crate::*;



pub fn export(mod_path: PathBuf, output_path: Option<PathBuf>) -> Result<()> {
	
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
	
	let mod_name = mod_path.file_name().expect("Fatal: mod path seems to be empty").to_str().expect("Fatal: map path contains non-utf-8 characters");
	let mut output_path = output_path.unwrap_or(mod_path.clone());
	output_path.push(format!("{mod_name}_{version}.zip"));
	
	// export all
	let output_file = std::fs::File::create(output_path)?;
	let mut output_zip = ZipWriter::new(output_file);
	let options: FileOptions<()> = FileOptions::default();
	let top_level_folder = format!("{mod_name}_{version}");
	output_zip.add_directory(&top_level_folder, options.clone())?;
	for item_name in ITEMS_TO_EXPORT {
		let full_path = mod_path.join(item_name);
		if full_path.is_dir() {
			add_folder_to_zip(&mut output_zip, full_path, &top_level_folder, &mod_path, &options)?;
		} else {
			add_file_to_zip(&mut output_zip, item_name, full_path, &top_level_folder, &options)?;
		}
	}
	
	Ok(())
}



pub fn add_file_to_zip<T: FileOptionExtension + Clone>(zip: &mut ZipWriter<File>, item_name: &str, full_path: PathBuf, top_level_folder: &str, options: &FileOptions<T>) -> Result<()> {
	println!("Adding file '{item_name}'...");
	zip.start_file(format!("{top_level_folder}/{item_name}"), options.clone())?;
	let mut item_file = File::open(full_path)?;
	std::io::copy(&mut item_file, zip)?;
	Ok(())
}

pub fn add_folder_to_zip<T: FileOptionExtension + Clone>(zip: &mut ZipWriter<File>, full_path: PathBuf, top_level_folder: &str, mod_path: &Path, options: &FileOptions<T>) -> Result<()> {
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
