// The main entry point.
import java.lang.Byte;
import java.lang.Short;

def main(): Unit \ IO =
    println("Hello")

def whatthefuck(): Unit \ IO =
    let lst = List#{0, 1};
    println(List.head(lst))