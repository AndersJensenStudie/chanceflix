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

def main(): Unit \ IO =
    println("Hello")