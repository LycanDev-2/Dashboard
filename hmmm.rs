use rand::seq::SliceRandom;
use rand::thread_rng;
extern crate rand;

fn generate_flavor_text() -> &'static str {
    let flavor_texts = [
        "The wind whispers secrets through the ancient trees.",
        "A faint glow illuminates the forgotten ruins.",
        "You feel a chill as shadows dance along the walls.",
        "The scent of fresh rain lingers in the air.",
        "Distant laughter echoes across the moonlit field.",
        "A mysterious figure watches from the edge of the forest.",
        "The crackling fire casts flickering shapes on the stone.",
        "Soft footsteps fade into the misty morning.",
        "A gentle breeze carries the promise of adventure.",
        "The stars shimmer above, silent witnesses to your journey.",
    ];
    let mut rng = thread_rng();
    flavor_texts.choose(&mut rng).unwrap()
}

fn main() {
    println!("{}", generate_flavor_text());
}
