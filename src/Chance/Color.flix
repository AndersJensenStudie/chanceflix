pub mod Chance.Color {
    use Chance.CreditCardNo.getRandomCreditCardNo
    use Chance.Age.runWithRandomInt32
    use Chance.Color

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


    pub def runWithRandomInt32(f: Unit -> b \ ef): b \ (ef - Color) + Random2.RandomInt32 = 
        run {
            f()
        } with handler Color {
            def rColor(k) = 
                k(getRandomColor())
        }

    pub def getRandomColorTriple(): (Int32, Int32, Int32) \ Color = 
        let (r, g, b) = match rColor() {
            case RichString.Color.Rgb(r, g, b) => (r, g, b)
            case RichString.Color.Default => bug!("unreachable")
        };
        (r, g, b)

    def getRandomColor(): RichString.Color \ Random2.RandomInt32 = 
        let r = Random2.RandomInt32.randRange(0i32, 256i32);
        let g = Random2.RandomInt32.randRange(0i32, 256i32);
        let b = Random2.RandomInt32.randRange(0i32, 256i32);
        RichString.Color.Rgb(r, g, b)
}