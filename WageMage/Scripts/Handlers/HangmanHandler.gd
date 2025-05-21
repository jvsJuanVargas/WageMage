class_name HangmanHandler


# Body part --------------------------------------------------------------------
enum BodyPart {
    HEAD,
    TRUNK,
    LEFT_ARM,
    RIGHT_ARM,
    LEFT_LEG,
    RIGHT_LEG,
}


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
