use crate::*;
use std::fs;



pub fn fs_read_to_string(path: impl AsRef<Path>) -> Result<String> {
	let path = path.as_ref();
	fs::read_to_string(path).with_context(|| format!("Failed to read file '{path:?}'"))
}

pub fn file_open(path: impl AsRef<Path>) -> Result<File> {
	let path = path.as_ref();
	File::open(path).with_context(|| format!("Failed to open file '{path:?}'"))
}
