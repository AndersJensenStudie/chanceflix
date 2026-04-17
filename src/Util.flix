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

    pub def log(x: Float64): Float64 = 
        unsafe IO {
            JMath.log(x)
        }

    pub def sqrt(x: Float64): Float64 = 
        unsafe IO {
            JMath.sqrt(x)
        }
}