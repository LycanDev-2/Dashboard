import random
import sys
import time

FLAVOR_TEXTS = [
    "Brewing coffee...",
    "Summoning dragons...",
    "Polishing pixels...",
    "Counting stars...",
    "Tickling the servers...",
    "Warning: Bite Risk",
    "Reticulating splines...",
    "Consulting the oracle...",
    "Aligning bits...",
    "Calibrating fun meter...",
]

VERBS = [
    # core tech verbs
    "Assembling", "Forging", "Generating", "Configuring", "Activating", "Compiling",
    "Encrypting", "Decrypting", "Initializing", "Loading", "Calibrating", "Rendering",
    "Summoning", "Optimizing", "Rebooting", "Scanning", "Allocating", "Processing",
    "Infusing", "Balancing", "Upgrading", "Reticulating", "Spawning", "Deploying",
    "Manifesting", "Channeling", "Transmitting", "Calculating", "Evolving", "Binding",
    "Invoking", "Constructing", "Deconstructing", "Streaming", "Harvesting", "Orchestrating",
    "Conjuring", "Synthesizing", "Fabricating", "Overclocking", "Teleporting", "Stabilizing",
    "Replicating", "Brewing", "Energizing", "Integrating", "Parsing", "Decoding", "Compacting",
    # more sci-fi / fantasy ops
    "Distorting", "Warping", "Collapsing", "Unraveling", "Weaving", "Crystallizing",
    "Imbuing", "Projecting", "Phasing", "Amplifying", "Resonating", "Entangling",
    "Materializing", "Fragmenting", "Glitching", "Orbiting", "Reconstructing", "Unpacking",
    "Sculpting", "Encrypting", "Animating", "Hyperlinking", "Subverting", "Summoning",
    "Crashing", "Hijacking", "Overwriting", "Charging", "Decrypting", "Aligning"
]

ADJECTIVES = [
    # base set
    "mystical", "shiny", "chaotic", "quantum", "synthetic", "ancient",
    "forbidden", "unstable", "recursive", "encrypted", "virtual", "ethereal",
    "haunted", "sacred", "magnetic", "hyperdimensional", "fractured", "glitched",
    "corrupted", "spectral", "astral", "cosmic", "volatile", "experimental",
    # extended flavor
    "phantom", "arcane", "prismatic", "celestial", "eldritch", "unstoppable",
    "digital", "radioactive", "plasma-bound", "holographic", "cybernetic",
    "anomalous", "paradoxical", "inverted", "chaos-driven", "unholy",
    "subliminal", "singularity-touched", "nanoscopic", "transcendent", "timeless",
    "encrypted", "haunted", "forbidden", "infinite", "recursive", "resonant",
    "spectral", "sacred", "illusory", "feral", "mechanized", "dystopian",
    "apocalyptic", "encrypted", "celestial", "burning", "encrypted", "corrosive",
    "shadowed", "luminescent", "forbidden", "recursive", "encrypted"
]

NOUNS = [
    # computing + critters
    "widgets", "protocols", "hamsters", "algorithms", "servers", "pixels",
    "frameworks", "dragons", "galaxies", "packets", "overlords", "buffers",
    "kernels", "nanobots", "matrices", "dungeons", "crypts", "daemons",
    "threads", "clouds", "dimensions", "clusters", "fractals", "routines",
    # extended pool
    "rabbitholes", "constructs", "specters", "firewalls", "gateways", "rifts",
    "avatars", "subroutines", "obelisks", "archives", "sandboxes", "modules",
    "empires", "portals", "anomalies", "signatures", "beacons", "currents",
    "repositories", "phantoms", "entities", "enclaves", "schemas", "voids",
    "cryptograms", "vectors", "colossi", "simulations", "resonances", "idols",
    "libraries", "phantasms", "towers", "nexuses", "monoliths", "caches",
    "horizons", "nodes", "realities", "membranes", "clusters", "quantas",
    "spectrums", "relays", "furnaces", "circuits", "idols", "vaults",
    "singularities", "vortices", "codes", "shards", "archives", "holograms"
]

def generate_random_line():
    verb = random.choice(VERBS)
    adj = random.choice(ADJECTIVES)
    noun = random.choice(NOUNS)
    return f"{verb} {adj} {noun}..."

def choice():
    """
    Decide how to create a flavor text:
    - 60% chance: generated line
    - 30% chance: canned line
    - 10% chance: stitched combo
    """
    roll = random.random()
    if roll < 0.6:
        return generate_random_line()
    elif roll < 0.9:
        return random.choice(FLAVOR_TEXTS)
    else:
        first = generate_random_line() if random.random() < 0.5 else random.choice(FLAVOR_TEXTS)
        second = generate_random_line() if random.random() < 0.5 else random.choice(FLAVOR_TEXTS)
        return f"{first} and {second}"

def flavor_text_generator():
    while True:
        yield choice()

def loading_animation(duration=30, interval=0.5):
    gen = flavor_text_generator()
    end_time = time.time() + duration
    while time.time() < end_time:
        text = next(gen)
        print(text)  # <-- print on its own line, no overwrite
        sys.stdout.flush()
        time.sleep(interval)

if __name__ == "__main__":
    loading_animation()
