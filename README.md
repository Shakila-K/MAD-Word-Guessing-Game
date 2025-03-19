# Word Guessing Game

A fun and interactive word guessing game built with Flutter.

## Features

- Random word generation using the API Ninjas API.
- Score tracking and deduction for incorrect guesses.
- Hints system with penalties.
- Timer to track game duration.
- Game completion and game over screens.

## Installation

1. **Install dependencies:**

   ```sh
   flutter pub get
   ```

2. **Set up API Key:**
   Create a `.env` file in the root of the project and add the following:

   ```env
   # API Ninja API KEY
   X-Api-Key = <your api key>
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## How to Play

- Enter your guess in the input field.
- Click "Guess" to check your answer.
- Use hints if needed, but they reduce your score.
- The game ends when you guess correctly or run out of attempts.
