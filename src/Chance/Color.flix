pub mod Chance.Color {
    use Chance.Age.runWithRandomInt32
    use Chance.Color

    ///
    /// Runs the `Color` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Color` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> b \ ef): b \ (ef - Color) + IO = 
        run {
            f()
        } with handler Color {
            def rColor(k) = 
                let res = run {
                    getRandomColor()
                } with Random2.RandomInt32.runWithIO;
                k(res)
        }
    
    ///
    /// Runs the `Color` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Color` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> b \ ef): b \ (ef - Color) + Random2 = 
        run {
            f()
        } with handler Color {
            def rColor(k) = 
                let res = run {
                    getRandomColor()
                } with Random2.RandomInt32.runWithRandom;
                k(res)
        }

    ///
    /// Runs the `Color` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Color` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> b \ ef): b \ (ef - Color) + Random2.RandomInt32 = 
        run {
            f()
        } with handler Color {
            def rColor(k) = 
                k(getRandomColor())
        }

    ///
    /// Returns a triple (r,g,b) representing a random RGB color
    ///
    pub def getRandomColorTriple(): (Int32, Int32, Int32) \ Color = 
        let (r, g, b) = match rColor() {
            case RichString.Color.Rgb(r, g, b) => (r, g, b)
            case RichString.Color.Default => bug!("unreachable")
        };
        (r, g, b)

    ///
    /// Returns a random RGB color as defined in RichString
    ///
    def getRandomColor(): RichString.Color \ Random2.RandomInt32 = 
        let r = Random2.RandomInt32.randRange(0i32, 256i32);
        let g = Random2.RandomInt32.randRange(0i32, 256i32);
        let b = Random2.RandomInt32.randRange(0i32, 256i32);
        RichString.Color.Rgb(r, g, b)
}