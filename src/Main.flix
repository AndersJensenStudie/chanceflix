// The main entry point.
import java.lang.Byte;
import java.lang.Short;

def printbits(x: Int8): Unit \ IO =
    let map = List.map((i) -> Int8.getBit(pos = i, x), List.reverse(List.range(0, 8)));
    println(map)

def printbits16(x: Int16): Unit \ IO =
    let map = List.map((i) -> Int16.getBit(pos = i, x), List.reverse(List.range(0, 16)));
    println(map)

def printbits32(x: Int32): Unit \ IO =
    let map = List.map((i) -> Int32.getBit(pos = i, x), List.reverse(List.range(0, 32)));
    println(map)

def conv2xi8toi16(x: Int8, y: Int8): Int16 =
    List.foldLeft(acc -> (i) -> {
        if (i < 8) {???}; ???
    }, 0i16, List.reverse(List.range(0, 16)))


def main(): Unit \ IO =
    println("Hello")