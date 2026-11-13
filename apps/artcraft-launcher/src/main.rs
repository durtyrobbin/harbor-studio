//! Harbor Paint and Vector Studio. Independent experimental shared-document host.
#![cfg_attr(windows, windows_subsystem = "windows")]
#![deny(clippy::unwrap_used, clippy::expect_used, clippy::panic, clippy::unimplemented, clippy::todo, clippy::unreachable)]
mod studio;
mod studio_document;
mod studio_preview;
mod studio_services;

fn native_options(_hidden: bool) -> eframe::NativeOptions {
    eframe::NativeOptions {
        viewport: egui::ViewportBuilder::default().with_title("Harbor Paint - Vector Studio").with_inner_size([1440.0, 940.0]),
        ..Default::default()
    }
}
fn main() -> std::process::ExitCode {
    env_logger::Builder::from_env(env_logger::Env::default().default_filter_or("warn")).init();
    let args: Vec<String> = std::env::args().skip(1).collect();
    match studio::run(&args) {
        Ok(()) => std::process::ExitCode::SUCCESS,
        Err(error) => {
            log::error!("{error}");
            std::process::ExitCode::FAILURE
        }
    }
}
