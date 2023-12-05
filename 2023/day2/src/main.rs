use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use regex::Regex;
use std::collections::HashMap;

fn main() {
    let mut final_sum = 0;
    if let Ok(lines) = read_lines("./input") {
        // Consumes the iterator, returns an (Optional) String
        for line in lines {
            if let Ok(ip) = line {
                let result = solve_puzzle(ip);
                final_sum = final_sum + result;
            }
        }
    }
    println!("Code = {}", final_sum);
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
    let Some(caps) = re.captures(parts[0]) else {
        return 0;
    };
    println!("Game id = {}", &caps["game_id"]);
    let game_id = &caps["game_id"];
    
    let game_attempts = parts[1].split(";");
    let mut min_colors = HashMap::from([
        ("red", 0),
        ("green", 0),
        ("blue", 0)
    ]);
    for game_attempt in game_attempts {
        println!("Game attempt = {}", game_attempt);
        // if game_play_valid(game_attempt) == false {
        //     return 0;
        // }
        min_colors = check_min_gameplay(min_colors, game_attempt);
        println!("Min Colors = {:?}", min_colors);
    }
    
    let final_power = min_colors["red"] * min_colors["blue"] * min_colors["green"];
    return final_power;
}

fn check_min_gameplay<'a>(mut min_colors: HashMap<&'a str, u32>, game_play: &str) -> HashMap<&'a str, u32> {
    let red_regex = Regex::new(r"(?<red_number>\d+) red").unwrap();
    let green_regex = Regex::new(r"(?<green_number>\d+) green").unwrap();
    let blue_regex = Regex::new(r"(?<blue_number>\d+) blue").unwrap();
    
    let red_cap = red_regex.captures(game_play);
    
    if !red_cap.is_none() {
        let red_val = red_cap.expect("Red number missing").name("red_number").unwrap().as_str().parse::<u32>().unwrap();
        if red_val > min_colors["red"] {
            min_colors.insert("red", red_val);
        }
    }
    
    let green_cap = green_regex.captures(game_play);
    
    if !green_cap.is_none() {
        let green_val = green_cap.expect("green number missing").name("green_number").unwrap().as_str().parse::<u32>().unwrap();
        if green_val > min_colors["green"] {
            min_colors.insert("green", green_val);
        }
    }
    
    let blue_cap = blue_regex.captures(game_play);
    
    if !blue_cap.is_none() {
        let blue_val = blue_cap.expect("blue number missing").name("blue_number").unwrap().as_str().parse::<u32>().unwrap();
        if blue_val > min_colors["blue"] {
            min_colors.insert("blue", blue_val);
        }
    }
    
    return min_colors;
}

fn game_play_valid(game_play: &str) -> bool {
    let max_red = 12;
    let max_green = 13;
    let max_blue = 14;
    
    let red_regex = Regex::new(r"(?<red_number>\d+) red").unwrap();
    let green_regex = Regex::new(r"(?<green_number>\d+) green").unwrap();
    let blue_regex = Regex::new(r"(?<blue_number>\d+) blue").unwrap();
    
    let red_cap = red_regex.captures(game_play);
    
    if !red_cap.is_none() {
        let red_val = red_cap.expect("Red number missing").name("red_number").unwrap().as_str().parse::<u32>().unwrap();
        if red_val > max_red {
            return false;
        }
    }
    
    let green_cap = green_regex.captures(game_play);
    
    if !green_cap.is_none() {
        let green_val = green_cap.expect("green number missing").name("green_number").unwrap().as_str().parse::<u32>().unwrap();
        if green_val > max_green {
            return false;
        }
    }
    
    let blue_cap = blue_regex.captures(game_play);
    
    if !blue_cap.is_none() {
        let blue_val = blue_cap.expect("blue number missing").name("blue_number").unwrap().as_str().parse::<u32>().unwrap();
        if blue_val > max_blue {
            return false;
        }
    }
    
    return true;
}

