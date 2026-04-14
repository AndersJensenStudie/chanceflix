pub mod Random2.RandomInt16 {
    use Random2.RandomInt16

    @DefaultHandler 
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - RandomInt16) + IO =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                let b = run {
                    getRandomInt16WithRandom()
                } with Random2.runWithIO;
                k(b)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt16) + Random2 + IO =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                k(getRandomInt16WithRandom())
        }

    def getRandomInt16WithRandom(): Int16 \ Random2 + IO = 
        let bytes = Random2.randomBytes(2);
        println(bytes);
        println(Vector.head(bytes));
        println(Vector.nth(1, bytes));

        let b1 = Vector.head(bytes) |> Option.getWithDefault(0i8) |> Int8.toInt16;
        let b2 = Vector.nth(1, bytes) |> Option.getWithDefault(0i8) |> Int8.toInt16;
        println(b1);
        println(b2);
        let b2shifted = Int16.leftShift(b2, 8);
        println("shifted: ${b2shifted}");
        Int16.bitwiseOr(b1, b2shifted) !> println

}