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

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - RandomInt16) + Random2 =
        run {
            f()
        } with handler RandomInt16 {
            def randomInt16(k) = 
                k(getRandomInt16WithRandom())
        }

    def getRandomInt16WithRandom(): Int16 \ Random2 = 
        let bytes = Random2.randomBytes(2);
        let b1 = Vector.head(bytes) |> Option.getWithDefault(0i8);
        let b2 = Vector.nth(1, bytes) |> Option.getWithDefault(0i8);
        let b2shifted = Int16.leftShift(Int8.toInt16(b2), 8);
        let b1int16 = Int8.toInt16(b1) |> (s) -> Int16.bitwiseAnd(s, 255i16); 
        Int16.bitwiseOr(b1int16, b2shifted)
}