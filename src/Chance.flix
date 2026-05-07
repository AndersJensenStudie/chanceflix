pub mod Chance {
    use Chance.Phone
    use Chance.unique
    use Chance.RCreditCardType.CreditCardType
    use Chance.Coin.CoinType
    
    ///
    /// An effect used to simulate rolling a die.
    ///
    pub eff Dice {
        def roll(sides: Int32): Int32
    }
    
    ///
    /// An effect used to simulate multiple dice rolls
    ///
    pub eff Rpg {
        ///
        /// Returns a list of dice rolls. 
        ///
        /// `str` should be given in the format "`X`d`Y`", `X` indicating the number of rolls and `Y` indicating the number of sides of the simulated die. 
        ///
        /// If `sum` is `true` the returned list will have one element, which is the sum. 
        ///
        def rpg(str: String, sum: Bool): List[Int32]
    }
    
    ///
    /// An effect used to generate a random globally unique identifier
    ///
    pub eff Guid {
        def guid(): String
    }

    ///
    /// An effect used to generate a random string
    ///
    pub eff RString {
        ///
        /// Returns a random string with length between `min` (inclusive) and `max` (exclusive). 
        ///
        /// `pool` is a string containing the characters that may appear in the returned string.
        ///
        def rString(min: {min = Int32}, max: {max = Int32}, pool: String): String
    }

    ///
    /// An effect used to generate a random char
    ///
    pub eff RChar {
        ///
        /// Returns a random char.
        ///
        /// `pool` is a string containing the characters that may be returned.
        ///
        def rChar(pool: String): Char
    }
    
    ///
    /// An effect used to generate a random top-level domain
    ///
    pub eff Tld {
        ///
        /// Returns a random string representing a top-level domain.
        ///
        /// `pool` is a vector containing the strings that may be returned.
        ///
        def rTld(pool: Vector[String]): String
    }

    ///
    /// An effect used to generate a random phone number
    ///
    pub eff Phone {
        ///
        /// Returns a random string representing a phone number.
        ///
        /// `country` is a two-letter string. If `fmt` is `true`, the phone number will be formatted according to the customs of the specified country. If `cc` is `true`, the country code will be prepended. 
        ///
        def rPhone(country: Phone.Country, fmt: Bool, cc: Bool): String
    }

    ///
    /// An effect used to generate a random animal
    ///
    pub eff Animal {
        ///
        /// Returns a string representing a random animal.
        ///
        /// `typ` is the habitat of the animal. If an invalid value is given, a random one will be chosen. 
        ///
        def rAnimal(typ: String): String
    }

    ///
    /// An effect used to generate a random human age
    ///
    pub eff Age {
        ///
        /// Returns a random human age between 0 (inclusive) and 106 (exclusive). 
        ///
        /// The ages seperating `Child`, `Teen`, `Adult` and `Senior` are 13, 20 and 65 respectively. 
        ///
        def rAge(typ: Option[Chance.Age.AgeType]): Int32
    }

    ///
    /// An effect used to generate a random currency
    ///
    pub eff Currency {
        def currency(): Chance.Currency.Cur
    }

    // Utility functions for effects

    ///
    /// Returns a list of `i` instances of running `f`. 
    ///
    pub def n(f: Unit -> b \ ef, i: Int32): List[b] \ ef =
        if (i <= 0) {
            Nil
        } else {
            let x = f();
            x :: n(f, i - 1)
        }

    ///
    /// Returns a list of `i` instances of running `f`.
    ///
    /// All elements of the list are unique.
    ///
    pub def unique(f: Unit -> b \ ef, i: Int32): List[b] \ ef with Eq[b] =
        if (i <= 0) {
            Nil
        } else {
            let x = f();
            let rest = unique(f, i - 1);
            if (List.exists(elem -> (x == elem), rest)) {
                unique(f, i) //try again without decrementing i
            } else {
                x :: rest
            }
        }

    ///
    /// An effect used to generate a random credit card number of type `tp`.
    ///
    /// The resulting card will be of correct length and pass Luhns Algorithm
    ///
    pub eff CreditCardNo {
        def creditCardNo(tp: RCreditCardType.CreditCardType): String
    }

    ///
    /// An effect used to generate a random credit card type.
    ///
    pub eff RCreditCardType {
        def rCreditCardType(): RCreditCardType.CreditCardType
    }

    ///
    /// An effect combining the `CreditCardNo` and `CreditCardType` effects for easier handling.
    ///
    pub eff CreditCard {
        def creditCardNo(tp: RCreditCardType.CreditCardType): String
        def creditCardType(): RCreditCardType.CreditCardType
    }

    ///
    /// An effect used to generate a random hash.
    ///
    pub eff Hash {
        ///
        /// Returns a random hash of length `length`. Uses uppercase letters if `isUpperCase` is `true`.
        ///
        def hash(length: Int32, isUpperCase: Bool): String
    }

    ///
    /// An effect used to generate a Normal distributed random number
    ///
    pub eff Normal {
        def normal(mean: Float64, dev: Float64): Float64 
    }

    ///
    /// An effect used to generate a Bernoulli distributed random int in {0, 1}.
    ///
    pub eff Bernoulli {
        ///
        /// Returns a random int in {0, 1}.
        /// Gives 1 with probability `p`.
        /// A `p` larger than 1 guarantees the result will be 1. A `p` smaller than 0 guarantees 0.
        ///
        def bernoulli(p: Float64): Int32
    }

    ///
    /// An effect used to generate a Binomial distributed random number.
    ///
    pub eff Binomial {
        def binomial(n: Int32, p: Float64): Int32
    }

    ///
    /// An effect used to generate a Poisson distributed random number.
    ///
    pub eff Poisson {
        def poisson(rate: Float64): Int32
    }
    
    ///
    /// An effect used to simulate a coin flip.
    ///
    pub eff Coin {
        ///
        /// Returns the result of a coinflip. `p` contains the probability of each possible outcome. 
        ///
        def flip(p: { heads = Float32, tails = Float32, edge = Float32 }): CoinType
    }

    ///
    /// An effect used to generate a random RGB color as defined in RichString.
    ///
    pub eff Color {
        def rColor(): RichString.Color
    }

}