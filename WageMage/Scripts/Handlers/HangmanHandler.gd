class_name HangmanHandler


# Hangman state ----------------------------------------------------------------
enum HangmanState {
    SETTING,
    PLAYING,
    CHECKING,
    RESULT
}


# Key state --------------------------------------------------------------------
enum KeyState {
    AVALIABLE,
    UNAVAILABLE,
    CORRECT,
    INCORRECT,
}


# Letter type ------------------------------------------------------------------
enum LetterType {
    CORRECT,
    INCORRECT,
}
