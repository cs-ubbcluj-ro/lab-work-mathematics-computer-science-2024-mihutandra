import re

class FiniteAutomaton:
    def __init__(self):
        self.states = set()
        self.alphabet = set()
        self.transitions = {}
        self.start_state = None
        self.final_states = set()

    def load_from_file(self, filename):
        try:
            with open(filename, 'r') as file:
                lines = file.readlines()
        except FileNotFoundError:
            print(f"Error: File '{filename}' not found.")
            return

        try:
            # Parse states
            self.states = set(state.strip() for state in lines[0].strip().split(":")[1].split(","))
            # Parse alphabet
            self.alphabet = set(symbol.strip() for symbol in lines[1].strip().split(":")[1].split(","))
            # Parse transitions
            for line in lines[2:]:
                line = line.strip()
                if line.startswith("start:"):
                    self.start_state = line.split(":")[1].strip()
                elif line.startswith("final:"):
                    self.final_states = set(state.strip() for state in line.split(":")[1].split(","))
                elif "->" in line:
                    match = re.match(r"(\w+),\s*([^\s]+)\s*->\s*(\w+)", line)
                    if match:
                        state, symbol, next_state = map(str.strip, match.groups())
                        if state not in self.transitions:
                            self.transitions[state] = {}
                        self.transitions[state][symbol] = next_state
        except IndexError:
            print("Error: Invalid file format. Ensure the file follows the expected structure.")
            return

    def display(self):
        print("\nFinite Automaton:")
        print("States:", self.states)
        print("Alphabet:", self.alphabet)
        print("Transitions:")
        for state, trans in self.transitions.items():
            for symbol, next_state in trans.items():
                print(f"  {state}, {symbol} -> {next_state}")
        print("Start State:", self.start_state)
        print("Final States:", self.final_states)

    def is_valid_token(self, token):
        current_state = self.start_state
        for char in token:
            if char not in self.alphabet:
                print(f"Error: Character '{char}' is not in the alphabet.")
                return False
            if current_state not in self.transitions or char not in self.transitions[current_state]:
                print(f"No transition found for state '{current_state}' with symbol '{char}'.")
                return False
            next_state = self.transitions[current_state][char]
            print(f"Transitioning from {current_state} with '{char}' to {next_state}.")
            current_state = next_state

        if current_state in self.final_states:
            return True
        else:
            print(f"Ended in non-final state '{current_state}'.")
            return False


# Main Program
if __name__ == "__main__":
    fa = FiniteAutomaton()
    fa.load_from_file("FA.in")
    if not fa.states or not fa.alphabet:  # Ensure FA was loaded properly
        print("Failed to load Finite Automaton. Exiting...")
        exit(1)

    fa.display()

    print("\nEnter strings to check if they are valid tokens (type 'exit' to quit):")
    while True:
        test_string = input("> ").strip()
        if test_string.lower() == "exit":
            print("Exiting...")
            break
        if fa.is_valid_token(test_string):
            print(f"The string '{test_string}' is a valid token.")
        else:
            print(f"The string '{test_string}' is NOT a valid token.")
