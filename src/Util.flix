pub mod Util {
    import java.lang.{Math => JMath}

    pub def toDigits(i: Int32): List[Int32] = 
        def rec(acc: List[Int32], x: Int32): List[Int32] = 
            if (x == 0) {
                acc
            } else {
                let acc_ = Int32.modulo(x, 10) :: acc;
                rec(acc_, x / 10)
            };
        rec(Nil, i)

    pub def listToInt32(ls: List[Int32]): Int32 = 
        def rec(acc, l): Int32 = 
            match l {
                case Nil => acc
                case x :: xs => rec(x * 10 + acc, xs)
            };
        rec(0, ls)

    pub def printbits(x: Int8): Unit \ IO =
        let map = List.map((i) -> Int8.getBit(pos = i, x), List.reverse(List.range(0, 8)));
        println(map)

    pub def printbits16(x: Int16): Unit \ IO =
        let map = List.map((i) -> Int16.getBit(pos = i, x), List.reverse(List.range(0, 16)));
        println(map)

    pub def printbits32(x: Int32): Unit \ IO =
        let map = List.map((i) -> Int32.getBit(pos = i, x), List.reverse(List.range(0, 32)));
        println(map)


    pub def log(x: Float64): Float64 = 
        unsafe IO {
            JMath.log(x)
        }

    pub def sqrt(x: Float64): Float64 = 
        unsafe IO {
            JMath.sqrt(x)
        }

    pub def exp(x: Float64): Float64 = 
        JMath.exp(x)
}