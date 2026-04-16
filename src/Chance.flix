pub mod Chance {
    use Chance.unique
    // Effect definitions
    pub eff Dice {
        def roll(sides: Int32): Int32
    }
    
    pub eff Rpg {
        def rpg(str: String, sum: Bool): List[Int32]
    }
    
    pub eff Guid {
        def guid(): String
    }


    // Utility functions for effects
    pub def n(f: Unit -> b \ ef, i: Int32): List[b] \ ef =
        if (i <= 0) {
            Nil
        } else {
            let x = f();
            x :: n(f, i - 1)
        }

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
}