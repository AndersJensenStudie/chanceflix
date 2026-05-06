pub mod Chance.RCreditCardType {

    pub enum CreditCardType {
        case AmericanExpress
        case BankCard
        case ChinaUnionPay
        case DinersClubInternational
        case DinersClubUnitedStatesAndCanada
        case DiscoverCard
        case InstaPayment
        case JCB
        case Laser
        case Maestro
        case Mastercard
        case Solo
        case Switch
        case Visa
        case VisaElectron
        case Dankort
        case VisaDankort
    }

    instance ToString[CreditCardType] {
        pub def toString(x: CreditCardType): String = match x {
            case CreditCardType.AmericanExpress                 => "American Express"
            case CreditCardType.BankCard                        => "Bankcard"
            case CreditCardType.ChinaUnionPay                   => "China Union Pay"
            case CreditCardType.DinersClubInternational         => "Diners Club International"
            case CreditCardType.DinersClubUnitedStatesAndCanada => "Diners Club United States"
            case CreditCardType.DiscoverCard                    => "Discover Card"
            case CreditCardType.InstaPayment                    => "InstaPayment"
            case CreditCardType.JCB                             => "JCB"
            case CreditCardType.Laser                           => "Laser"
            case CreditCardType.Maestro                         => "Masestro"
            case CreditCardType.Mastercard                      => "Mastercard"
            case CreditCardType.Solo                            => "Solo"
            case CreditCardType.Switch                          => "Switch"
            case CreditCardType.Visa                            => "Visa"
            case CreditCardType.VisaElectron                    => "Visa Electron"
            case CreditCardType.Dankort                         => "Dankort"
            case CreditCardType.VisaDankort                     => "Visa Dankort"
        }
    }

    pub def prefix(tp: CreditCardType): Vector[Int32] = match tp {
            case CreditCardType.AmericanExpress                 => Vector#{34, 37}
            case CreditCardType.BankCard                        => Vector#{5610, 560221, 560222, 560223, 560224, 560225}
            case CreditCardType.ChinaUnionPay                   => Vector#{62}
            case CreditCardType.DinersClubInternational         => Vector#{30, 36, 38, 39}
            case CreditCardType.DinersClubUnitedStatesAndCanada => Vector#{55}
            case CreditCardType.DiscoverCard                    => Vector#{6011, 644, 645, 646, 647, 648, 649, 65}
            case CreditCardType.InstaPayment                    => Vector#{637, 638, 639}
            case CreditCardType.JCB                             => Vector.range(3528, 3589 + 1)
            case CreditCardType.Laser                           => Vector#{6706, 6771, 6709}
            case CreditCardType.Maestro                         => Vector#{5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763}
            case CreditCardType.Mastercard                      => Vector.append(Vector.range(2221, 2720 + 1), Vector.range(51, 55))
            case CreditCardType.Solo                            => Vector#{6334, 6767}
            case CreditCardType.Switch                          => Vector#{4903, 4905, 4911, 4936, 564182, 633110, 6333, 6759}
            case CreditCardType.Visa                            => Vector#{4}
            case CreditCardType.VisaElectron                    => Vector#{4026, 417500, 4844, 4913, 4917}
            case CreditCardType.Dankort                         => Vector#{5019}
            case CreditCardType.VisaDankort                     => Vector#{4571}
    }

    pub def length(tp: CreditCardType): Vector[Int32] = match tp {
        case CreditCardType.AmericanExpress                 => Vector#{15}
        case CreditCardType.BankCard                        => Vector#{16}
        case CreditCardType.ChinaUnionPay                   => Vector.range(16, 19 + 1)
        case CreditCardType.DinersClubInternational         => Vector.range(14, 19 + 1)
        case CreditCardType.DinersClubUnitedStatesAndCanada => Vector#{16}
        case CreditCardType.DiscoverCard                    => Vector.range(16, 19 + 1)
        case CreditCardType.InstaPayment                    => Vector#{16}
        case CreditCardType.JCB                             => Vector.range(16, 19 + 1)
        case CreditCardType.Laser                           => Vector.range(16, 19 + 1)
        case CreditCardType.Maestro                         => Vector.range(12, 19 + 1)
        case CreditCardType.Mastercard                      => Vector#{16}
        case CreditCardType.Solo                            => Vector#{16, 18, 19}
        case CreditCardType.Switch                          => Vector#{16, 18, 19}
        case CreditCardType.Visa                            => Vector#{13, 16, 19}
        case CreditCardType.VisaElectron                    => Vector#{16}
        case CreditCardType.Dankort                         => Vector#{16}
        case CreditCardType.VisaDankort                     => Vector#{16}
    }

    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - Chance.RCreditCardType) + IO =
        run {
            f()
        } with handler Chance.RCreditCardType {
            def rCreditCardType(k) = 
                let t = run {
                    getType()
                } with Random2.RandomInt32.runWithIO;
                k(t)
        }

    pub def runWithRandomInt32(f: Unit -> a \ ef): a \ (ef - Chance.RCreditCardType) + Random2.RandomInt32 = 
        run {
            f()
        } with handler Chance.RCreditCardType {
            def rCreditCardType(k) = 
                let n = getType();
                k(n)
        }

    pub def runWithRandom(f: Unit -> a \ ef): a \ (ef - Chance.RCreditCardType) + Random2 =
        run {
            f()
        } with handler Chance.RCreditCardType {
            def rCreditCardType(k) = 
                let t = run {
                    getType()
                } with Random2.RandomInt32.runWithRandom;
                k(t)
        }

    pub def runWithCreditCard(f: Unit -> a \ ef): a \ (ef - Chance.RCreditCardType) + Chance.CreditCard =
        run {
            f()
        } with handler Chance.RCreditCardType {
            def rCreditCardType(k) = 
                let t = Chance.CreditCard.creditCardType();
                k(t)
        }

    def getType(): Chance.RCreditCardType.CreditCardType \ Random2.RandomInt32 = 
        let x = (Vector#{
                        CreditCardType.AmericanExpress,
                        CreditCardType.BankCard,
                        CreditCardType.ChinaUnionPay,
                        CreditCardType.DinersClubInternational,
                        CreditCardType.DinersClubUnitedStatesAndCanada,
                        CreditCardType.DiscoverCard,
                        CreditCardType.InstaPayment,
                        CreditCardType.JCB,
                        CreditCardType.Laser,
                        CreditCardType.Maestro,
                        CreditCardType.Mastercard,
                        CreditCardType.Solo,
                        CreditCardType.Switch,
                        CreditCardType.Visa,
                        CreditCardType.VisaElectron,
                        CreditCardType.Dankort,
                        CreditCardType.VisaDankort
                    });
        run {Pickable.pick(1, x) |> Vector.head |> Option.getWithDefault(CreditCardType.Visa)} with Pick.runWithRandomInt32
}