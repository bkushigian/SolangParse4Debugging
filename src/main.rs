use ansi_term::Color;
use clap::Parser;
use solang::{file_resolver::FileResolver, parse_and_resolve};
use std::{
    ffi::{OsStr, OsString},
    path::PathBuf,
};

#[derive(Debug, Clone, Parser)]
#[command(rename_all = "snake_case")]
struct Opt {
    #[clap(num_args=0..)]
    pub filenames: Vec<String>,

    #[clap(short, long, num_args=1..)]
    pub import_paths: Vec<String>,

    #[clap(short, long, num_args=1..)]
    pub import_maps: Vec<String>,
}

fn main() {
    let opt = Opt::parse();

    let mut import_paths = opt.import_paths.clone();
    if import_paths.is_empty() {
        import_paths.push(".".to_string());
    }

    let mut cache = FileResolver::default();
    for path in import_paths {
        cache.add_import_path(&PathBuf::from(path));
    }
    for rm in opt.import_maps {
        let split_rm: Vec<&str> = rm.split('=').collect();
        if split_rm.len() != 2 {
            panic!("Invalid remapping: {}", rm);
        }
        let map = split_rm[0];
        let target = split_rm[1];

        cache.add_import_map(OsString::from(map), target.into());
    }

    for filename in opt.filenames.iter() {
        let ns = parse_and_resolve(OsStr::new(filename), &mut cache, solang::Target::EVM);
        if ns.diagnostics.any_errors() {
            println!(
                "\n{}  {} parsing {}  {}",
                Color::Cyan.bold().paint("====="),
                Color::Red.bold().paint("Error"),
                Color::White.bold().paint(filename),
                Color::Cyan.bold().paint("=====")
            );
            ns.print_diagnostics(&cache, false);
            std::process::exit(ns.diagnostics.any_errors() as i32);
        }
    }
}
