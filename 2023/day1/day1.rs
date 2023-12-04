// 1abc2 - 12
// pqr3stu8vwx 38
// a1b2c3d4e5f - 15
// treb7uchet - 77
// oneeight - 18

use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::collections::HashMap;

fn main() {
    let mut final_sum = 0;
    if let Ok(lines) = read_lines("./input.txt") {
        // Consumes the iterator, returns an (Optional) String
        for line in lines {
            if let Ok(ip) = line {
                let code = get_code(ip);
                final_sum = final_sum + code;
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

fn get_code(mut instruction: String) -> u32 {
    println!("Before Transliteration = {}", instruction);
    instruction = transliterate_code(instruction);
    
    let my_chars: Vec<_> = instruction.chars().collect();
    let my_chars_rev = my_chars.clone();
    
    let mut final_number_str = String::new();
    for instruction_char in my_chars {
        if instruction_char.is_numeric() {
            final_number_str.push(instruction_char);
            break;
        }
    }
    
    for instruction_char in my_chars_rev.into_iter().rev() {
        if instruction_char.is_numeric() {
            final_number_str.push(instruction_char);
            break;
        }
    }
    
    println!("Final Number = {}", final_number_str);
    return final_number_str.parse::<u32>().unwrap();
}

fn transliterate_code(mut instruction: String) -> String {
    let dictionary = vec!["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
    let dictionary1 = HashMap::from([
        ("one", "o1e"),
        ("two", "t2o"),
        ("three", "thr3e"),
        ("four", "fo4r"),
        ("five", "f5ve"),
        ("six", "s6x"),
        ("seven", "s7ven"),
        ("eight", "eig8t"),
        ("nine", "n9ne")
    ]);
    let mut matched_word:Option<&str> = None;
    let mut replacement:Option<&str> = None;
    let mut matched_index = instruction.len() + 1;
    
    for (word, repl) in dictionary1.iter() {
        instruction = instruction.replace(word, repl);
    }
    println!("Transliteration = {}", instruction);
    instruction
}