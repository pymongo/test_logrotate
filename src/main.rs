use std::io::Write;

fn main() {
    let mut log_file = std::fs::OpenOptions::new()
        .create(true)
        .append(true)
        .write(true)
        .open("./log/test_logrotate.log")
        .unwrap();
    loop {
        writeln!(log_file, "{}", chrono::Local::now()).unwrap();
        std::thread::sleep(std::time::Duration::from_secs(1));
    }
}
