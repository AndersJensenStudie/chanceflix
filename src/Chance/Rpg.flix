pub mod Chance.Rpg {
    use Sys.Console.print
    use Chance.Rpg
    use Chance.Dice

    pub def runWithDice(f: Unit -> a \ ef): a \ (ef - Rpg) + Dice = 
        run {
            f()
        } with handler Rpg {
            def rpg(str, sum, k) = {
                let rolls = doRolls(parse(str));
                if (sum) {
                    k(getSum(rolls))
                } else {
                    k(rolls)
                }
            }
        }
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Rpg) + IO = 
        run {
            f()
        } with handler Rpg {
            def rpg(str, sum, k) = {
                let parsed = parse(str);
                let rolls = run{doRolls(parsed)} with Dice.runWithIO;
                if (sum) {
                    k(getSum(rolls))
                } else {
                    k(rolls)
                }
            }
        }

    def parse(str: String): List[Int32] = 
        String.split(regex = "d", str) 
        |> List.map(s -> Int32.fromString(s))
        |> List.map(Option.getWithDefault(0))
    
    def doRolls(parsed: List[Int32]): List[Int32] \ Dice = 
        let times = Option.getWithDefault(0, List.head(parsed));
        let sides = Option.getWithDefault(0, List.nth(1, parsed));
        List.repeat(times, 0) |> List.map(_ -> Dice.roll(sides))
    
    def getSum(l: List[Int32]): List[Int32] =
        List.foldLeft(acc -> a -> (acc + a), 0, l) :: Nil
}