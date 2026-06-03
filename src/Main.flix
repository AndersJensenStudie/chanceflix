// The main entry point.
import java.lang.Byte;
import java.lang.Short;

def main(): Unit \ IO =
    println("Hello")

def whatthefuck(): Unit \ IO =
    let lst = List#{0, 1};
    println(List.head(lst))

def rollDice(): Int32 \ {Math.Random} = 
    let r = Math.Random.randomInt64()
    |> (x -> Int64.modulo(x, 6i64) + 1i64)
    |> Int64.tryToInt32;
    match r {
        case Some(x) => x
        case None => unreachable!()
    }

def randomInt64From32(): Int64 \ {Random2.RandomInt32} = 
    let shift = Int32.maxValue()
    |> Int32.toInt64
    |> (x -> (x * 2i64) + 1i64);
    let r1 = Random2.RandomInt32.randomInt32()
    |> Int32.toInt64
    |> Int64.bitwiseAnd(shift)
    |> (x -> Int64.leftShift(x, 32));
    let r2 = Random2.RandomInt32.randomInt32()
    |> Int32.toInt64
    |> Int64.bitwiseAnd(shift);
    Int64.bitwiseOr(r1, r2)


def getRandomInt64WithRandom(): Int64 \ Random2 = 
        Random2.randomBytes(8)
        |> Vector.map(Int8.toInt64 >> Int64.bitwiseAnd(255i64))
        |> (tmp) -> Vector.zip(Vector.range(0, Vector.length(tmp)), tmp)
        |> Vector.map(match (i, b) -> Int64.leftShift(b, i * 8))
        |> Vector.foldLeft(Int64.bitwiseOr, 0i64)


def hof(f: a -> b \ {Sys.Console, Logger} - ef): b = 
    ???