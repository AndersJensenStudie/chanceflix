pub mod Chance.Phone {
    use Random2.RandomInt32
    use Chance.Phone

    ///
    /// Generates a formatted random US phone number without country code.
    ///
    pub def phone(): String \ Phone = 
        rPhone("US", true, false)

    ///
    /// Generates a formatted random DK phone number without country code.
    ///
    pub def dkPhone(): String \ Phone = 
        rPhone("DK", true, false)


    def getFmt(country: String, fmt: Bool, cc: Bool): (String, String) = match country {
        case "US" => (if (fmt) "(###) ###-####" else "##########", "+1")
        case "UK" => (if (fmt) "07### ######" else "07##########", "+44")
        case "DK" => (if (fmt) "## ## ## ##" else "########", "+45")
        case "DE" => (if (fmt) "0### ### ####" else "0##########", "+49")
        case "FR" => (if (fmt) "0# ## ## ## ##" else "0#########", "+33")
        case "JP" => (if (fmt) "0# #### ####" else "0##########", "+81")
        case "AU" => (if (fmt) "04## ### ###" else "04########", "+61")
        case "IN" => (if (fmt) "##### #####" else "##########", "+91")
        case "BR" => (if (fmt) "(##) #####-####" else "###########", "+55")
        case "ES" => (if (fmt) "### ## ## ##" else "#########", "+34")
        case _ => getFmt("US", fmt, cc)
    }



    def replaceHash(fmt: String): String \ RandomInt32 =
        fmt |> String.map(c -> {
            if (c == '#') {
                RandomInt32.randRange(0, 9) |> Int32.toString |> String.charAt(0)
            } else c
        })

    // Middleware
    
    ///
    /// Middleware that intercepts the `Phone` effect, adding the country code to calls to the `rPhone` operation.
    ///
    pub def withCountryCode(f: Unit -> a \ ef): a \ ef - Phone + Phone =
        run {
            f()
        } with handler Phone {
            def rPhone(country, fmt, _cc, k) =
                k(Phone.rPhone(country, fmt, true))
        }
    
    ///
    /// Middleware that intercepts the `Phone` effect, setting the country to Denmark for calls to the `rPhone` operation.
    ///
    pub def withDanishNumbers(f: Unit -> a \ ef): a \ ef - Phone + Phone =
        run {
            f()
        } with handler Phone {
            def rPhone(_country, fmt, cc, k) =
                k(Phone.rPhone("DK", fmt, cc))
        }

    ///
    /// Middleware that intercepts the `Phone` effect, removing formatting from the returned phone number.
    ///
    pub def unformatted(f: Unit -> a \ ef): a \ ef - Phone + Phone =
        run {
            f()
        } with handler Phone {
            def rPhone(country, _fmt, cc, k) =
                k(Phone.rPhone(country, false, cc))
        }

    // Terminating handlers

    ///
    /// Runs the `Phone` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Phone` effect using the `IO` effect.
    ///
    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ ef - Phone + IO = 
        run {
            f()
        } with handler Phone {
            def rPhone(country, fmt, cc, k) = {
                run {
                    let (fmtstr, pre) = getFmt(country, fmt, cc);
                    let number = replaceHash(fmtstr);
                    k(if (cc) {"${pre} ${number}"} else {number})
                } with Random2.RandomInt32.runWithIO
            }
        }
    
    ///
    /// Runs the `Phone` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Phone` effect using the `RandomInt32` effect.
    ///
    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ ef - Phone + RandomInt32 = 
        run {
            f()
        } with handler Phone {
            def rPhone(country, fmt, cc, k) = {
                let (fmtstr, pre) = getFmt(country, fmt, cc);
                let number = replaceHash(fmtstr);
                k(if (cc) {"${pre} ${number}"} else {number})
            }
        }

    ///
    /// Runs the `Phone` effect of the given function `f`.
    ///
    /// In other words, re-interprets the `Phone` effect using the `Random2` effect.
    ///
    pub def runWithRandom(f: Unit -> a \ ef): a \ ef - Phone + Random2 = 
        run {
            f()
        } with handler Phone {
            def rPhone(country, fmt, cc, k) = {
                run {
                    let (fmtstr, pre) = getFmt(country, fmt, cc);
                    let number = replaceHash(fmtstr);
                    k(if (cc) {"${pre} ${number}"} else {number})
                } with Random2.RandomInt32.runWithRandom
            }
        }
}