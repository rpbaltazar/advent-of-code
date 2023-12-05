use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use regex::Regex;

fn main() {
    let mut result = 0;
    if let Ok(lines) = read_lines("./input_sample") {
        // Consumes the iterator, returns an (Optional) String
        for line in lines {
            if let Ok(ip) = line {
                result = solve_puzzle(ip);
            }
        }
    }
    println!("Code = {}", result);
}

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

fn solve_puzzle(instruction: String) -> u32 {
    println!("Instruction = {}", instruction);
    let parts: Vec<_> = instruction.split(":").collect(); // [Game {id}, game tries]
    let re = Regex::new(r"Game (?<game_id>\d+)").unwrap();
    let Some(game_id) = re.captures(parts[0]) else {
        return 0;
    };
    
    println!("Game id = {}", &game_id);
    return 10
}

